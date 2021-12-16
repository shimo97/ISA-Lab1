vdel -all
vlib work

vcom -93 -work ./work ../../Dadda_generator/adders.vhd
vcom -93 -work ./work ../../src/dadda24bit.vhd
vcom -93 -work ./work ../../src/MBE.vhd
vcom -93 -work ./work ../../src/tb_MBE.vhd

vsim work.tb_MBE
add wave sim:/tb_MBE/*
run 180 ns

