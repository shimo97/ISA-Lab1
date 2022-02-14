vdel -all
vlib work

--importare riscv qui

vcom -93 -work ./work ../../src/RF_MEMS/MEM.vhd
vcom -93 -work ./work ../../src/RISCV/TB_RV.vhd

vsim work.TB_RV
add wave sim:/TB_RV/*
add wave sim:/tb_rv/DM/mem
add wave sim:/tb_rv/IM/mem
run 1 us
