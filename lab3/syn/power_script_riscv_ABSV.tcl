set period 10

read_verilog -netlist ../netlist/RISC_V_ABS_syn.v
current_design RISC_V
create_clock -name MY_CLK -period "${period}" CLK
read_saif -input ../vcd/RISCV_ABSV.saif -instance tb_rv/dut
report_power > "power_ABSV_${period}.txt"


