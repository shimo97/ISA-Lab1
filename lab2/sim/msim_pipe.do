vdel -all
vlib work
vcom -93 -work ./work ../src/fpuvhdl/common/*.vhd
vcom -93 -work ./work ../src/fpuvhdl/multiplier/fpmul_stage*.vhd
vcom -93 -work ./work ../src/fpuvhdl/multiplier/fpmul_pipe_stage2_struct.vhd
vcom -93 -work ./work ../src/fpuvhdl/multiplier/fpmul_pipeline.vhd
vcom -93 -work ./work ../src/clk_gen.vhd
vcom -93 -work ./work ../src/data_maker.vhd
vcom -93 -work ./work ../src/data_sink.vhd
vlog -work ./work ../src/tb_mul.v

vsim work.tb_mul
add wave sim:/tb_mul/*
run 100 us

