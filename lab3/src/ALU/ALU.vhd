library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
port(
	OP1 : in signed(31 downto 0); --first operand
	OP2 : in signed(31 downto 0); --second operand
	CTRL : in std_logic_vector(3 downto 0); --ALU control code
	
	RES : buffer signed(31 downto 0); --output
	zero : out std_logic --result is zero flag
);
end entity;

architecture beh of ALU is

signal ZERO_COMP : signed(31 downto 0);

begin

ZERO_COMP<=(others => '0');

OP: process(CTRL,OP1,OP2)
begin
	case CTRL is
		when "0000" => --AND
			RES<=OP1 and OP2;
		when "0001" => --XOR
			RES<=OP1 xor OP2;
		when "0010" => --ADD
			RES<=OP1 + OP2;
		when "0011" => --SUB
			RES<=OP1 - OP2;
		when "0100" => --LOWER THAN
			RES<=(others => '0');
			if OP1 < OP2 then
				RES(0)<='1';
			end if;
		when "0101" => --RIGHT ASHIFT
			RES<= shift_right(OP1,to_integer(unsigned(OP2(4 downto 0))));
		when others =>
			--RES<=(others=>'X');
			RES<=(others=>'0');
		
	end case;
end process;

ZP: process(RES)
begin
	if RES = ZERO_COMP then
		zero<='1';
	else
		zero<='0';
	end if;
end process;

end architecture;
