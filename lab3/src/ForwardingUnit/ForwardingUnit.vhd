LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_misc.all;

ENTITY ForwardingUnit IS
	GENERIC (N : integer:=5);
	PORT (RS1, RS2 : IN unsigned(N-1 downto 0);
			EX_MEM_RD, MEM_WB_RD : IN unsigned(N-1 downto 0);
			EX_MEM_regwrite, MEM_WB_regwrite : IN std_logic;
			forwardA, forwardB : OUT std_logic_vector(1 downto 0));
END ForwardingUnit;

ARCHITECTURE structure OF ForwardingUnit IS

	SIGNAL EX_MEM_RS1_xor, MEM_WB_RS1_xor, EX_MEM_RS2_xor, MEM_WB_RS2_xor : std_logic_vector(0 to N-1);
	SIGNAL EX_MEM_RS1_equal, MEM_WB_RS1_equal, EX_MEM_RS2_equal, MEM_WB_RS2_equal : std_logic;
	SIGNAL EX_MEM_RD_notzero, MEM_WB_RD_notzero : std_logic;
	SIGNAL forward_EX_MEM1, forward_MEM_WB1, forward_EX_MEM2, forward_MEM_WB2 : std_logic;

BEGIN

	-- control if RS1 is equal to EX_MEM_RD
	EX_MEM_1 : for i in 0 to N-1 generate
		EX_MEM_RS1_xor(i) <= (RS1(i) xor EX_MEM_RD(i));
	end generate;
	EX_MEM_RS1_equal <= nor_reduce(EX_MEM_RS1_xor);
	
	-- control if RS1 is equal to MEM_WB_RD
	MEM_WB_1 : for i in 0 to N-1 generate
		MEM_WB_RS1_xor(i) <= (RS1(i) xor MEM_WB_RD(i));
	end generate;
	MEM_WB_RS1_equal <= nor_reduce(MEM_WB_RS1_xor);
	
	-- control if RS2 is equal to EX_MEM_RD
	EX_MEM_2 : for i in 0 to N-1 generate
		EX_MEM_RS2_xor(i) <= (RS2(i) xor EX_MEM_RD(i));
	end generate;
	EX_MEM_RS2_equal <= nor_reduce(EX_MEM_RS2_xor);
	
	-- control if RS2 is equal to MEM_WB_RD
	MEM_WB_2 : for i in 0 to N-1 generate
		MEM_WB_RS2_xor(i) <= (RS2(i) xor MEM_WB_RD(i));
	end generate;
	MEM_WB_RS2_equal <= nor_reduce(MEM_WB_RS2_xor);
	
	-- control if EX_MEM_RD is different from 0
	EX_MEM_RD_notzero <= or_reduce(std_logic_vector(EX_MEM_RD));
	-- control if MEM_WB_RD is different from 0
	MEM_WB_RD_notzero <= or_reduce(std_logic_vector(MEM_WB_RD));
	
	-- forward signal set to 1 only if RD register is different from 0
	forward_EX_MEM1 <= EX_MEM_RS1_equal and EX_MEM_RD_notzero;
	forward_MEM_WB1 <= MEM_WB_RS1_equal and MEM_WB_RD_notzero;
	forward_EX_MEM2 <= EX_MEM_RS2_equal and EX_MEM_RD_notzero;
	forward_MEM_WB2 <= MEM_WB_RS2_equal and MEM_WB_RD_notzero;
	
	-- forward output signal is 10 if EX_MEM_RD has to be written and RD is equal to EX_MEM_RS
	-- forward output signal is 01 if MEM_WB_RD has to be written and RD is equal to EX_MEM_RS
	forwardA(1) <= forward_EX_MEM1 and EX_MEM_regwrite;
	forwardA(0) <= forward_MEM_WB1 and MEM_WB_regwrite;
	forwardB(1) <= forward_EX_MEM2 and EX_MEM_regwrite;
	forwardB(0) <= forward_MEM_WB2 and MEM_WB_regwrite;

END structure;