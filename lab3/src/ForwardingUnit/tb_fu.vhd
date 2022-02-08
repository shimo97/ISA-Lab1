library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

entity tb_fu is
end tb_fu;

architecture beh of tb_fu is

	COMPONENT ForwardingUnit
		GENERIC (N : integer:=5);
		PORT (RS1, RS2 : IN unsigned(N-1 downto 0);
				EX_MEM_RD, MEM_WB_RD : IN unsigned(N-1 downto 0);
				EX_MEM_regwrite, MEM_WB_regwrite : IN std_logic;
				forwardA, forwardB : OUT std_logic_vector(1 downto 0));
	END COMPONENT;
	
	signal rs1, rs2 : unsigned(4 downto 0);
	signal ex_mem_rd, mem_wb_rd : unsigned(4 downto 0);
	signal ex_mem_regwrite, mem_wb_regwrite : std_logic;
	signal fA, fB : std_logic_vector(1 downto 0);
	
BEGIN

	test_proc : process
	begin
		rs1 <= "10101";
		rs2 <= "00001";
		ex_mem_rd <= "10101";
		mem_wb_rd <= "11111";
		ex_mem_regwrite <= '1';
		mem_wb_regwrite <= '0';
		wait for 10 ns;
		rs1 <= "10101";
		rs2 <= "00001";
		ex_mem_rd <= "01100";
		mem_wb_rd <= "00001";
		ex_mem_regwrite <= '1';
		mem_wb_regwrite <= '1';
		wait for 10 ns;
		rs1 <= "10101";
		rs2 <= "00001";
		ex_mem_rd <= "10101";
		mem_wb_rd <= "11111";
		ex_mem_regwrite <= '0';
		mem_wb_regwrite <= '0';
		wait for 10 ns;
		rs1 <= "10101";
		rs2 <= "00001";
		ex_mem_rd <= "11111";
		mem_wb_rd <= "11111";
		ex_mem_regwrite <= '1';
		mem_wb_regwrite <= '1';
		wait for 10 ns;
		rs1 <= "10101";
		rs2 <= "00001";
		ex_mem_rd <= "10101";
		mem_wb_rd <= "00001";
		ex_mem_regwrite <= '1';
		mem_wb_regwrite <= '1';
		wait for 10 ns;
	end process;
	
	-- DUT
	DUT : ForwardingUnit port map (rs1, rs2, ex_mem_rd, mem_wb_rd, ex_mem_regwrite, mem_wb_regwrite, fA, fB);

END beh;