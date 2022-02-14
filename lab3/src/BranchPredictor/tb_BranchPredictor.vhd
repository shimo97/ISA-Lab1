library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity tb_BranchPredictor is
end tb_BranchPredictor;

architecture beh of tb_BranchPredictor is

	COMPONENT BranchPredictor
	PORT (clock, resetN : std_logic;
			address : IN unsigned(9 downto 0);
			outcome : IN std_logic;
			branch : IN std_logic;
			correctAddress : IN unsigned(31 downto 0);
			targetAddress : BUFFER unsigned(31 downto 0);
			misprediction : BUFFER std_logic;
			PV : OUT std_logic;
			branchStallN : OUT std_logic);
	END COMPONENT;
	
	signal clk : std_logic := '0';
	signal rstN : std_logic;
	signal address : unsigned(9 downto 0);
	signal correctAddress, targetAddress : unsigned(31 downto 0);
	signal branch, outcome, misprediction, pv, branchStallN : std_logic;
	signal correctPV, correctPV_del, correctPV_del2, correctPV_del3, outcome_del, branch_del : std_logic;
	signal CA_del, CA_del2 : unsigned(31 downto 0);
	signal pipeStalled : std_logic;
	signal ERR : std_logic;
	signal end_sim : std_logic;
	signal TA_err : integer;
	-- TA_err equal to one is accepted because the correct target address is changed at a certain point to check if
	-- the branch predictor updates the target address, so if it works also in case of aliasing. Then it can be accepted
	-- a TA_err higher than one only if it is incremented after a misprediction and so the BTB could not be updated, 
	-- because it is done after the evaluation of the current branch
	
BEGIN

	clk_proc : process
	begin
		wait for 10 ns;
		clk <= not(clk) and (not end_sim);
	end process;
	
	rstN <= '0', '1' after 13 ns;

	read_file : process (clk, rstN)
	file fp_in : text open READ_MODE is "input.txt"; --input file
	variable line_in : line;
	variable x : integer;
	begin
		IF (rstN = '0') THEN
			address <= (OTHERS => '0');
			correctAddress <= (OTHERS => '0');
			branch <= '0';
			outcome <= '0';
			correctPV <= '0';
			end_sim <= '0';
		ELSIF (clk'EVENT AND clk = '1') THEN
			if not endfile(fp_in) then
				readline(fp_in, line_in);
				read(line_in, x);
				address <= to_unsigned(x, 10) after 3 ns;
				read(line_in, x);
				branch <= to_unsigned(x, 1)(0) after 3 ns;
				read(line_in, x);
				outcome <= to_unsigned(x, 1)(0) after 3 ns;
				read(line_in, x);
				correctAddress <= to_unsigned(x, 32) after 3 ns;
				read(line_in, x);
				correctPV <= to_unsigned(x, 1)(0) after 3 ns;
			else
				end_sim <= '1' after 3 ns; -- simulation is stopped when the whole file has been read
			end if;
		END IF;
	end process;

	test_proc : process (clk, rstN)
	begin
		IF (rstN = '0') THEN
			pipeStalled <= '0';
			ERR <= '0';
			TA_err <= 0;
		ELSIF (clk'EVENT AND clk = '0') THEN
			if (correctPV /= pv) then -- control if predicted value is correct
				ERR <= '1';
			else
				if (pv = '1') then
					if (correctAddress /= targetAddress) then -- in case of branch taken prediction control if target address is correct
						TA_err <= TA_err + 1;
					end if;
				end if;
			end if;
			if (branch_del = '1') then
				if (outcome_del /= correctPV_del3) then -- in case of misprediction control if the pipe is stalled
					if (branchStallN /= '0') then
						ERR <= '1';
					else
						pipeStalled <= '1';
					end if;
				end if;
			elsif (pipeStalled = '1') then -- control that the pipe is stalled for two consecutive cycles
				pipeStalled <= '0';
				if (branchStallN /= '0') then
					ERR <= '1';
				end if;
			end if;
		END IF;
	end process;
	
	-- correct pv delayed to control if the branch predictor stalls correctly the pipe in case of misprediction
	-- correctAddress delayed to be provided to the BTB to update itself after a misprediction
	PROCESS (clk, rstN)
	BEGIN
		IF (rstN = '0') THEN
			branch_del <= '0';
			correctPV_del <= '0';
			CA_del <= (OTHERS => '0');
		ELSIF (clk'EVENT AND clk = '1') THEN
			branch_del <= branch;
			correctPV_del <= correctPV;
			CA_del <= correctAddress;
		END IF;
	END PROCESS;
	PROCESS (clk, rstN)
	BEGIN
		IF (rstN = '0') THEN
			correctPV_del2 <= '0';
			CA_del2 <= (OTHERS => '0');
		ELSIF (clk'EVENT AND clk = '1') THEN
			correctPV_del2 <= correctPV_del;
			CA_del2 <= CA_del;
		END IF;
	END PROCESS;
	PROCESS (clk, rstN)
	BEGIN
		IF (rstN = '0') THEN
			correctPV_del3 <= '0';
			outcome_del <= '0';
		ELSIF (clk'EVENT AND clk = '1') THEN
			correctPV_del3 <= correctPV_del2;
			outcome_del <= outcome;
		END IF;
	END PROCESS;

	-- DUT
	DUT : BranchPredictor port map (clk, rstN, address, outcome, branch, CA_del2, targetAddress, misprediction, pv, branchStallN);

END beh;
