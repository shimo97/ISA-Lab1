library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TB_RV is
end entity;

architecture beh of TB_RV is

component MEM
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
	W_IN : in std_logic_vector(31 downto 0); --input data
	R_OUT : out std_logic_vector(31 downto 0) --output data
);
end component;

component RISC_V
generic( I_BASEA : unsigned(31 downto 0) := x"00400000" --base address of instructions
	 --;D_BASEA : unsigned(31 downto 0) := x"10010000" --base address of data
);
port(
CLK : in std_logic;
RST_n : in std_logic;
I_ADDR : out unsigned(31 downto 0);
I_RE : out std_logic;
INSTR : in std_logic_vector(31 downto 0);
D_ADDR : out unsigned(31 downto 0);
D_RE : out std_logic;
D_WE : out std_logic;
DATA_IN : in std_logic_vector(31 downto 0);
DATA_OUT : out std_logic_vector(31 downto 0)
);
end component;

signal CLK : std_logic:='0';
signal RST_n : std_logic:='0';
signal DM_F_READ,DM_F_WRITE,IM_F_READ : std_logic; --memories file read
signal DM_W_EN,DM_R_EN,IM_R_EN : std_logic; --memories read/write enables
signal DM_ADDR,IM_ADDR : unsigned(31 downto 0); --memories addresses
signal DM_W_IN,IM_W_IN,DM_R_OUT,IM_R_OUT : std_logic_vector(31 downto 0); --memories inputs/outputs

signal TEST_LENGTH : integer :=4000; --test length from reset (# of clock cycles)
constant T_CLK : Time := 10 ns; --clock period

begin

DM: MEM --data mem instance
generic map(64,x"10010000","./dataMEM_in.hex","./dataMEM_out.hex")
port map(RST_n,DM_F_READ,DM_F_WRITE,CLK,DM_W_EN,DM_R_EN,DM_ADDR,DM_W_IN,DM_R_OUT);

IM: MEM --instruction mem instance 
generic map(64,x"00400000","./instrMEM_in.hex","./instrMEM_out.hex")
port map(RST_n,IM_F_READ,'0',CLK,'0',IM_R_EN,IM_ADDR,IM_W_IN,IM_R_OUT);

DUT: RISC_V --dut instance
--generic map(x"00400000",x"10010000")
port map(CLK,RST_n,IM_ADDR,IM_R_EN,IM_R_OUT,DM_ADDR,DM_R_EN,DM_W_EN,DM_R_OUT,DM_W_IN);

TP:process --mem initialization, clock and reset generation
begin
if RST_n='0' then
	wait for T_CLK*1.1;
	RST_n<='1'; --end of reset
	wait for T_CLK*0.1;
	DM_F_READ<='1'; --reading memory contnent from file
	IM_F_READ<='1';
	wait for T_CLK*0.8;
else
	if TEST_LENGTH >=0 then
		CLK<='1';
		wait for T_CLK/2;
		CLK<='0';
		wait for T_CLK/2;
		TEST_LENGTH<=TEST_LENGTH-1;
	else
		DM_F_WRITE<='1'; --writing data memory on file
		wait;
	end if;
end if;

end process;

end architecture;
