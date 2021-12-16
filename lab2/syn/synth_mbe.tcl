analyze -f vhdl -lib WORK ../Dadda_generator/adders.vhd
analyze -f vhdl -lib WORK ../src/dadda.vhd
analyze -f vhdl -lib WORK ../src/MBE.vhd
analyze -f vhdl -lib WORK ../src/fpuvhdl/common/fpnormalize_fpnormalize.vhd
analyze -f vhdl -lib WORK ../src/fpuvhdl/common/fpround_fpround.vhd
analyze -f vhdl -lib WORK ../src/fpuvhdl/common/packfp_packfp.vhd
analyze -f vhdl -lib WORK ../src/fpuvhdl/common/unpackfp_unpackfp.vhd
analyze -f vhdl -lib WORK ../src/fpuvhdl/multiplier/fpmul_pipeline.vhd
analyze -f vhdl -lib WORK ../src/fpuvhdl/multiplier/fpmul_stage1_struct.vhd
analyze -f vhdl -lib WORK ../src/fpuvhdl/multiplier/fpmul_mbe_stage2_struct.vhd
analyze -f vhdl -lib WORK ../src/fpuvhdl/multiplier/fpmul_stage3_struct.vhd
analyze -f vhdl -lib WORK ../src/fpuvhdl/multiplier/fpmul_stage4_struct.vhd
set power_preserve_rtl_hier_names true
elaborate FPmul -arch pipeline -lib WORK
uniquify
link
create_clock -name MY_CLK -period 2.83 clk
set_dont_touch_network MY_CLK
set_clock_uncertainty 0.07 [get_clocks MY_CLK]
set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] clk]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]
ungroup -all -flatten
compile
report_timing > ./timing_mbe_Tmin.txt
report_area > ./area_mbe_Tmin.txt

ungroup -all -flatten
change_names -hierarchy -rules verilog
write_sdf ../netlist/fpu_pipeline.sdf
write -f verilog -hierarchy -output ../netlist/fpu_pipeline.v
