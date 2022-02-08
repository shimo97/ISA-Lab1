vdel -all
vlib work
vcom -93 -work ./work ./MEM.vhd
vcom -93 -work ./work ./FAKE_DUT.vhd
vcom -93 -work ./work ./TB_RV.vhd

vsim work.TB_RV
add wave sim:/TB_RV/*
add wave sim:/tb_rv/DM/mem
add wave sim:/tb_rv/IM/mem
run 1 us