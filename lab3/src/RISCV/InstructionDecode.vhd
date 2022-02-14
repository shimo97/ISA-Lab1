LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY InstructionDecode IS
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
END InstructionDecode;

ARCHITECTURE behavior OF InstructionDecode IS

	SIGNAL dataToWrite : std_logic_vector(31 downto 0);
	SIGNAL loadUseStall : std_logic;
	SIGNAL Op2ALUbypass_tmp, branch_tmp, memRead_tmp, memtoReg_tmp : std_logic;
	SIGNAL memWrite_tmp, ALUsrc1_tmp, ALUsrc2_tmp, regWrite_tmp, regWriteSrc_tmp : std_logic;
	SIGNAL clearControlsN : std_logic;
	
	COMPONENT HazardDetectionUnit
		GENERIC (N : integer:=5);
		PORT (IF_ID_RS1, IF_ID_RS2 : IN unsigned(N-1 downto 0);
				ID_EX_RD : IN unsigned(N-1 downto 0);
				ID_EX_memRead : IN std_logic;
				loadPC, loadIF_ID : OUT std_logic;
				stallControls : OUT std_logic);
	END COMPONENT;
	
	COMPONENT ControlBlock
		PORT (opcode : IN std_logic_vector(6 downto 0);
				funct : IN std_logic_vector(2 downto 0);
				Op2ALUbypass, Branch, MemRead, MemtoReg : OUT std_logic;
				ALUOp : OUT std_logic_vector(3 downto 0);
				MemWrite, ALUsrc1, ALUsrc2, RegWrite, RegWriteSrc : OUT std_logic);
	END COMPONENT;
	
	COMPONENT RF
		PORT(
			--clk and reset
			RST_n : in std_logic;
			CLK : in std_logic;
			--addresses
			R_ADDR1 : in unsigned(4 downto 0); --first read address
			R_ADDR2 : in unsigned(4 downto 0); --second read address
			W_ADDR : in unsigned(4 downto 0); --write address
			--operands
			R_OP1 : out std_logic_vector(31 downto 0); --first output operand
			R_OP2 : out std_logic_vector(31 downto 0); --first output operand
			W_OP : in std_logic_vector(31 downto 0); --write operand
			--commands
			WR : in std_logic --write command
		);
	END COMPONENT;
	
	COMPONENT IMM_GEN is
		PORT(
			INSTR : in unsigned(31 downto 0); --first operand
			IMM : out std_logic_vector(31 downto 0) --second operand
		);
	END COMPONENT;

BEGIN

	RS1 <= unsigned(instruction(19 downto 15));
	RS2 <= unsigned(instruction(24 downto 20));
	RD <= unsigned(instruction(11 downto 7));

	-- write data multiplexer
	with MEM_WB_RegWriteSrc select
		dataToWrite <= WB_output when '0',
							std_logic_vector(incrementedPC) when others;
							
	-- Hazard detection unit
	HDU : HazardDetectionUnit generic map (5) port map (IF_ID_RS1 => RS1,
							IF_ID_RS2 => RS2,
							ID_EX_RD => ID_EX_RD,
							ID_EX_memRead => ID_EX_MemRead,
							loadPC => loadPC,
							loadIF_ID => loadIF_ID,
							stallControls => loadUseStall);
																		
	-- Control Block
	CB : ControlBlock port map (opcode => instruction(6 downto 0),
					funct => instruction(14 downto 12),
					Op2ALUbypass => Op2ALUbypass_tmp,
					Branch => branch_tmp,
					MemRead => memRead_tmp,
					MemtoReg => memtoReg_tmp,
					ALUOp => ALUctrl,
					MemWrite => memWrite_tmp,
					ALUsrc1 => ALUsrc1_tmp,
					ALUsrc2 => ALUsrc2_tmp,
					RegWrite => regWrite_tmp,
					RegWriteSrc => regWriteSrc_tmp);							
	-- Clear controls block
	process (instruction(6 downto 0), loadUseStall)
	begin
		if (instruction(6 downto 0) = "0000000") then -- clear control signals in reset state
			clearControlsN <= '0';
		else
			clearControlsN <= loadUseStall; -- controls are set to 0 if there is a load-use stall
		end if;
	end process;
	
	Op2ALUbypass <= Op2ALUbypass_tmp and clearControlsN;
	branch <= branch_tmp and clearControlsN;
	memRead <= memRead_tmp and clearControlsN;
	memtoReg <= memtoReg_tmp and clearControlsN;
	memWrite <= memWrite_tmp and clearControlsN;
	ALUsrc1 <= ALUsrc1_tmp and clearControlsN;
	ALUsrc2 <= ALUsrc2_tmp and clearControlsN;
	regWrite <= regWrite_tmp and clearControlsN;
	regWriteSrc <= regWriteSrc_tmp and clearControlsN;
	
	-- Register File
	RegFile : RF port map (RST_n => resetN,
				CLK => clock,
				R_ADDR1 => RS1,
				R_ADDR2 => RS2,
				W_ADDR => MEM_WB_RD,
				R_OP1 => OP1,
				R_OP2 => OP2,
				W_OP => dataToWrite,
				WR => MEM_WB_RegWrite);
								
	-- Immediate Generator
	IG : IMM_GEN port map (INSTR => unsigned(instruction), IMM => immediate);

END behavior;
