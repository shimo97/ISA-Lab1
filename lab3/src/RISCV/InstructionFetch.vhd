LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY InstructionFetch IS
	GENERIC (I_BASEA : unsigned(31 downto 0) := x"00400000");
	PORT (clock, resetN : std_logic;
			BranchAddress : IN unsigned(31 downto 0);
			ID_EX_incrementedPC : IN unsigned(31 downto 0);
			branch, loadPC, ALUZero : IN std_logic;
			address : OUT unsigned(31 downto 0);
			incrementedPC : BUFFER unsigned(31 downto 0);
			BranchStallN : OUT std_logic);
END InstructionFetch;

ARCHITECTURE behavior OF InstructionFetch IS

	SIGNAL BPUTargetAddress : unsigned(31 downto 0);
	SIGNAL predictedNextPC, recoveredPC, nextPC, PC : unsigned(31 downto 0);
	SIGNAL PV, PV_del, PV_del2, misprediction : std_logic;
	
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

BEGIN

	-- first row of multiplexers
	with PV select
		predictedNextPC <= incrementedPC when '0',
			BPUTargetAddress when others;
	with PV_del2 select
		recoveredPC <= BranchAddress when '0',
			ID_EX_incrementedPC when others;

	-- flipflops for PV
	process (clock, resetN)
	begin
		IF (resetN = '0') THEN
			PV_del <= '0';
			PV_del2 <= '0';
		ELSIF (clock'EVENT and clock = '1') THEN
			PV_del <= PV;
			PV_del2 <= PV_del;
		END IF;
	end process;
		
	-- second row multiplexer
	with misprediction select
		nextPC <= predictedNextPC when '0',
			recoveredPC when others;
					
	-- Program Counter
	PROCESS (clock, resetN)
	BEGIN
		IF (resetN = '0') THEN
			PC <= I_BASEA;
		ELSIF (clock'EVENT AND clock = '1') THEN
			IF (loadPC = '1') THEN
				PC <= nextPC;
			END IF;
		END IF;
	END PROCESS;
	address <= PC;

	-- Computation of next sequential address
	incrementedPC <= PC + to_unsigned(4, 32);
	
	-- Branch Prediction unit
	BPU : BranchPredictor port map(Clock => clock,
					resetN => resetN,
					address => PC(11 downto 2),
					outcome => ALUZero,
					branch => branch,
					correctAddress => BranchAddress,
					targetAddress => BPUTargetAddress,
					misprediction => misprediction,
					PV => PV,
					branchStallN => BranchStallN
					);
	
END behavior;
