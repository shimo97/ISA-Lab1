set period 6.32

read_verilog -netlist ../netlist/IIR_filter_syn.v

create_clock -name MY_CLK -period "${period}" CLK
report_timing > "./timing_${period}.txt"
report_area > "./area_${period}.txt"
write_sdc ../netlist/IIR_filter_syn.sdc
read_saif -input ../saif/IIR_filter_syn.saif -instance tb_fir/UUT
report_power > "report_power_${period}.txt"


