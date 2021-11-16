read_verilog -netlist ../netlist/IIR_filter.v
read_saif -input ../saif/IIR_lookahead_syn.saif -instance tb_fir_LA/UUT -unit ns -scale 1
create_clock -name MY_CLK CLK
report_power > report_power.txt
