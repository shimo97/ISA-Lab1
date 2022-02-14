LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY RISC_V IS
	GENERIC (I_BASEA : unsigned(31 downto 0) := x"00400000"); --base address of instructions
	PORT (CLK, RST_n : IN std_logic;
			I_ADDR : out unsigned(31 downto 0);
			I_RE : out std_logic;
			INSTR : in std_logic_vector(31 downto 0);
			D_ADDR : out unsigned(31 downto 0);
			D_RE : out std_logic;
			D_WE : out std_logic;
			DATA_IN : in std_logic_vector(31 downto 0);
			DATA_OUT : out std_logic_vector(31 downto 0));
END RISC_V;

ARCHITECTURE behavior OF RISC_V IS

	SIGNAL IF_ID_PC, IF_ID_incrementedPC : unsigned(31 downto 0);
	SIGNAL IF_ID_instruction : std_logic_vector(31 downto 0);
	SIGNAL loadIF_ID : std_logic;
	SIGNAL PC, incrementedPC : unsigned(31 downto 0);
	SIGNAL ID_EX_incrementedPC, EX_MEM_incrementedPC, MEM_WB_incrementedPC : unsigned(31 downto 0);
	SIGNAL BranchAddress : unsigned(31 downto 0);
	SIGNAL ID_EX_Branch, loadPC, BranchOutcome, BranchStallN : std_logic;
	SIGNAL ID_EX_PC : unsigned(31 downto 0);
	SIGNAL WB_output : std_logic_vector(31 downto 0);
	SIGNAL MEM_WB_RegWriteSrc, MEM_WB_RegWrite, ID_EX_MemRead : std_logic;
	SIGNAL ID_EX_RD, MEM_WB_RD : unsigned(4 downto 0);
	SIGNAL RS1, RS2, RD : unsigned(4 downto 0);
	SIGNAL Op2ALUbypass, branch, memRead, memtoReg, memWrite, ALUsrc1, ALUsrc2, regWrite, regWriteSrc : std_logic;
	SIGNAL ID_EX_Op2ALUbypass : std_logic;
	SIGNAL ID_EX_MemtoReg, ID_EX_MemWrite, ID_EX_ALUsrc1, ID_EX_ALUsrc2, ID_EX_RegWrite, ID_EX_RegWriteSrc : std_logic;
	SIGNAL EX_branch, EX_regWriteSrc, EX_regWrite, EX_memtoReg, EX_memRead, EX_memWrite : std_logic;
	SIGNAL ALUctrl, ID_EX_ALUctrl : std_logic_vector(3 downto 0);
	SIGNAL readData1, readData2, immediate : std_logic_vector(31 downto 0);
	SIGNAL ID_EX_readData1, ID_EX_readData2, ID_EX_immediate : std_logic_vector(31 downto 0);
	SIGNAL ID_EX_RS1, ID_EX_RS2 : unsigned(4 downto 0);
	SIGNAL ALUResult, EX_MEM_ALUResult, EX_result : std_logic_vector(31 downto 0);
	SIGNAL EX_MEM_RD : unsigned(4 downto 0);
	SIGNAL MEMWriteData, EX_MEMWriteData : std_logic_vector(31 downto 0);
	SIGNAL EX_MEM_MemRead, EX_MEM_MemtoReg, EX_MEM_MemWrite, EX_MEM_RegWrite, EX_MEM_RegWriteSrc : std_logic;
	SIGNAL MEM_WB_MemtoReg : std_logic;
	SIGNAL MEM_WB_ReadData, MEM_WB_Result : std_logic_vector(31 downto 0);

	COMPONENT InstructionFetch
		GENERIC (I_BASEA : unsigned(31 downto 0) := x"00400000");
		PORT (clock, resetN : std_logic;
				BranchAddress : IN unsigned(31 downto 0);
				ID_EX_incrementedPC : IN unsigned(31 downto 0);
				branch, loadPC, ALUZero : IN std_logic;
				address : OUT unsigned(31 downto 0);
				incrementedPC : BUFFER unsigned(31 downto 0);
				BranchStallN : OUT std_logic);
	END COMPONENT;
	
	COMPONENT InstructionDecode
		PORT (clock, resetN : std_logic;
				instruction : IN std_logic_vector(31 downto 0);
				incrementedPC : IN unsigned(31 downto 0);
				WB_output : IN std_logic_vector(31 downto 0);
				MEM_WB_RegWriteSrc : IN std_logic;
				MEM_WB_RegWrite : IN std_logic;
				MEM_WB_RD : IN unsigned(4 downto 0);
				ID_EX_RD : IN unsigned(4 downto 0);
				ID_EX_MemRead : IN std_logic;
				RS1, RS2, RD : BUFFER unsigned(4 downto 0);
				loadPC, loadIF_ID : OUT std_logic;
				Op2ALUbypass, branch, memRead, memtoReg : OUT std_logic;
				ALUctrl : OUT std_logic_vector(3 downto 0);
				memWrite, ALUsrc1, ALUsrc2, regWrite, regWriteSrc : OUT std_logic;
				OP1, OP2 : OUT std_logic_vector(31 downto 0);
				immediate : OUT std_logic_vector(31 downto 0));
	END COMPONENT;
	
	COMPONENT Execute
		PORT (PC : IN unsigned(31 downto 0);
				immediate : IN std_logic_vector(31 downto 0);
				ALUsrc1, ALUsrc2 : IN std_logic;
				RegOp1, RegOp2 : IN std_logic_vector(31 downto 0);
				WB_output : IN std_logic_vector(31 downto 0);
				op2ALUbypass : IN std_logic;
				branch : IN std_logic;
				regWriteSrc : IN std_logic;
				regWrite : IN std_logic;
				memtoReg : IN std_logic;
				memRead : IN std_logic;
				memWrite : IN std_logic;
				branchStallN : IN std_logic;
				MEM_ALUResult : IN std_logic_vector(31 downto 0);
				ALUctrl : IN std_logic_vector(3 downto 0);
				ID_EX_RS1, ID_EX_RS2 : IN unsigned(4 downto 0);
				EX_MEM_RD, MEM_WB_RD : IN unsigned(4 downto 0);
				EX_MEM_regwrite, MEM_WB_regwrite : IN std_logic;
				EX_branch : OUT std_logic;
				EX_regWriteSrc : OUT std_logic;
				EX_regWrite : OUT std_logic;
				EX_memtoReg : OUT std_logic;
				EX_memRead : OUT std_logic;
				EX_memWrite : OUT std_logic;
				BranchAddress : OUT unsigned(31 downto 0);
				ALUResult : OUT std_logic_vector(31 downto 0);
				ALUZero : OUT std_logic;
				DataToDMEM : OUT std_logic_vector(31 downto 0));
	END COMPONENT;
	
	COMPONENT Writeback
		PORT (MEMReadData : IN std_logic_vector(31 downto 0);
				ALUResult : IN std_logic_vector(31 downto 0);
				MemtoReg : IN std_logic;
				RegWriteData : OUT std_logic_vector(31 downto 0));
	END COMPONENT;

BEGIN

	-- Instruction Fetch
	IF_stage : InstructionFetch port map (clock => CLK,
						resetN => RST_n,
						BranchAddress => BranchAddress,
						ID_EX_incrementedPC => ID_EX_incrementedPC,
						branch => EX_branch,
						loadPC => loadPC,
						ALUZero => BranchOutcome,
						address => PC,
						incrementedPC => incrementedPC,
						BranchStallN => BranchStallN);
	I_ADDR <= PC;
	I_RE <= '1';
													
	-- IF/ID Pipe Register
	PROCESS (CLK, RST_n)
	BEGIN
		IF (RST_n = '0') THEN
			IF_ID_PC <= (OTHERS => '0');
			IF_ID_incrementedPC <= (OTHERS => '0');
			IF_ID_instruction <= (OTHERS => '0');
		ELSIF (CLK'EVENT AND CLK = '1') THEN
			IF (loadIF_ID = '1') THEN
				IF_ID_PC <= PC;
				IF_ID_incrementedPC <= incrementedPC;
				IF_ID_instruction <= INSTR;
			END IF;
		END IF;
	END PROCESS;
	
	-- Instruction Decode
	ID_stage : InstructionDecode port map (clock => CLK,
						resetN => RST_n,
						instruction => IF_ID_instruction,
						incrementedPC => MEM_WB_incrementedPC,
						WB_output => WB_output,
						MEM_WB_RegWriteSrc => MEM_WB_RegWriteSrc,
						MEM_WB_RegWrite => MEM_WB_RegWrite,
						MEM_WB_RD => MEM_WB_RD,
						ID_EX_RD => ID_EX_RD,
						ID_EX_MemRead => EX_memRead,
						RS1 => RS1,
						RS2 => RS2,
						RD => RD,
						loadPC => loadPC,
						loadIF_ID => loadIF_ID,
						Op2ALUbypass => Op2ALUbypass,
						branch => branch,
						memRead => memRead,
						memtoReg => memtoReg,
						ALUctrl => ALUctrl,
						memWrite => memWrite,
						ALUsrc1 => ALUsrc1,
						ALUsrc2 => ALUsrc2,
						regWrite => regWrite,
						regWriteSrc => regWriteSrc,
						OP1 => readData1,
						OP2 => readData2,
						immediate => immediate);
														
	-- ID/EX Pipe Register
	PROCESS (CLK, RST_n)
	BEGIN
		IF (RST_n = '0') THEN
			ID_EX_PC <= (OTHERS => '0');
			ID_EX_Op2ALUbypass <= '0';
			ID_EX_Branch <= '0';
			ID_EX_MemRead <= '0';
			ID_EX_MemtoReg <= '0';
			ID_EX_MemWrite <= '0';
			ID_EX_ALUsrc1 <= '0';
			ID_EX_ALUsrc2 <= '0';
			ID_EX_RegWrite <= '0';
			ID_EX_RegWriteSrc <= '0';
			ID_EX_incrementedPC <= (OTHERS => '0');
			ID_EX_ALUctrl <= (OTHERS => '0');
			ID_EX_readData1 <= (OTHERS => '0');
			ID_EX_readData2 <= (OTHERS => '0');
			ID_EX_immediate <= (OTHERS => '0');
			ID_EX_RS1 <= (OTHERS => '0');
			ID_EX_RS2 <= (OTHERS => '0');
			ID_EX_RD <= (OTHERS => '0');
		ELSIF (CLK'EVENT AND CLK = '1') THEN
			ID_EX_PC <= IF_ID_PC;
			ID_EX_Op2ALUbypass <= Op2ALUbypass;
			ID_EX_Branch <= branch;
			ID_EX_MemRead <= memRead;
			ID_EX_MemtoReg <= memtoReg;
			ID_EX_MemWrite <= memWrite;
			ID_EX_ALUsrc1 <= ALUsrc1;
			ID_EX_ALUsrc2 <= ALUsrc2;
			ID_EX_RegWrite <= regWrite;
			ID_EX_RegWriteSrc <= regWriteSrc;
			ID_EX_incrementedPC <= IF_ID_incrementedPC;
			ID_EX_ALUctrl <= ALUctrl;
			ID_EX_readData1 <= readData1;
			ID_EX_readData2 <= readData2;
			ID_EX_immediate <= immediate;
			ID_EX_RS1 <= RS1;
			ID_EX_RS2 <= RS2;
			ID_EX_RD <= RD;
		END IF;
	END PROCESS;
	
	-- Execute
	EX_stage : Execute port map (PC => ID_EX_PC,
					immediate => ID_EX_immediate,
					ALUsrc1 => ID_EX_ALUsrc1,
					ALUsrc2 => ID_EX_ALUsrc2,
					RegOp1 => ID_EX_readData1,
					RegOp2 => ID_EX_readData2,
					WB_output => WB_output,
					op2ALUbypass => ID_EX_Op2ALUbypass,
					branch => ID_EX_Branch,
					regWriteSrc => ID_EX_RegWriteSrc,
					regWrite => ID_EX_RegWrite,
					memtoReg => ID_EX_MemtoReg,
					memRead => ID_EX_MemRead,
					memWrite => ID_EX_MemWrite,
					branchStallN => BranchStallN,
					MEM_ALUResult => EX_MEM_ALUResult,
					ALUctrl => ID_EX_ALUctrl,
					ID_EX_RS1 => ID_EX_RS1,
					ID_EX_RS2 => ID_EX_RS2,
					EX_MEM_RD => EX_MEM_RD,
					MEM_WB_RD => MEM_WB_RD,
					EX_MEM_regwrite => EX_MEM_RegWrite,
					MEM_WB_regwrite => MEM_WB_RegWrite,
					EX_branch => EX_branch,
					EX_regWriteSrc => EX_regWriteSrc,
					EX_regWrite => EX_regWrite,
					EX_memtoReg => EX_memtoReg,
					EX_memRead => EX_memRead,
					EX_memWrite => EX_memWrite,
					BranchAddress => BranchAddress,
					ALUResult => ALUResult,
					ALUZero => BranchOutcome,
					DataToDMEM => MEMWriteData);
										
	-- EX/MEM Pipe Register
	PROCESS (CLK, RST_n)
	BEGIN
		IF (RST_n = '0') THEN
			EX_MEM_MemRead <= '0';
			EX_MEM_MemtoReg <= '0';
			EX_MEM_MemWrite <= '0';
			EX_MEM_RegWrite <= '0';
			EX_MEM_RegWriteSrc <= '0';
			EX_MEM_incrementedPC <= (OTHERS => '0');
			EX_MEM_ALUResult <= (OTHERS => '0');
			EX_MEMWriteData <= (OTHERS => '0');
			EX_MEM_RD <= (OTHERS => '0');
		ELSIF (CLK'EVENT AND CLK = '1') THEN
			EX_MEM_MemRead <= EX_memRead;
			EX_MEM_MemtoReg <= EX_memtoReg;
			EX_MEM_MemWrite <= EX_memWrite;
			EX_MEM_RegWrite <= EX_regWrite;
			EX_MEM_RegWriteSrc <= EX_regWriteSrc;
			EX_MEM_incrementedPC <= ID_EX_incrementedPC;
			EX_MEM_ALUResult <= ALUResult;
			EX_MEMWriteData <= MEMWriteData;
			EX_MEM_RD <= ID_EX_RD;
		END IF;
	END PROCESS;
	
	-- Memory Access
	D_ADDR <= unsigned(EX_MEM_ALUResult);
	D_RE <= EX_MEM_MemRead;
	D_WE <= EX_MEM_MemWrite;
	DATA_OUT <= EX_MEMWriteData;
	
	-- MEM/WB Pipe Register
	PROCESS (CLK, RST_n)
	BEGIN
		IF (RST_n = '0') THEN
			MEM_WB_MemtoReg <= '0';
			MEM_WB_RegWrite <= '0';
			MEM_WB_RegWriteSrc <= '0';
			MEM_WB_incrementedPC <= (OTHERS => '0');
			MEM_WB_ReadData <= (OTHERS => '0');
			MEM_WB_Result <= (OTHERS => '0');
			MEM_WB_RD <= (OTHERS => '0');
		ELSIF (CLK'EVENT AND CLK = '1') THEN
			MEM_WB_MemtoReg <= EX_MEM_MemtoReg;
			MEM_WB_RegWrite <= EX_MEM_RegWrite;
			MEM_WB_RegWriteSrc <= EX_MEM_RegWriteSrc;
			MEM_WB_incrementedPC <= EX_MEM_incrementedPC;
			MEM_WB_ReadData <= DATA_IN;
			MEM_WB_Result <= EX_MEM_ALUResult;
			MEM_WB_RD <= EX_MEM_RD;
		END IF;
	END PROCESS;
	
	-- Writeback
	WB_stage : Writeback port map (MEMReadData => MEM_WB_ReadData,
											ALUResult => MEM_WB_Result,
											MemtoReg => MEM_WB_MemtoReg,
											RegWriteData => WB_output);

END behavior;
