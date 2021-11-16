vdel -all
vlib work
vlog -work ./work ../netlist/IIR_filter.v

vcom -93 -work ./work ../tb/clk_gen.vhd
vcom -93 -work ./work ../tb/data_maker_LA.vhd
vcom -93 -work ./work ../tb/data_sink_LA.vhd
vlog -work ./work ../tb/tb_fir_LA.v


vsim -L /software/dk/nangate45/verilog/msim6.2g work.tb_fir_LA
vsim -L /software/dk/nangate45/verilog/msim6.2g -sdftyp /tb_fir_LA/UUT=../netlist/IIR_filter.sdf work.tb_fir_LA
vcd file ../vcd/IIR_lookahead_syn.vcd
vcd add /tb_fir_LA/UUT/*
add wave sim:/tb_fir_LA/*
run 100 us

