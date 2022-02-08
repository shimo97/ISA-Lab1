library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ABSV is
port(
	OP : in signed(31 downto 0); --operand
	ABSV : out signed(31 downto 0) --modulus
);
end entity;

architecture beh of ABSV is

begin

process(OP)
begin
if OP(31)='1' then --if negative we complement it
	ABSV<=not(OP)+1;
else
	ABSV<=OP;
end if;
end process;

end architecture;
