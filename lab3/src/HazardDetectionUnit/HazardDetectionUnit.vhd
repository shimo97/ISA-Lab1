LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY HazardDetectionUnit IS
	GENERIC (N : integer:=5);
	PORT (IF_ID_RS1, IF_ID_RS2 : IN unsigned(N-1 downto 0);
			ID_EX_RD : IN unsigned(N-1 downto 0);
			ID_EX_memRead : IN std_logic;
			loadPC, loadIF_ID : OUT std_logic;
			stallControls : OUT std_logic);
END HazardDetectionUnit;

ARCHITECTURE behavior OF HazardDetectionUnit IS

BEGIN

	PROCESS (IF_ID_RS1, IF_ID_RS2, ID_EX_RD, ID_EX_memRead)
	BEGIN
		-- default values
		loadPC <= '1';
		loadIF_ID <= '1';
		stallControls <= '1';
		-- in case of a load use hazard a stll in the pipe is inserted
		IF (ID_EX_memRead = '1') THEN
			IF ((IF_ID_RS1 = ID_EX_RD) or (IF_ID_RS2 = ID_EX_RD)) THEN
				loadPC <= '0'; -- PC is not loaded so the same address is fetched again
				loadIF_ID <= '0'; -- IF_ID register is not loaded so same instruction is decoded again
				stallControls <= '0'; -- EX, MEM and WB stages do no operation so all control signals at 0
			END IF;
		END IF;
	END PROCESS;


END behavior;