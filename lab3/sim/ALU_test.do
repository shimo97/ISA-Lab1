vdel -all
vlib work
vcom -93 -work ./work ../src/ALU/ALU.vhd
vcom -93 -work ./work ../src/ALU/ALU_TB.vhd

do ALU_test_onlysim.do

