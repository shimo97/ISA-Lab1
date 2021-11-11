analyze -f vhdl -lib WORK ../src/IIR_filter.vhd
analyze -f vhdl -lib WORK ../src/regn.vhd
analyze -f vhdl -lib WORK ../src/flipflop.vhd
set_power_preserve_rtl_hier_names true
elaborate IIR_filter -arch behavior -lib WORK
uniquify
link

create_clock -name MY_CLK -period 9.8 CLK
set_dont_touch_network MY_CLK
set_clock_uncertainty 0.07 [get_clocks MY_CLK]
set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] CLK]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs].
set OLOAD [load_of_NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]

compile

report_timing > ./timing_9.8.txt
report_area > ./area_9.8.txt
ungroup -all -flatten
change_names -hierarchy -rules verilog
write_sdf ../netlist/IIR_filter.sdf
write -f verilog -hierarchy -output ../netlist/IIR_filter.v
write_sdc ../netlist/IIR_filter.sdc
quit
