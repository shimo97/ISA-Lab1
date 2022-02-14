vdel -all
vlib work
vcom -93 -work ./work ../../src/BranchPredictor/BranchPredictor.vhd
vcom -93 -work ./work ../../src/BranchPredictor/tb_BranchPredictor.vhd

vsim work.tb_BranchPredictor
add wave sim:/tb_BranchPredictor/*
add wave sim:/DUT/BHT
add wave sim:/DUT/BHT_out
add wave sim:/DUT/newBHT
add wave sim:/DUT/PV_lastbranch
add wave sim:/DUT/wrong_TA
run 5 us

