vdel -all
vlib work
vcom -93 -work ./work ../../src/RF_MEMS/MEM.vhd
vcom -93 -work ./work ../../src/RISCV/FAKE_DUT.vhd
vcom -93 -work ./work ../../src/RISCV/TB_RV.vhd

vsim work.TB_RV
add wave sim:/TB_RV/*
add wave sim:/tb_rv/DM/mem
add wave sim:/tb_rv/IM/mem
run 1 us
