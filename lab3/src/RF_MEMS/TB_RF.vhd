library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TB_RF is
end entity;

architecture beh of TB_RF is

component RF
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
end component;

--dut signals
signal RST_n : std_logic:='0';
signal CLK : std_logic:='0';
signal R_ADDR1 : unsigned(4 downto 0):=(others=>'0'); --first read address
signal R_ADDR2 : unsigned(4 downto 0):=(others=>'0'); --second read address
signal W_ADDR : unsigned(4 downto 0):=(others=>'0'); --write address
signal R_OP1 : std_logic_vector(31 downto 0); --first output operand
signal R_OP2 : std_logic_vector(31 downto 0); --first output operand
signal W_OP : std_logic_vector(31 downto 0); --write operand
signal WR : std_logic:='0'; --write command

signal ERR: std_logic:='0';

constant T_CLK : Time := 10ns; --clock period

begin

DUT: RF port map(RST_n,CLK,R_ADDR1,R_ADDR2,W_ADDR,R_OP1,R_OP2,W_OP,WR);

R_ADDR1<=W_ADDR;
R_ADDR2<=W_ADDR;

process --test process

variable regpos: integer:=0;

begin
if RST_n='0' then
	wait for T_CLK*1.1;
	RST_n<='1'; --end of reset
	wait for T_CLK*0.9;
else
	if regpos<32 then
		W_ADDR<=to_unsigned(regpos,5); --setting address
		W_OP<=std_logic_vector(x"FFFFFF00"+to_unsigned(regpos,32)); --writing data
		WR<='0'; --write enable to 0
		wait for T_CLK/2*0.1; --wait for setting values
		
		CLK<='1';	--clock cycle
		wait for T_CLK/2;
		CLK<='0';
		wait for T_CLK/2*0.9;

		if R_OP1/= x"00000000" or R_OP2/= x"00000000" then --if data has been written or bypassed with WR=0
			ERR<='1';
			report "Data has been written or bypassed with WR=0" severity error;
		end if;
		
		WR<='1'; --write enable to 1
		wait for T_CLK/2*0.1; --wait for setting values
		
		if R_OP1/= W_OP or R_OP2/=W_OP then --if data has not been bypassed
			if W_ADDR/="00000" then --if not x0
				ERR<='1';
				report "Data has not been bypassed" severity error;
			end if;
		end if;

		CLK<='1';	--clock cycle
		wait for T_CLK/2;
		CLK<='0';
		WR<='0';
		wait for T_CLK/2*0.9;
		
		if regpos=0 then
			if R_OP1/=x"00000000" or R_OP2/=x"00000000" then --if reg x0 and read not 0
				ERR<='1';
				report "Data has been written on reg x0" severity error;
			end if;
		else
			if R_OP1/=W_OP or R_OP2/=W_OP then --if reg is not x0 and data has been wrongly written
				ERR<='1';
				report "Data has been written wrongly on reg x"& integer'image(regpos) severity error;
			end if;
		end if;
		regpos:=regpos+1;
	else
		wait;
	end if;
end if;
end process;


end architecture;
