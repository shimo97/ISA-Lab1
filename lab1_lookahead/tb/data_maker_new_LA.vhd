library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.math_real.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity data_maker is
  generic(Nb : integer :=12; --number of data bits
  	  clkdelay : integer :=4);  --latency of filter (from input data sampling to output data sampling, must be >= 2)
  port (
    CLK     : in  std_logic;
    RST_n   : in  std_logic;
    VOUT    : out std_logic;
    DOUT    : out std_logic_vector(Nb-1 downto 0);
    b0      : out std_logic_vector(Nb-1 downto 0);
    b1      : out std_logic_vector(Nb-1 downto 0);
    b2      : out std_logic_vector(Nb-1 downto 0);
    a1      : out std_logic_vector(Nb-1 downto 0);
    END_SIM : out std_logic);
end data_maker;

architecture beh of data_maker is

  constant tco : time := 1 ns; --T clk to output

  signal sEndSim : std_logic; --simulation ending signal
  signal END_SIM_i : std_logic_vector(0 to clkdelay-1);  --shift register to send simulation end after latency

begin  -- beh
  --INSERT FILTER COEFFICIENTS
  b0 <= conv_std_logic_vector(861,Nb) after tco;
  b1 <= conv_std_logic_vector(998,Nb) after tco;
  b2 <= conv_std_logic_vector(136,Nb) after tco;
  a1 <= conv_std_logic_vector(51,Nb) after tco;  

  process (CLK, RST_n)
    file fp_in : text open READ_MODE is "../input.txt"; --INPUT FILE
    variable line_in : line;
    variable x : integer;
    
    variable r : real; --random extraction variable (real 0 to 1)
    variable rnd : integer; --random extraction variable (integer 0 to 100)
    variable seed1 : integer := 54; --random seeds
    variable seed2 : integer := 120;
    variable prob :integer := 5; --probability (%) of VIN going down instead of sending new data
  begin  -- process
    if RST_n = '0' then                 -- asynchronous reset (active low)
      DOUT <= (others => '0') after tco;      
      VOUT <= '0' after tco;
      sEndSim <= '0' after tco;
    elsif CLK'event and CLK = '1' then  -- rising clock edge
      uniform(seed1, seed2, r);  --extracting random number
      rnd:= integer(round(r * real(101) - 0.5)); --transforming into integer
      if(rnd>prob) then --if vin has to remain high, new data is sent
        if not endfile(fp_in) then
          readline(fp_in, line_in);
          read(line_in, x);
          DOUT <= conv_std_logic_vector(x, Nb) after tco;
          VOUT <= '1' after tco;
          sEndSim <= '0' after tco;
        else
          VOUT <= '0' after tco;        
          sEndSim <= '1' after tco; --starting simulation end (actually ended after latency)
        end if;
      else --otherwise VIN goes low and no new data is sent
          VOUT<='0' after tco;
      end if;
    end if;
  end process;

  process (CLK, RST_n) --simulation end shift register process
  begin  -- process
    if RST_n = '0' then                 -- asynchronous reset (active low)
      END_SIM_i <= (others => '0') after tco;
    elsif CLK'event and CLK = '1' then  -- rising clock edge
      END_SIM_i(1 to clkdelay-1) <= END_SIM_i(0 to clkdelay-2) after tco; --shifting
      END_SIM_i(0) <= sEndSim after tco; --inserting
    end if;
  end process;

  END_SIM <= END_SIM_i(clkdelay-1);  

end beh;
