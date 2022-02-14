library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RF is
port(
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
end entity;

architecture beh of RF is

--registers creation
type reg_arr is array(31 downto 0) of std_logic_vector(31 downto 0);
signal reg : reg_arr;

begin

WP: process(CLK,RST_n,W_ADDR,W_OP, WR) --asynchronous reset and synchronous write process

variable i_addr : integer;

begin

if RST_n='0' then
	reg<=(others=>(others=>'0'));
elsif CLK='1' and CLK'EVENT then
	if WR='1' then
		i_addr:=to_integer(W_ADDR);
		if i_addr/=0 then --cannot write on x0
			reg(i_addr)<=W_OP;
		end if;
	end if;
end if;

end process;

RP: process(R_ADDR1,R_ADDR2,reg,RST_n,W_ADDR,W_OP,WR) --asynchronous read process
variable addr : natural;
begin
	if (R_ADDR1 = W_ADDR) and WR='1' and W_ADDR/="00000" then --bypass
		R_OP1 <= W_OP;
	else
		addr:=to_integer(R_ADDR1);
		R_OP1<=reg(addr);
	end if;
	if (R_ADDR2 = W_ADDR) and WR='1' and W_ADDR/="00000" then --bypass
		R_OP2 <= W_OP;
	else
		addr:=to_integer(R_ADDR2);
		R_OP2<=reg(addr);
	end if;
end process;

end architecture;
