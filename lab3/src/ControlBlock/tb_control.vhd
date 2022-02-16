library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_control is
end tb_control;

architecture beh of tb_control is

	COMPONENT ControlBlock IS
		PORT (opcode : IN std_logic_vector(6 downto 0);
			funct : IN std_logic_vector(2 downto 0);
			Op2ALUbypass, Branch, MemRead, MemtoReg : OUT std_logic;
			ALUOp : OUT std_logic_vector(3 downto 0);
			MemWrite, ALUsrc1, ALUsrc2, RegWrite, RegWriteSrc : OUT std_logic);
	END COMPONENT;
	
	signal opcode : std_logic_vector(6 downto 0);
	signal funct : std_logic_vector(2 downto 0);
	signal op2ALUbypass, branch, memRead, memtoReg, memWrite, ALUsrc1, ALUsrc2, regWrite, regWriteSrc : std_logic;
	signal ALUop : std_logic_vector(3 downto 0);
	
BEGIN

	test_proc : process
	begin
		opcode <= "0110011";
		funct <= "000";
		wait for 10 ns;
		opcode <= "0010011";
		wait for 10 ns;
		opcode <= "0010111";
		wait for 10 ns;
		opcode <= "0110111";
		wait for 10 ns;
		opcode <= "1100011";
		wait for 10 ns;
		opcode <= "0000011";
		funct <= "010";
		wait for 10 ns;
		opcode <= "0010011";
		funct <= "101";
		wait for 10 ns;
		opcode <= "0010011";
		funct <= "111";
		wait for 10 ns;
		opcode <= "0110011";
		funct <= "100";
		wait for 10 ns;
		opcode <= "0110011";
		funct <= "010";
		wait for 10 ns;
		opcode <= "1101111";
		wait for 10 ns;
		opcode <= "0100011";
		wait for 10 ns;
	end process;

	-- DUT
	DUT : ControlBlock port map (opcode, funct, op2ALUbypass, branch, memRead, memtoReg, ALUop, memWrite, ALUsrc1, ALUsrc2, regWrite, regWriteSrc);

END beh;