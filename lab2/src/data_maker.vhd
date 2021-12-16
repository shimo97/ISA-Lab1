library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.math_real.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity data_maker is
  generic(Nb : integer :=32; --number of data bits
  	  clkdelay : integer :=6);  --latency of filter (from input data sampling to output data sampling, must be >= 2)
  port (
    CLK     : in  std_logic;
    RST_n   : in  std_logic;
    DATA_IN : out std_logic_vector(Nb-1 downto 0);
    VIN     : out std_logic;
    END_SIM : out std_logic);
end data_maker;

architecture beh of data_maker is

  constant tco : time := 1 ns; --T clk to output

  signal sEndSim : std_logic; --simulation ending signal
  signal END_SIM_i : std_logic_vector(0 to clkdelay-1);  --shift register to send simulation end after latency

begin

  -- reading input samples
	process (CLK, RST_n)
		file fp_in : text open READ_MODE is "../fp_samples.hex"; --input file (input samples)
		variable data_in_var : std_logic_vector(Nb-1 downto 0); --correct output read from file
		variable line_in : line;
	begin
		if RST_n = '0' then
			VIN <= '0' after tco; -- resetting signal that indicates available input sample
			sEndSim <= '0' after tco;
		elsif CLK'event and CLK = '1' then  -- rising clock edge
			if not endfile(fp_in) then --check result correctness
				readline(fp_in, line_in);
				hread(line_in, data_in_var);
				DATA_IN <= data_in_var after tco;
				VIN <= '1' after tco; -- after a sample is available vin is set to 1
          			sEndSim <= '0' after tco;
			else
				VIN <= '0' after tco;        
         			sEndSim <= '1' after tco; --starting simulation end (actually ended after latency)
			end if;
		end if;
	end process;

	process (CLK, RST_n) --simulation end shift register process
  	begin  -- process
    		if RST_n = '0' then                 -- asynchronous reset (active low)
      			END_SIM_i <= (others => '0') after tco;
    		elsif CLK'event and CLK = '1' then  -- rising clock edge
      			END_SIM_i(1 to clkdelay-1) <= END_SIM_i(0 to clkdelay-2) after tco; --shifting
      			END_SIM_i(0) <= sEndSim after tco; --inserting
    		end if;
  	end process;

 	END_SIM <= END_SIM_i(clkdelay-1); 

end beh;
