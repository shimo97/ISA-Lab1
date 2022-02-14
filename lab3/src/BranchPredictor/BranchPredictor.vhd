LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY BranchPredictor IS
	PORT (clock, resetN : std_logic;
			address : IN unsigned(9 downto 0);
			outcome : IN std_logic;
			branch : IN std_logic;
			correctAddress : IN unsigned(31 downto 0);
			targetAddress : BUFFER unsigned(31 downto 0);
			misprediction : BUFFER std_logic;
			PV : OUT std_logic;
			branchStallN : OUT std_logic);
END BranchPredictor;

ARCHITECTURE behavior OF BranchPredictor IS

	TYPE t_predictionTable is array (0 to (2**10)-1) of std_logic_vector(0 to 1);
	SIGNAL BHT : t_predictionTable;
	TYPE t_targetBuffer is array (0 to (2**10)-1) of unsigned(31 downto 0);
	SIGNAL BTB : t_targetBuffer;
	SIGNAL BHT_out, newBHT : std_logic_vector(0 to 1);
	SIGNAL address_del, lastBranchAddress : unsigned(9 downto 0);
	SIGNAL ta_lastbranch, TA_del : unsigned(31 downto 0);
	SIGNAL wrong_TA : std_logic;
	SIGNAL ffA, ffB, nextffA, nextffB : std_logic;
	SIGNAL PV_lastbranch, PV_del : std_logic_vector(0 to 1);

BEGIN

	-- registers to store the value of the branch prediction for the last branch address
	-- this predicted value is used to update the BHT according to the branch outcome
	PROCESS (clock, resetN)
	BEGIN
		IF (resetN = '0') THEN
			PV_del <= (OTHERS => '0');
		ELSIF (clock'EVENT AND clock = '1') THEN
			PV_del <= BHT_out;
		END IF;
	END PROCESS;
	PROCESS (clock, resetN)
	BEGIN
		IF (resetN = '0') THEN
			PV_lastbranch <= (OTHERS => '0');
		ELSIF (clock'EVENT AND clock = '1') THEN
			PV_lastbranch <= PV_del;
		END IF;
	END PROCESS;
	-- BHT updated in order to change prediction after two mispredictions
	newBHT(0) <= (outcome and PV_lastbranch(1)) or (outcome and PV_lastbranch(0)) or (PV_lastbranch(1) and PV_lastbranch(0));
	newBHT(1) <= (outcome and (not PV_lastbranch(1))) or (outcome and PV_lastbranch(0)) or ((not PV_lastbranch(1)) and PV_lastbranch(0));
	
	-- chain of two registers to store the value of the address of the branch that is currently in the execute stage
	-- this address is then used to update the BHT and target address in case of misprediction of that branch
	PROCESS (clock, resetN)
	BEGIN
		IF (resetN = '0') THEN
			address_del <= (OTHERS => '0');
		ELSIF (clock'EVENT AND clock = '1') THEN
			address_del <= address;
		END IF;
	END PROCESS;
	PROCESS (clock, resetN)
	BEGIN
		IF (resetN = '0') THEN
			lastBranchAddress <= (OTHERS => '0');
		ELSIF (clock'EVENT AND clock = '1') THEN
			lastBranchAddress <= address_del;
		END IF;
	END PROCESS;

	-- Branch history table
	write_P : PROCESS (clock, resetN)
	BEGIN
		IF (resetN = '0') THEN
			BHT <= (OTHERS => (OTHERS => '0'));
			BTB <= (OTHERS => (OTHERS => '0'));
			--BHT_out <= "00";
		ELSIF (clock'EVENT AND clock = '1') THEN
			IF (branch = '1') THEN
				BHT(to_integer(lastBranchAddress)) <= newBHT;
				BTB(to_integer(lastBranchAddress)) <= correctAddress;
			END IF;
		END IF;
	END PROCESS;

	Read_P : PROCESS (address, lastBranchAddress, ffA, newBHT, correctAddress, resetN)
	BEGIN
		IF ((address = lastBranchAddress) and (ffA = '1')) THEN -- bypass PV and TA if address is the same of two cycles before
			BHT_out <= newBHT;
			targetAddress <= correctAddress;
		ELSE -- normal read
			BHT_out <= BHT(to_integer(address));
			targetAddress <= BTB(to_integer(address));
		END IF;
	END PROCESS;
	
	-- branch is predicted to be taken if PV=1
	PV <= BHT_out(0);
	
	-- control if predicted target address was correct
	-- target address could be wrong at the first occurrence of a branch and if two branches addresses share the
	-- same BTB location (aliasing)
	PROCESS (clock, resetN)
	BEGIN
		IF (resetN = '0') THEN
			TA_del <= (OTHERS => '0');
			ta_lastbranch <= (OTHERS => '0');
		ELSIF (clock'EVENT AND clock = '1') THEN
			TA_del <= targetAddress;
			ta_lastbranch <= TA_del;
		END IF;
	END PROCESS;
	PROCESS (ta_lastbranch, correctAddress)
	BEGIN
		wrong_TA <= '0';
		IF (ta_lastbranch /= correctAddress) THEN
			wrong_TA <= '1';
		END IF;
	END PROCESS;
	
	-- in case of mispredicted branch pipe has to be flushed
	-- when branchStallN=1 no bubbles have to be inserted, while when a misprediction occur branchStallN=0 for two cycles
	-- so instructions that were at fetch and decode stage are discarded
	-- state machine that keeps branchStallN=0 for two cycles when a misprediction occurs
	PROCESS (clock, resetN)
	BEGIN
		IF (resetN = '0') THEN
			ffA <= '1';
		ELSIF (clock'EVENT AND clock = '1') THEN
			ffA <= nextffA;
		END IF;
	END PROCESS;
	PROCESS (clock, resetN)
	BEGIN
		IF (resetN = '0') THEN
			ffB <= '0';
		ELSIF (clock'EVENT AND clock = '1') THEN
			ffB <= nextffB;
		END IF;
	END PROCESS;
	misprediction <= branch and ((outcome xor PV_lastbranch(0)) or (outcome and wrong_TA)); -- insert stall on pipe only in case of misprediction or wrong target address
	nextffA <= (ffA and (not misprediction)) or ffB;
	nextffB <= ffA nor ffB;
	branchStallN <= ffA;

END behavior;
