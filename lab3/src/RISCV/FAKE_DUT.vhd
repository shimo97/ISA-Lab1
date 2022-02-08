library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RISC_V is
generic( I_BASEA : unsigned(31 downto 0) := x"00400000"; --base address of instructions
	 D_BASEA : unsigned(31 downto 0) := x"10010000" --base address of data
);
port(
CLK : in std_logic;
RST_n : in std_logic;
I_ADDR : out unsigned(31 downto 0);
I_RE : out std_logic;
INSTR : in unsigned(31 downto 0);
D_ADDR : out unsigned(31 downto 0);
D_RE : out std_logic;
D_WE : out std_logic;
DATA_IN : in unsigned(31 downto 0);
DATA_OUT : out unsigned(31 downto 0)
);
end entity;

architecture beh of RISC_V is

signal I_ADDRS : unsigned(31 downto 0):=I_BASEA;
signal D_ADDRS : unsigned(31 downto 0):=D_BASEA;
signal I_IN : unsigned(31 downto 0);
signal D_OUT : unsigned(31 downto 0);

signal test_phase : integer :=0; --test phase signal

constant Tco:Time:=1ns;

begin

process(CLK,RST_n,test_phase) --test process
begin
if RST_n='0' then
	test_phase<=-1;
else
	if CLK'event and CLK='1' then

		case test_phase is
		when 0 =>	--read instr and write on data
			I_RE<='1' after Tco;
			D_RE<='0' after Tco;
			D_WE<='1' after Tco;
		when 1 =>	--do not read nothing and write (nothing) on data 
			I_RE<='0' after Tco;
			D_RE<='0' after Tco;
			D_WE<='1' after Tco;
		when 2 =>	--read instr and do not write on data
			I_RE<='1' after Tco;
			D_RE<='0' after Tco;
			D_WE<='1' after Tco;
		when others =>	--reset position
			I_RE<='0' after Tco;
			D_RE<='0' after Tco;
			D_WE<='0' after Tco;
		end case;

		if test_phase/=-1 then
			I_ADDRS<=I_ADDRS+4 after Tco;
			D_ADDRS<=D_ADDRS+4 after Tco;
		end if;

		test_phase<=test_phase+1;
		if test_phase=3 then
			test_phase<=0;
		end if;
	end if;
end if;
end process;

I_ADDR<=I_ADDRS;
D_ADDR<=D_ADDRS;
D_OUT<=I_IN after Tco;

I_IN<=INSTR;
DATA_OUT<=D_OUT;

end architecture;