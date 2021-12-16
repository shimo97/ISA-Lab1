LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use ieee.math_real.all;

ENTITY DADDA_TB IS
PORT(
ERR : OUT std_logic);
END DADDA_TB;

ARCHITECTURE beh OF DADDA_TB IS

constant Ts : time := 10 ns;

COMPONENT DADDA
PORT(
Li : IN std_logic_vector(26 downto 0);
Mi : IN std_logic_vector(24 downto 0);
Ki : IN std_logic_vector(27 downto 0);
Ji : IN std_logic_vector(27 downto 0);
Ii : IN std_logic_vector(27 downto 0);
Hi : IN std_logic_vector(27 downto 0);
Gi : IN std_logic_vector(27 downto 0);
Fi : IN std_logic_vector(27 downto 0);
Ei : IN std_logic_vector(27 downto 0);
Di : IN std_logic_vector(27 downto 0);
Ci : IN std_logic_vector(27 downto 0);
Bi : IN std_logic_vector(27 downto 0);
Ai : IN std_logic_vector(27 downto 0);
Y : OUT std_logic_vector(47 downto 0));
END COMPONENT;

SIGNAL ERR_i :std_logic := '0';
SIGNAL CLK_i : std_logic := '0';
SIGNAL number : unsigned(27 downto 0); --input number
SIGNAL n_v : std_logic_vector(27 downto 0); --input number converted to vector
SIGNAL result : unsigned(47 downto 0); --computed correct result
SIGNAL dut_result :std_logic_vector(47 downto 0); --dut result



BEGIN

process
begin  --clock generation (only for data change reference)
	wait for Ts/2;
	CLK_i <= not(CLK_i);
end process;

process(CLK_i)	--random data generation process
variable seed1 :positive := 7;
variable seed2 :positive := 16;
variable numR : real;
variable numI : integer;
begin
if CLK_i'event and CLK_i = '1' then
	uniform(seed1,seed2,numR);	--extracting random number
	numI := integer(numR * real(2**28 -1));
	number<=to_unsigned(numI,28);
	--number(1)<='0';
end if;
end process;

process(number)--result computing process
variable partial : unsigned(47 downto 0); --partial products sum
variable tmp : unsigned(47 downto 0);
begin
   	partial:=(others =>'0');
   	tmp:=(others =>'0');
   	result<=partial;
   	--summing A
	tmp(27 downto 0):=number;
      	partial:=partial+tmp;
	--summing from B to K
	for i in 0 to 9 loop
		tmp:=(others =>'0');
		tmp(2*i):=number(0); --summing isolated sign bit
		tmp(2*i+28 downto 2*i+2):=number(27 downto 1); --summing other bits
		partial:=partial+tmp;
	end loop;
	--summing L
	tmp:=(others =>'0');
      	tmp(20):=number(0);
      	tmp(47 downto 22):=number(26 downto 1);
	partial:=partial+tmp;
	--summing Q
	tmp:=(others =>'0');
      	tmp(22):=number(0);
      	tmp(47 downto 24):=number(24 downto 1);
      	partial:=partial+tmp;
	
	result<=partial;
end process;

n_v<=std_logic_vector(number);
--component map
DT: DADDA port map(n_v(26 downto 0),n_v(24 downto 0),
n_v,n_v,n_v,n_v,n_v,n_v,n_v,n_v,n_v,n_v,n_v,
dut_result);

--error process
process(CLK_i)
    variable comp_var : std_logic_vector(47 downto 0);
begin
	if CLK_i'event and CLK_i = '0' then --comparing results on falling edge
	   comp_var:=std_logic_vector(result);
		if dut_result /= comp_var then
			ERR_i<='1';
		end if;
	end if;
end process;

ERR<=ERR_i;

END beh;