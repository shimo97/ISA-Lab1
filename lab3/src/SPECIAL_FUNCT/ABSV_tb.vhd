library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity ABSV_tb is
end entity;

architecture beh of ABSV_tb is

--dut component
component ABSV
port(
	OP : in signed(31 downto 0); --operand
	ABSV : out signed(31 downto 0) --modulus
);
end component;

--signals
signal dut_OP : signed(31 downto 0):=x"80000000"; --dut input operand
--dut_OP initialized with a critical number (lower negative, that will remain unchanged by abs)
signal dut_ABSV : signed(31 downto 0); --dut result
signal correct_ABSV : signed(31 downto 0); --correct result
signal ERR: std_logic :='0';
signal CLK_i : std_logic:='1';

begin

DUT: ABSV port map(dut_OP,dut_ABSV);

process(CLK_i)	--random data generation process
variable seed1 :positive := 48;
variable seed2 :positive := 95;
variable numR : real;
variable numI : integer;
begin
if CLK_i'event and CLK_i = '1' then
	uniform(seed1,seed2,numR);	--extracting random number (first 16 bits)
	numI := integer(numR * real(2**16 -1));
	dut_OP(15 downto 0)<=to_signed(numI,16);
	uniform(seed1,seed2,numR);	--extracting random number (last 16 bits)
	numI := integer(numR * real(2**16 -1));
	dut_OP(31 downto 16)<=to_signed(numI,16);
end if;
end process;

EP: process(CLK_i,dut_ABSV,dut_OP) --error check process
variable exp_ABSV : signed(31 downto 0); --expected result
begin
	if dut_OP<0 then
		exp_ABSV:=-dut_OP;
	else
		exp_ABSV:=dut_OP;
	end if;
		correct_ABSV<=exp_ABSV;
if CLK_i'event and CLK_i='0' then --falling edge
	if exp_ABSV/=dut_ABSV then
		ERR<='1';
	end if;

end if;
end process;

CG:process --clock gen process
begin
wait for 5ns;
if CLK_i='0' then
	CLK_i<='1';
else
	CLK_i<='0';
end if;
end process;

end architecture;
