LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY MBE IS
	PORT (OP1, OP2 : IN unsigned(23 downto 0);
			PROD : OUT unsigned(47 downto 0)
			);
END MBE;

ARCHITECTURE structure OF MBE IS

	SIGNAL X : unsigned(26 downto 0); -- operand sign extended and added with zeroes in order to have triplets for Booth encoding
	SIGNAL mux_sel_couples : std_logic_vector(0 to 23); -- couples of selectors for muxes (00 -> 0, 01 -> OP1, 10 -> 2OP1)
	TYPE t_mux is array(0 to 11) of std_logic_vector(1 downto 0);
	SIGNAL mux_sel : t_mux;
	SIGNAL last_mux_sel : std_logic;
	TYPE t_vec is array (0 to 11) of unsigned(24 downto 0);
	SIGNAL selected_pp, xored_pp : t_vec;
	SIGNAL last_selected_pp : unsigned(23 downto 0);
	TYPE t_pp is array(0 to 9) of unsigned(27 downto 0);
	SIGNAL pp : t_pp;
	SIGNAL first_pp : unsigned(27 downto 0);
	SIGNAL penultimate_pp : unsigned(26 downto 0);
	SIGNAL last_pp : unsigned(24 downto 0);
	SIGNAL dadda_result : std_logic_vector(47 downto 0);

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

BEGIN

	-- zeroes added to correctly take into account all the string of 1s to have complete triplets of bits
	X <= "00" & OP2 & '0';
	
	-- Booth encoding units
	BEU: for i in 0 to 11 generate
		mux_sel_couples(2*i+1) <= X(2*i+1) xor X(2*i);
		mux_sel_couples(2*i) <= (not mux_sel_couples(2*i+1)) and (X(2*i+1) xor X(2*i+2));
	end generate;
	last_mux_sel <= X(24);
	
	-- multiplexers
	MUX: for i in 0 to 11 generate
		mux_sel(i) <= mux_sel_couples(2*i) & mux_sel_couples(2*i+1);
		WITH (mux_sel(i)) SELECT
		selected_pp(i) <= (OTHERS => '0') WHEN "00",
			('0' & OP1) WHEN "01",
			(OP1 & '0') WHEN OTHERS;
	end generate;
	WITH last_mux_sel SELECT
		last_selected_pp <= (OTHERS => '0') WHEN '0',
			OP1 WHEN OTHERS;
	
	-- xors
	complement : for i in 0 to 11 generate
		bitbybit : for j in 0 to 24 generate
			xored_pp(i)(j) <= selected_pp(i)(j) xor X(2*i+2);
		end generate;
	end generate;
	
	-- packing partial products
	first_pp <= (not X(2)) & X(2) & X(2) & xored_pp(0);
	PPs : for i in 1 to 10 generate
		pp(i-1) <= '1' & (not X(2*i+2)) & xored_pp(i) & X(2*i);
	end generate;
	penultimate_pp <= (not X(24)) & xored_pp(11) & X(22);
	last_pp <= last_selected_pp & X(24);
	
	-- addition of partial products by means of a Dadda tree
	sums : DADDA port map (std_logic_vector(penultimate_pp),
				std_logic_vector(last_pp),
				std_logic_vector(pp(9)),
				std_logic_vector(pp(8)),
				std_logic_vector(pp(7)),
				std_logic_vector(pp(6)),
				std_logic_vector(pp(5)),
				std_logic_vector(pp(4)),
				std_logic_vector(pp(3)),
				std_logic_vector(pp(2)),
				std_logic_vector(pp(1)),
				std_logic_vector(pp(0)),
				std_logic_vector(first_pp),
				dadda_result);
	PROD <= unsigned(dadda_result);

END structure;
