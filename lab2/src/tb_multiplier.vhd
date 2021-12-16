library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
use ieee.std_logic_misc.all;

library std;
use std.textio.all;

entity tb_multiplier is
  generic(Nb : integer := 32; --number of data bits
	clkdelay : integer :=6);  --latency of filter (from input data sampling to output data sampling, must be >= 2)
end tb_multiplier;

architecture beh of tb_multiplier is

	COMPONENT FPmul IS
   PORT( 
      FP_A : IN     std_logic_vector (31 DOWNTO 0);
      FP_B : IN     std_logic_vector (31 DOWNTO 0);
      clk  : IN     std_logic;
      FP_Z : OUT    std_logic_vector (31 DOWNTO 0)
   );
	END COMPONENT;
	
	constant tco : time := 1 ns; --T clk to output
	signal clk, rst_n : std_logic;
	signal err : std_logic;
	signal vin : std_logic;
	signal data_in : std_logic_vector(Nb-1 downto 0); --input samples read from file
	signal result : std_logic_vector(Nb-1 downto 0); --result produced by the DUT
    signal VIN_shift : std_logic_vector(0 to clkdelay-1);  --shift register to propagate VIN
	
begin  -- beh
   rst_proc : process
   begin
   RST_n<='0';
   wait for 30 ns;
   RST_n<='1';
   wait;   
   end process;
   
	clk_proc : process
	begin
		clk <= '1', '0' after 10 ns;
		wait for 20 ns;
	end process;
	
	-- reading input samples
	process (clk, rst_n)
		file fp_in : text open READ_MODE is "../fp_samples.hex"; --input file (input samples)
		variable data_in_var : std_logic_vector(Nb-1 downto 0); --correct output read from file
		variable line_in : line;
	begin
		if rst_n = '0' then
			vin <= '0'; -- resetting signal that indicates available input sample
		elsif clk'event and clk = '1' then  -- rising clock edge
			if not endfile(fp_in) then --check result correctness
				readline(fp_in, line_in);
				hread(line_in, data_in_var);
				data_in <= data_in_var;
				vin <= '1'; -- after a sample is available vin is set to 1
			end if;
		end if;
	end process;

	-- reading correct results
	process (clk, rst_n)
		file fp_res : text open READ_MODE is "../fp_prod.hex"; --input file (of output samples)
		variable line_res : line;
		variable correct_out : std_logic_vector(Nb-1 downto 0); --correct output read from file
	begin
		if rst_n = '0' then                 -- asynchronous reset (active low)
			err <= '0';	--resetting error bit
		elsif clk'event and clk = '1' then  -- rising clock edge
			if (VIN_shift(clkdelay-1) = '1') then
				if not endfile(fp_res) then --check result correctness
					readline(fp_res, line_res);
					hread(line_res, correct_out);
					if (correct_out /= result) then --if sample is different
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
      VIN_shift(0) <= vin after tco; --inserting dut VIN
    end if;
  end process;

	
	--DUT
	DUT : FPmul port map (data_in, data_in, clk, result); 

end beh;
