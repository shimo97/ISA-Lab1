set period 10

read_verilog -netlist ../netlist/RISC_V_syn.v
current_design RISC_V
create_clock -name MY_CLK -period "${period}" CLK
read_saif -input ../vcd/RISCV.saif -instance tb_rv/dut
report_power > "power_${period}.txt"


