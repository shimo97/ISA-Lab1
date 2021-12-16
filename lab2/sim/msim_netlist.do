vdel -all
vlib work
vlog -work ./work ../netlist/fpu_pipeline.v
vcom -93 -work ./work ../src/clk_gen.vhd
vcom -93 -work ./work ../src/data_maker.vhd
vcom -93 -work ./work ../src/data_sink.vhd
vlog -work ./work ../src/tb_mul.v

vsim -L /software/dk/nangate45/verilog/msim6.2g -sdftyp /tb_mul/UUT=../netlist/fpu_pipeline.sdf -t 1ps work.tb_mul
add wave sim:/tb_mul/*
run 100 us
