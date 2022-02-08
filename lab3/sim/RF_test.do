vdel -all
vlib work
vcom -93 -work ./work ../src/RF_MEMS/RF.vhd
vcom -93 -work ./work ../src/RF_MEMS/TB_RF.vhd

vsim work.TB_RF
add wave sim:/TB_RF/*

run 1 us
