LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY IIR_lookahead IS
	PORT (CLK : IN std_logic;
			RST_n : IN std_logic;
			DIN : IN signed(11 downto 0);
			VIN : IN std_logic;
			b0, b1, b2, a1 : IN signed(11 downto 0);
			DOUT : OUT signed(11 downto 0);
			VOUT : OUT std_logic
			);
END IIR_lookahead;

ARCHITECTURE behavior OF IIR_lookahead IS

	SIGNAL din_del : std_logic_vector(6 downto 0); -- signal DIN delayed of a clock cycle
	SIGNAL din_t : signed(6 downto 0); -- signed version of previous signal
	SIGNAL u : signed(7 downto 0); -- truncated result of the sum
	SIGNAL u_del_vec, u_del_vec2 : std_logic_vector(7 downto 0); -- delayed u in std_logic_vector format
	SIGNAL u_del, u_del2 : signed(7 downto 0); -- signal u delayed
	SIGNAL mula1, mulb0, mulb1, mulb2 : signed(15 downto 0); -- multiplication for coefficient a1, b0 and b1
	-- signals after multiplications have lower parallelism to decrease the area of the circuit
	SIGNAL t_mula1, t_mulb0, t_mulb1, t_mulb2 : signed(6 downto 0); -- truncated results of multiplications
	SIGNAL t_mulb0_del_vec, t_mula1_del_vec, t_mulb1_del_vec, t_mulb2_del_vec, sum1_del_vec : std_logic_vector(6 downto 0);
	SIGNAL t_mula1_del, t_mulb0_del, t_mulb1_del, t_mulb2_del, sum1_del : signed(6 downto 0);
	SIGNAL sum1 : signed(6 downto 0); -- output of the first sum in the feedforward
	SIGNAL y : signed(7 downto 0); -- output of the filter
	SIGNAL y_vec : std_logic_vector(7 downto 0); -- output of the filter in std_logic_vector format
	SIGNAL q1, q2, q3, q4 : std_logic; -- propagation of VIN into flipflops
	SIGNAL b0_t, b1_t, b2_t, a1_t : signed(7 downto 0); -- truncated version of input and coefficients
	--SIGNAL regsum_en : std_logic; -- enable signal for register regsum

	COMPONENT regn
	GENERIC ( N : integer:=8);
	PORT (R : IN std_logic_vector(N-1 DOWNTO 0);
			Clock, Resetn, load : IN STD_LOGIC;
			Q : OUT std_logic_vector(N-1 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT flipflop IS
	PORT (D : IN std_logic;
			Clock, Resetn : IN STD_LOGIC;
			Q : OUT std_logic);
	END COMPONENT;

BEGIN

	-- truncation and sign extension of one bit for every coefficient
	b0_t <= b0(11) & b0(11 downto 5);
	b1_t <= b1(11) & b1(11 downto 5);
	b2_t <= b2(11) & b2(11 downto 5);
	a1_t <= a1(11) & a1(11 downto 5);

	regX0 : regn generic map (7) port map (std_logic_vector(DIN(11 downto 5)), CLK, RST_n, VIN, din_del); -- first register for the input signal
	din_t <= signed(din_del);
	
	-- sign extension to the inputs of the sum to have the result with one bit more in order to avoid overflow
	u <= (din_t(6) & din_t) + (t_mula1_del(6) & t_mula1_del);
	
	regU : regn generic map (8) port map (std_logic_vector(u), CLK, RST_n, q1, u_del_vec);
	u_del <= signed(u_del_vec); -- signed conversion
	
	-- since the result for every multiplication has to be in 7 bits, the first 3 and the last 6 are discarded.
	-- the inputs of every multiplication have the format Q2.X and the result is Q4.X so first 3 bits are discarded
	-- to obtain the result in the format Q1.X since it is known that the result is lower than 1 in magnitude.
	mula1 <= a1_t * u_del;
	t_mula1 <= mula1(12 downto 6);
	rega1 : regn generic map (7) port map (std_logic_vector(t_mula1), CLK, RST_n, q2, t_mula1_del_vec);
	t_mula1_del <= signed(t_mula1_del_vec);
	
	mulb0 <= b0_t * u_del;
	t_mulb0 <= mulb0(12 downto 6);
	regb0 : regn generic map (7) port map (std_logic_vector(t_mulb0), CLK, RST_n, q2, t_mulb0_del_vec);
	t_mulb0_del <= signed(t_mulb0_del_vec);
	
	mulb1 <= b1_t * u_del;
	t_mulb1 <= mulb1(12 downto 6);
	regb1 : regn generic map (7) port map (std_logic_vector(t_mulb1), CLK, RST_n, q2, t_mulb1_del_vec);
	t_mulb1_del <= signed(t_mulb1_del_vec);
	
	regU2 : regn generic map (8) port map (std_logic_vector(u_del), CLK, RST_n, q2, u_del_vec2);
	u_del2 <= signed(u_del_vec2);
	mulb2 <= b2_t * u_del2;
	t_mulb2 <= mulb2(12 downto 6);
	regb2 : regn generic map (7) port map (std_logic_vector(t_mulb2), CLK, RST_n, q3, t_mulb2_del_vec);
	t_mulb2_del <= signed(t_mulb2_del_vec);

	sum1 <= t_mulb2_del + t_mulb1_del; -- overflow cannot occur in this sum
	--regsum_en <= q3 or q4;
	regsum : regn generic map (7) port map (std_logic_vector(sum1), CLK, RST_n, q3, sum1_del_vec);
	sum1_del <= signed(sum1_del_vec);
	
	-- sign extension to the inputs of the sum to avoid overflow
	y <= (t_mulb0_del(6) & t_mulb0_del) + (sum1_del(6) & sum1_del);
	regY : regn generic map (8) port map (std_logic_vector(y), CLK, RST_n, q3, y_vec); -- last register for the output signal
	DOUT <= signed(y_vec) & "0000";
	
	-- VOUT generation
	ff1 : flipflop port map (VIN, CLK, RST_n, q1);
	ff2 : flipflop port map (q1, CLK, RST_n, q2);
	ff3 : flipflop port map (q2, CLK, RST_n, q3);
	ff4 : flipflop port map (q3, CLK, RST_n, q4);
	VOUT <= q4;
	
END behavior;	
