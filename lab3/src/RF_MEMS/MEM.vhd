library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity MEM is
generic(Nw : natural := 20;  --number of words
	Ba : unsigned(31 downto 0) := x"00000000"; --base address (must be a multiple of 4 for word alignment)
	IN_FN : string := "./in.hex"; --input filename
	OUT_FN : string := "./out.hex"); --output filename
	
port(
	RST_n : in std_logic; --asynchronous reset
	F_READ : in std_logic; --file read
	F_WRITE : in std_logic; --file write
	CLK : in std_logic; --clock
	W_EN : in std_logic; --write enable (synchronous)
	R_EN : in std_logic; --read enable (asynchronous)
	ADDR : in unsigned(31 downto 0); --byte address (but 2 LSB will be discarded for word alignment)
	W_IN : in unsigned(31 downto 0); --input data
	R_OUT : out unsigned(31 downto 0) --output data
);
end entity;

architecture beh of MEM is

--memory creation
type mem_arr is array(Nw-1 downto 0) of unsigned(31 downto 0);
signal mem : mem_arr;

signal max_addr : unsigned(31 downto 0):=X"FFFFFFFF";
signal tmp: unsigned(34 downto 0);
signal n_word : unsigned(31 downto 0):=to_unsigned(Nw,32);

begin

EC: process --generics error check
begin
	if (Ba mod 4)/=0 then
		report "Base address is not a multiple of 4!" severity error;	
	end if;

	if (n_word*4+Ba)>max_addr then--if final address exceeds 32 bits
		report "Cell number exceeding maximum addressable!" severity error;
	else
		tmp<=n_word*"100"+Ba;
		max_addr<=tmp(31 downto 0);
	end if;
wait;
end process;

-----------------------------------------------------
WP: process(RST_n,F_READ,ADDR,W_EN,W_IN,CLK) --asynchronous reset, file read and write

file fp_in : text open READ_MODE is IN_FN; --INPUT FILE
variable data_in_var32 : std_logic_vector(31 downto 0); --32 bits input variable
variable line_in : line;
variable currPos : integer;

begin

if RST_n='0' then --reset falling edge
	mem<=(others=>(others=>'0'));
else
	if F_READ='1' and F_READ'event then --file read
		currPos := 0;
	   	while not endfile(fp_in) loop --loading on mem from file
		      	readline(fp_in, line_in);
			hread(line_in, data_in_var32);	--reading
			if currPos >= Nw then --if address space exceeded
				report "Memory size exceeded!" severity error;
			else
				mem(currPos)<=unsigned(data_in_var32);
				currPos:=currPos+1;
			end if;
		end loop;
	end if;

	if CLK='1' and CLK'event then --write
		if W_EN='1' then
			if (ADDR(0) /= '0') or (ADDR(1) /= '0') then
				report "Trying to write on non aligned address!" severity error;
			end if;
			currPos:=to_integer(ADDR-Ba);
			currPos:=currPos/4;
			if (currPos<0) or (currPos>=Nw) then
				report "Address is outside memory space, nothing will be written" severity warning;
			else
				mem(currPos)<=W_IN;
			end if;	
		end if;
	end if;
end if;
end process;

-----------------------------------------------------
RP: process(ADDR,R_EN) --read process
variable i_addr :integer;
begin
	if R_EN = '1' then
		if (ADDR(0) /= '0') or (ADDR(1) /= '0') then
			report "Trying to read on non aligned address!" severity warning;
		end if;
		
		i_addr := to_integer(ADDR-Ba);
		i_addr := i_addr/4;
		if (i_addr<0) or (i_addr>=Nw) then
			report "Address is outside memory space, output will be 0" severity warning;
			R_OUT<=(others=>'0');
		else
			R_OUT<=mem(i_addr);
		end if;	
	else
		R_OUT<=(others=>'0');	
	end if;
end process;

-----------------------------------------------------
DP: process(F_WRITE)
file fp_out : text open WRITE_MODE is OUT_FN; --OUTPUT FILE
variable line_out : line;
variable currPos : integer;

begin
	if F_WRITE='1' and F_WRITE'event then --file write
		currPos := 0;
	   	while currPos<Nw loop --loading on mem from file
			hwrite(line_out, std_logic_vector(mem(currPos)));	--writing		      	
			writeline(fp_out, line_out);
			currPos:=currPos+1;
		end loop;
	end if;

end process;

end architecture;
