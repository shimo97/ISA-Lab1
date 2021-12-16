library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
use ieee.std_logic_misc.all;

library std;
use std.textio.all;

entity data_sink is
  generic(Nb : integer :=32; --number of data bits
  	  clkdelay : integer :=6);  --latency of filter (from input data sampling to output data sampling, must be >= 2)
  port (
    CLK     : in std_logic;
    RST_n   : in std_logic;
    VIN     : in std_logic;
    DUT_OUT : in std_logic_vector(Nb-1 downto 0);
    ERR     : out std_logic);
end data_sink;

architecture beh of data_sink is

	signal VIN_shift : std_logic_vector(0 to clkdelay-1);  --shift register to propagate VIN
 	constant tco : time := 1 ns; --T clk to output

begin

	-- reading correct results
	process (CLK, RST_n)
		file fp_res : text open READ_MODE is "../fp_prod.hex"; --input file (of output samples)
		variable line_res : line;
		variable correct_out : std_logic_vector(Nb-1 downto 0); --correct output read from file
	begin
		if RST_n = '0' then                 -- asynchronous reset (active low)
			err <= '0';	--resetting error bit
		elsif CLK'event and CLK = '1' then  -- rising clock edge
			if (VIN_shift(clkdelay-1) = '1') then
				if not endfile(fp_res) then --check result correctness
					readline(fp_res, line_res);
					hread(line_res, correct_out);
					if (correct_out /= DUT_OUT) then --if sample is different
						err <= '1';
					end if;
				end if;
			end if;
      		end if;
	end process;

	process (CLK, RST_n) --VIN shift register process
	begin  -- process
    		if RST_n = '0' then                 -- asynchronous reset (active low)
     			VIN_shift <= (others => '0') after tco;
    		elsif CLK'event and CLK = '1' then  -- rising clock edge
     			VIN_shift(1 to clkdelay-1) <= VIN_shift(0 to clkdelay-2) after tco; --shifting
     			VIN_shift(0) <= VIN after tco; --inserting dut VIN
		end if;
  	end process;

end beh;
