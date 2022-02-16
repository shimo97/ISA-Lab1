LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY Execute IS
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
END Execute;

ARCHITECTURE behavior OF Execute IS

	SIGNAL forward1, forward2 : std_logic_vector(1 downto 0);
	SIGNAL selMux1, selMux2 : std_logic_vector(1 downto 0);
	SIGNAL ALUOp1, ALUOp2 : std_logic_vector(31 downto 0);
	SIGNAL signedRes, signedResALU,signedResSFU : signed(31 downto 0);
	SIGNAL EX_op2ALUbypass : std_logic;
	
	COMPONENT ALU
		PORT(
			OP1 : in signed(31 downto 0); --first operand
			OP2 : in signed(31 downto 0); --second operand
			CTRL : in std_logic_vector(3 downto 0); --ALU control code
			RES : buffer signed(31 downto 0); --output
			zero : out std_logic --result is zero flag
		);
	END COMPONENT;

	COMPONENT ABSV
		PORT(
			OP : in signed(31 downto 0); --operand
			ABSV : out signed(31 downto 0) --modulus
		);
	END COMPONENT;
	
	COMPONENT ForwardingUnit
		GENERIC (N : integer:=5);
		PORT (RS1, RS2 : IN unsigned(N-1 downto 0);
				EX_MEM_RD, MEM_WB_RD : IN unsigned(N-1 downto 0);
				EX_MEM_regwrite, MEM_WB_regwrite : IN std_logic;
				forwardA, forwardB : OUT std_logic_vector(1 downto 0));
	END COMPONENT;

BEGIN

	-- Clear controls block
	EX_op2ALUbypass <= op2ALUbypass and branchStallN;
	EX_branch <= branch and branchStallN;
	EX_regWriteSrc <= regWriteSrc and branchStallN;
	EX_regWrite <= regWrite and branchStallN;
	EX_memtoReg <= memtoReg and branchStallN;
	EX_memRead <= memRead and branchStallN;
	EX_memWrite <= memWrite and branchStallN;

	-- computation of branch address
	BranchAddress <= unsigned(signed(PC) + signed(immediate));
	
	-- Mux ctrl block, computation of the selection signal for the ALU operands multiplexers
	selMux1(1) <= ALUsrc1 or forward1(1);
	selMux1(0) <= ALUsrc1 or ((not forward1(1)) and forward1(0));
	selMux2(1) <= ALUsrc2 or forward2(1);
	selMux2(0) <= ALUsrc2 or ((not forward2(1)) and forward2(0));
	
	-- Multiplexer for first operand
	WITH selMux1 SELECT
		ALUOp1 <= RegOp1 WHEN "00",
			WB_output WHEN "01",
			MEM_ALUResult WHEN "10",
			std_logic_vector(PC) WHEN OTHERS;
			
	-- Multiplexer for first operand
	WITH selMux2 SELECT
		ALUOp2 <= RegOp2 WHEN "00",
			WB_output WHEN "01",
			MEM_ALUResult WHEN "10",
			immediate WHEN OTHERS;

	--Multiplexer for memory write data
	WITH forward2 SELECT
		DataToDMEM <= RegOp2 WHEN "00",
			WB_output WHEN "01",
			MEM_ALUResult WHEN "10",
			RegOp2 WHEN OTHERS;
			
	-- ALU
	mainALU : ALU port map (OP1 => signed(ALUOp1),
									OP2 => signed(ALUOp2),
									CTRL => ALUctrl,
									RES => signedResALU,
									zero => ALUZero);

	-- SFU
	SFU: ABSV port map(OP=>signed(ALUOp1), ABSV=>signedResSFU);
	
	--Multiplexer for ALU/SFU selection
	WITH ALUctrl SELECT
		signedRes<= signedResSFU WHEN "1000",
				signedResALU WHEN OTHERS;

	--Multiplexer for ALU bypass
	WITH EX_op2ALUbypass SELECT
		ALUResult <= std_logic_vector(signedRes) WHEN '0',
			ALUOp2 WHEN OTHERS;
									
	
	-- Forwarding Unit
	FU : ForwardingUnit generic map (5) port map (RS1 => ID_EX_RS1,
							RS2 => ID_EX_RS2,
							EX_MEM_RD => EX_MEM_RD,
							MEM_WB_RD => MEM_WB_RD,
							EX_MEM_regwrite => EX_MEM_regwrite,
							MEM_WB_regwrite => MEM_WB_regwrite,
							forwardA => forward1,
							forwardB => forward2);

END behavior;
