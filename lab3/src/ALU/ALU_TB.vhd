library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity ALU_TB is
end entity;

architecture beh of ALU_TB is

constant Tclk : time := 10 ns; --T clk
constant Tco : time := 1 ns; --T clk to output

signal go : std_logic :='1';

signal RST_n :std_logic := '0';
signal CLK : std_logic;

signal OP1,OP2,RES : signed(31 downto 0);	--signals for dut
signal CTRL : std_logic_vector(3 downto 0);
signal zero : std_logic;

signal ERR_RES : std_logic; --res error bit
signal ERR_ZERO : std_logic; --zero error bit

component ALU
port(
	OP1 : in signed(31 downto 0); --first operand
	OP2 : in signed(31 downto 0); --second operand
	CTRL : in std_logic_vector(3 downto 0); --ALU control code
	
	RES : buffer signed(31 downto 0); --output
	zero : out std_logic --result is zero flag
);
end component;

begin

CR: process --reset and clock process
begin
if RST_n = '0' then
	CLK<='0';
	wait for 0.8*Tclk;
	RST_n<='1';
else
	if go='1' then
		CLK<=not(CLK);
		wait for Tclk/2;
	else
		CLK<='0';
		wait;
	end if;
end if;
end process;

process (CLK, RST_n)
   	file fp_in : text open READ_MODE is "./ALU_stim_res.hex"; --INPUT FILE
	variable data_in_var4 : std_logic_vector(3 downto 0); --4 bits input variable
	variable data_in_var32 : std_logic_vector(31 downto 0); --32 bits input variable
	variable expected_res : signed(31 downto 0) := (others=> '0'); --expected res (32 bit)
	variable expected_zero : std_logic := '1'; --expected zero
	variable line_in : line;

  begin  -- process
    if RST_n = '0' then                 -- asynchronous reset (active low)
      	OP1 <= (others => '0') after Tco; 
	OP2 <= (others => '0') after Tco;
	CTRL <= (others => '0') after Tco;
	ERR_RES<='0';
	ERR_ZERO<='0';
	
    elsif CLK'event and CLK = '1' then  -- rising clock edge
	if (RES /= expected_res) then --checking output correctness
		ERR_RES<='1';
	end if;

	if (zero /= expected_zero) then --checking zero correctness
		ERR_ZERO<='1';
	end if;
   
   	if not endfile(fp_in) then
	      	readline(fp_in, line_in);

	      	hread(line_in, data_in_var4);	--setting control code
		CTRL<=data_in_var4 after Tco;

	      	hread(line_in, data_in_var32);	--setting op1
		OP1<=signed(data_in_var32) after Tco;

	      	hread(line_in, data_in_var32);	--setting op2
		OP2<=signed(data_in_var32) after Tco;
		
		hread(line_in, data_in_var32);	--setting expected res
		expected_res:=signed(data_in_var32);
		   
	      	hread(line_in, data_in_var4);	--setting expected zero
		expected_zero:=data_in_var4(0);
	else
		go<='0';
	end if;
    end if;
end process;

DUT: ALU port map(OP1=>OP1,OP2=>OP2,CTRL=>CTRL,RES=>RES,zero=>zero);

end architecture;
