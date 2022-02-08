vdel -all
vlib work
vcom -93 -work ./work ../src/IMM_GEN/IMM_GEN.vhd
vcom -93 -work ./work ../src/IMM_GEN/IMMG_TB.vhd

do IMMG_test_onlysim.do

