analyze -f vhdl -lib WORK ../src/ALU/ALU.vhd
analyze -f vhdl -lib WORK ../src/BranchPredictor/BranchPredictor.vhd
analyze -f vhdl -lib WORK ../src/ControlBlock/ControlBlock.vhd
analyze -f vhdl -lib WORK ../src/ForwardingUnit/ForwardingUnit.vhd
analyze -f vhdl -lib WORK ../src/HazardDetectionUnit/HazardDetectionUnit.vhd
analyze -f vhdl -lib WORK ../src/IMM_GEN/IMM_GEN.vhd
analyze -f vhdl -lib WORK ../src/RF_MEMS/RF.vhd
analyze -f vhdl -lib WORK ../src/RISCV/InstructionFetch.vhd
analyze -f vhdl -lib WORK ../src/RISCV/InstructionDecode.vhd
analyze -f vhdl -lib WORK ../src/RISCV/Execute.vhd
analyze -f vhdl -lib WORK ../src/RISCV/Writeback.vhd
analyze -f vhdl -lib WORK ../src/RISCV/RISC_V.vhd
set_power_preserve_rtl_hier_names true
elaborate RISC_V -arch behavior -lib WORK > ./RISC_V_elaborate.txt
uniquify
link
create_clock -name MY_CLK -period 10 CLK
set_dont_touch_network MY_CLK
set_clock_uncertainty 0.07 [get_clocks MY_CLK]
set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] CLK]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]
ungroup -all -flatten
compile
report_timing > ./timing_10.txt
report_area > ./area_10.txt

change_names -hierarchy -rules verilog
write_sdf ../netlist/RISC_V_syn.sdf
write -f verilog -hierarchy -output ../netlist/RISC_V_syn.v
write_sdc ../netlist/RISC_V_syn.sdc
