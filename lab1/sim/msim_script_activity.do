vdel -all
vlib work
vlog -work ./work ../netlist/IIR_filter.v

vcom -93 -work ./work ../tb/clk_gen.vhd
vcom -93 -work ./work ../tb/data_maker_new.vhd
vcom -93 -work ./work ../tb/data_sink.vhd
vlog -work ./work ../tb/tb_fir.v


vsim -L /software/dk/nangate45/verilog/msim6.2g work.tb_fir
vsim -L /software/dk/nangate45/verilog/msim6.2g -sdftyp /tb_fir/UUT=../netlist/IIR_filter.sdf work.tb_fir
vcd file ../vcd/IIR_filter_syn.vcd
vcd add /tb_fir/UUT/*
add wave sim:/tb_fir/*
run 100 us

