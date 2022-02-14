LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY Writeback IS
	PORT (MEMReadData : IN std_logic_vector(31 downto 0);
			ALUResult : IN std_logic_vector(31 downto 0);
			MemtoReg : IN std_logic;
			RegWriteData : OUT std_logic_vector(31 downto 0));
END Writeback;

ARCHITECTURE behavior OF Writeback IS

BEGIN

	with MemtoReg select
		RegWriteData <= ALUResult when '0',
							MEMReadData when others;

END behavior;