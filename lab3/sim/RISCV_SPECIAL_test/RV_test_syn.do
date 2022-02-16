vdel -all
vlib work
vlog -work ./work ../../netlist/RISC_V_ABS_syn.v

vcom -93 -work ./work ../../src/RF_MEMS/MEM.vhd
vcom -93 -work ./work ../../src/RISCV/TB_RV.vhd

vsim -L /software/dk/nangate45/verilog/msim6.2g -sdftyp /TB_RV/DUT=../../netlist/RISC_V_ABS_syn.sdf -t 1ps work.tb_rv
vcd file ../../vcd/RISCV_ABSV.vcd
vcd add /tb_rv/DUT/*
add wave -hex sim:/TB_RV/*
run 3.2 us
