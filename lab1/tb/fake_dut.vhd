library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity myiir is
  generic(Nb : integer :=12; --number of data bits
  	  clkdelay : integer := 10);  --latency of filter (from input data sampling to output data sampling, must be >= 2)
  port (
    CLK     : in  std_logic;
    RST_n   : in  std_logic;
    VIN    : in std_logic;
    DIN    : in std_logic_vector(Nb-1 downto 0);
    VOUT    : out std_logic;
    DOUT    : out std_logic_vector(Nb-1 downto 0);
    b0      : in std_logic_vector(Nb-1 downto 0);
    b1      : in std_logic_vector(Nb-1 downto 0);
    a0      : in std_logic_vector(Nb-1 downto 0);
    a1      : in std_logic_vector(Nb-1 downto 0));
end myiir;

architecture beh of myiir is
  signal VIN_shift : std_logic_vector(0 to clkdelay-1);  --shift register to propagate VIN
  type data_shift is array (0 to clkdelay-1) of std_logic_vector(Nb-1 downto 0); --shift register to propagate DIN
  signal DATA : data_shift;

  constant tco : time := 1 ns; --T clk to output
begin
  process (CLK, RST_n) --shift register process
  begin  -- process
    if RST_n = '0' then                 -- asynchronous reset (active low)
      VIN_shift <= (others => '0') after tco; 
      DATA <= (others=> (others=> '0'));
    elsif CLK'event and CLK = '1' then  -- rising clock edge
      VIN_shift(1 to clkdelay-1) <= VIN_shift(0 to clkdelay-2) after tco; --shifting VIN
      VIN_shift(0) <= VIN after tco; --inserting VIN

      DATA(1 to clkdelay-1) <= DATA(0 to clkdelay-2) after tco; --shifting DIN
      DATA(0) <= DIN after tco; --inserting DIN
    end if;
  end process;

  VOUT<=VIN_shift(clkdelay-1);
  DOUT<=DATA(clkdelay-1);
end beh;
