vdel -all
vlib work
vcom -93 -work ./work ../src/regn.vhd
vcom -93 -work ./work ../src/flipflop.vhd
vcom -93 -work ./work ../src/IIR_lookahead.vhd

vcom -93 -work ./work ../tb/clk_gen.vhd
vcom -93 -work ./work ../tb/data_maker_LA.vhd
vcom -93 -work ./work ../tb/data_sink_LA.vhd
vlog -work ./work ../tb/tb_fir_LA.v

vsim work.tb_fir_LA
add wave sim:/tb_fir_LA/*
add wave sim:/tb_fir_LA/UUT/*
run 100 us
