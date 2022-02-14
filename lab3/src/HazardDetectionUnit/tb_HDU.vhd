library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_HDU is
end tb_HDU;

architecture beh of tb_HDU is

	COMPONENT HazardDetectionUnit IS
		GENERIC (N : integer:=5);
		PORT (IF_ID_RS1, IF_ID_RS2 : IN unsigned(N-1 downto 0);
				ID_EX_RD : IN unsigned(N-1 downto 0);
				ID_EX_memRead : IN std_logic;
				loadPC, loadIF_ID : OUT std_logic;
				stallControls : OUT std_logic);
	END COMPONENT;
	
	signal rs1, rs2, rd : unsigned(4 downto 0);
	signal memRead, loadPC, loadIF_ID, stallControl : std_logic;
	
BEGIN

	test_proc : process
	begin
		rs1 <= "00000";
		rs2 <= "00010";
		rd <= "11000";
		memRead <= '0';
		wait for 10 ns;
		rs1 <= "00000";
		rs2 <= "00010";
		rd <= "11000";
		memRead <= '1';
		wait for 10 ns;
		rs1 <= "11000";
		rs2 <= "00010";
		rd <= "11000";
		memRead <= '0';
		wait for 10 ns;
		rs1 <= "11000";
		rs2 <= "00010";
		rd <= "11000";
		memRead <= '1';
		wait for 10 ns;
		rs1 <= "00000";
		rs2 <= "11000";
		rd <= "11000";
		memRead <= '1';
		wait for 10 ns;
		rs1 <= "11000";
		rs2 <= "11000";
		rd <= "11000";
		memRead <= '1';
		wait for 10 ns;
		rs1 <= "11000";
		rs2 <= "11000";
		rd <= "11000";
		memRead <= '0';
		wait for 100 ns;
	end process;

	-- DUT
	DUT : HazardDetectionUnit port map (rs1, rs2, rd, memRead, loadPC, loadIF_ID, stallControl);

END beh;