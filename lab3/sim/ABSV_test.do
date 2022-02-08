vdel -all
vlib work
vcom -93 -work ./work ../src/SPECIAL_FUNCT/ABSV.vhd
vcom -93 -work ./work ../src/SPECIAL_FUNCT/ABSV_tb.vhd

vsim work.ABSV_tb
add wave sim:/ABSV_tb/*

run 1 us