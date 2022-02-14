library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IMM_GEN is
port(
	INSTR : in unsigned(31 downto 0); --first operand
	IMM : out std_logic_vector(31 downto 0) --second operand
);
end entity;

architecture beh of IMM_GEN is

signal opcode : unsigned(6 downto 0); --opcode field
signal funct3 : unsigned(2 downto 0); --funct3 field
signal funct7 : unsigned(6 downto 0); --funct7 field

--immediate extraction functions
----------------------------------------------------------------------
function I_immediate(instr : unsigned(31 downto 0)) return unsigned is
variable ret : unsigned(31 downto 0):=(others=> '0');
begin
ret(10 downto 0):=instr(30 downto 20);
ret(31 downto 11):=(others=> instr(31));
return ret;
end I_immediate;
----------------------------------------------------------------------
function S_immediate(instr : unsigned(31 downto 0)) return unsigned is
variable ret : unsigned(31 downto 0):=(others=> '0');
begin
ret(4 downto 0):=instr(11 downto 7);
ret(10 downto 5):=instr(30 downto 25);
ret(31 downto 11):=(others=> instr(31));
return ret;
end S_immediate;
----------------------------------------------------------------------
function B_immediate(instr : unsigned(31 downto 0)) return unsigned is
variable ret : unsigned(31 downto 0):=(others=> '0');
begin
ret(0):='0';
ret(4 downto 1):=instr(11 downto 8);
ret(10 downto 5):=instr(30 downto 25);
ret(11):=instr(7);
ret(31 downto 12):=(others=> instr(31));
return ret;
end B_immediate;
----------------------------------------------------------------------
function U_immediate(instr : unsigned(31 downto 0)) return unsigned is
variable ret : unsigned(31 downto 0):=(others=> '0');
begin
ret(11 downto 0):=(others=> '0');
ret(31 downto 12):=instr(31 downto 12);
return ret;
end U_immediate;
----------------------------------------------------------------------
function J_immediate(instr : unsigned(31 downto 0)) return unsigned is
variable ret : unsigned(31 downto 0):=(others=> '0');
begin
ret(0):='0';
ret(10 downto 1):=instr(30 downto 21);
ret(11):=instr(20);
ret(19 downto 12):=instr(19 downto 12);
ret(31 downto 20):=(others=> instr(31));
return ret;
end J_immediate;
----------------------------------------------------------------------

begin

opcode<=INSTR(6 downto 0);
funct3<=INSTR(14 downto 12);
funct7<=INSTR(31 downto 25);



----------------------------------------------------------------------
ID: process(INSTR,opcode,funct3,funct7) --decode process
begin

if opcode="0000011" and funct3="010" then --lw
	IMM<=std_logic_vector(I_immediate(INSTR));
elsif opcode="0100011" and funct3="010" then --sw
	IMM<=std_logic_vector(S_immediate(INSTR));
elsif opcode="0010011" and funct3="000" then --addi
	IMM<=std_logic_vector(I_immediate(INSTR));
elsif opcode="0010111" then --auipc
	IMM<=std_logic_vector(U_immediate(INSTR));
elsif opcode="0110111" then --lui
	IMM<=std_logic_vector(U_immediate(INSTR));
elsif opcode="1100011" and funct3="000" then --beq
	IMM<=std_logic_vector(B_immediate(INSTR));
elsif opcode="0010011" and funct3="101" then --srai
	IMM<=std_logic_vector(I_immediate(INSTR));
elsif opcode="0010011" and funct3="111" then --andi
	IMM<=std_logic_vector(I_immediate(INSTR));
elsif opcode="1101111" then --jal
	IMM<=std_logic_vector(J_immediate(INSTR));
else
   IMM<=(others=>'0');
end if; 

end process;
----------------------------------------------------------------------

end architecture;
