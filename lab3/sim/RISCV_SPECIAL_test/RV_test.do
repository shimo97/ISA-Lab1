vdel -all
vlib work

--importare riscv qui
vcom -93 -work ./work ../../src/ALU/ALU.vhd
vcom -93 -work ./work ../../src/BranchPredictor/BranchPredictor.vhd
vcom -93 -work ./work ../../src/SPECIAL_FUNCT/ControlBlock_ABSV.vhd
vcom -93 -work ./work ../../src/ForwardingUnit/ForwardingUnit.vhd
vcom -93 -work ./work ../../src/HazardDetectionUnit/HazardDetectionUnit.vhd
vcom -93 -work ./work ../../src/IMM_GEN/IMM_GEN.vhd
vcom -93 -work ./work ../../src/RF_MEMS/RF.vhd
vcom -93 -work ./work ../../src/RISCV/InstructionFetch.vhd
vcom -93 -work ./work ../../src/RISCV/InstructionDecode.vhd
vcom -93 -work ./work ../../src/SPECIAL_FUNCT/ABSV.vhd
vcom -93 -work ./work ../../src/SPECIAL_FUNCT/Execute_ABSV.vhd
vcom -93 -work ./work ../../src/RISCV/Writeback.vhd
vcom -93 -work ./work ../../src/RISCV/RISC_V.vhd

vcom -93 -work ./work ../../src/RF_MEMS/MEM.vhd
vcom -93 -work ./work ../../src/RISCV/TB_RV.vhd

vsim work.TB_RV
add wave -hex sim:/tb_rv/DUT/ID_stage/RegFile/*
add wave -hex sim:/tb_rv/DUT/EX_stage/SFU/*
add wave -hex sim:/tb_rv/DUT/EX_stage/*
add wave -hex sim:/tb_rv/DUT/ID_stage/*
run 3.2 us
