LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

-- "Empty" entity.
ENTITY tb_MBE IS
END tb_MBE;

ARCHITECTURE Behavior OF tb_MBE IS

COMPONENT MBE
	PORT (OP1, OP2 : IN unsigned(23 downto 0);
			PROD : OUT unsigned(47 downto 0)
			);
END COMPONENT;

-- TESTBENCH SIGNALS
SIGNAL A, X : unsigned(23 downto 0);
SIGNAL res, correct_res : unsigned(47 downto 0);
SIGNAL err : std_logic;

BEGIN

	data_proc : process
	begin
		A <= to_unsigned(16777215, 24);
		X <= to_unsigned(16777215, 24);
		wait for 20 ns;
		A <= to_unsigned(1254, 24);
		X <= to_unsigned(233, 24);
		wait for 20 ns;
		A <= to_unsigned(7000001, 24);
		X <= to_unsigned(762516, 24);
		wait for 20 ns;
		A <= to_unsigned(8388602, 24);
		X <= to_unsigned(8388526, 24);
		wait for 20 ns;
		A <= to_unsigned(0, 24);
		X <= to_unsigned(2111133, 24);
		wait for 20 ns;
		A <= to_unsigned(1695234, 24);
		X <= to_unsigned(0, 24);
		wait for 20 ns;
		A <= to_unsigned(16777201, 24);
		X <= to_unsigned(16777144, 24);
		wait for 60 ns;
	end process;

	err_proc : process
	begin
		wait for 1 ns;
		if (correct_res = res) then
			err <= '0';
		else
			err <= '1';
		end if;
		wait for 20 ns;
	end process;

	correct_res <= A * X;
	
	-- Device Under Test
	DUT : MBE port map (A, X, res);
	
END behavior;
