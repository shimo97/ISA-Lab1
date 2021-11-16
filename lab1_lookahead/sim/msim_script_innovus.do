vdel -all
vlib work

vcom -93 -work ./work ../tb/clk_gen.vhd
vcom -93 -work ./work ../tb/data_maker_LA.vhd
vcom -93 -work ./work ../tb/data_sink_LA.vhd
vlog -work ./work ../innovus/IIR_lookahead.v
vlog -work ./work ../tb/tb_fir_LA.v

vsim -L /software/dk/nangate45/verilog/msim6.2g work.tb_fir_LA
vsim -L /software/dk/nangate45/verilog/msim6.2g -sdftyp /tb_fir_LA/UUT=../innovus/IIR_lookahead.sdf work.tb_fir_LA
vcd file ../vcd/design.vcd
vcd add /tb_fir_LA/UUT/*
add wave sim:/tb_fir_LA/*
run 100 us
