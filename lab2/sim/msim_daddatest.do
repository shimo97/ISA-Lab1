vdel -all
vlib work
vcom -93 -work ./work ../Dadda_generator/adders.vhd
vcom -93 -work ./work ../src/dadda.vhd
vcom -93 -work ./work ../Dadda_generator/dadda_tb.vhd

vsim work.DADDA_TB
add wave sim:/DADDA_TB/*
run 10 us

