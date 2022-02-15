vdel -all
vlib work

--importare riscv qui
vcom -93 -work ./work ../../src/ALU/ALU.vhd
vcom -93 -work ./work ../../src/BranchPredictor/BranchPredictor.vhd
vcom -93 -work ./work ../../src/ControlBlock/ControlBlock.vhd
vcom -93 -work ./work ../../src/ForwardingUnit/ForwardingUnit.vhd
vcom -93 -work ./work ../../src/HazardDetectionUnit/HazardDetectionUnit.vhd
vcom -93 -work ./work ../../src/IMM_GEN/IMM_GEN.vhd
vcom -93 -work ./work ../../src/RF_MEMS/RF.vhd
vcom -93 -work ./work ../../src/RISCV/InstructionFetch.vhd
vcom -93 -work ./work ../../src/RISCV/InstructionDecode.vhd
vcom -93 -work ./work ../../src/RISCV/Execute.vhd
vcom -93 -work ./work ../../src/RISCV/Writeback.vhd
vcom -93 -work ./work ../../src/RISCV/RISC_V.vhd

vcom -93 -work ./work ../../src/RF_MEMS/MEM.vhd
vcom -93 -work ./work ../../src/RISCV/TB_RV.vhd

vsim work.TB_RV
add wave -hex sim:/TB_RV/*
add wave -hex sim:/tb_rv/DM/mem
add wave -hex sim:/tb_rv/IM/mem
add wave -hex sim:/tb_rv/DUT/*
add wave -hex sim:/tb_rv/DUT/ID_stage/RegFile/*
add wave -hex sim:/tb_rv/DUT/EX_stage/*
add wave -hex sim:/tb_rv/DUT/ID_stage/*
add wave -hex sim:/tb_rv/DUT/IF_stage/BPU/*
run 3.2 us
