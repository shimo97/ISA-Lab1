LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY ControlBlock IS
	PORT (opcode : IN std_logic_vector(6 downto 0);
			funct : IN std_logic_vector(2 downto 0);
			Op2ALUbypass, Branch, MemRead, MemtoReg : OUT std_logic;
			ALUOp : OUT std_logic_vector(3 downto 0);
			MemWrite, ALUsrc1, ALUsrc2, RegWrite, RegWriteSrc : OUT std_logic);
END ControlBlock;

ARCHITECTURE structure OF ControlBlock IS

	SIGNAL ALUctrl_funct, ALUctrl_opcode : std_logic_vector(3 downto 0);
	SIGNAL ALUctrl_select : std_logic;

BEGIN

	Op2ALUbypass <= (not opcode(6)) and opcode(5) and opcode(2);
	Branch <= opcode(6);
	MemRead <= (not opcode(5)) and (not opcode(4));
	MemtoReg <= (not opcode(5)) and (not opcode(4));
	MemWrite <= (not opcode(6)) and opcode(5) and (not opcode(4));
	ALUsrc1 <= (not opcode(5)) and opcode(2);
	ALUsrc2 <= (not opcode(5)) or opcode(2) or ((not opcode(6)) and (not opcode(4)));
	RegWrite <= (not opcode(5)) or opcode(4) or opcode(2);
	RegWriteSrc <= opcode(3);	
	
	-- ALU control signals
	ALUctrl_funct(3) <= '0';
	ALUctrl_funct(2) <= ((not funct(1)) and funct(0)) or ((not funct(2)) and funct(1));
	ALUctrl_funct(1) <= not (funct(2) or funct(1));
	ALUctrl_funct(0) <= funct(2) and (not funct(1));
	
	ALUctrl_select <= opcode(4) and (not opcode(2));
	
	ALUctrl_opcode(3) <= opcode(5) and opcode(2);
	ALUctrl_opcode(2) <= '0';
	ALUctrl_opcode(1) <= '1';
	ALUctrl_opcode(0) <= opcode(6);
	
	with ALUctrl_select select
		ALUOp <= ALUctrl_opcode when '0',
					ALUctrl_funct when others;

END structure;
