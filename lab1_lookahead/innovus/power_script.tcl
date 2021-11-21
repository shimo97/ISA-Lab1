source design.globals
restoreDesign "${TopLevelDesign}.enc.dat" "${TopLevelDesign}"
setDrawView place
reset_parasitics
extractRC
rcOut -setload "${TopLevelDesign}.setload" -rc_corner my_rc
rcOut -setres "${TopLevelDesign}.setres" -rc_corner my_rc
rcOut -spf "${TopLevelDesign}.spf" -rc_corner my_rc
rcOut -spef "${TopLevelDesign}.spef" -rc_corner my_rc
set_power_analysis_mode -reset
set_power_analysis_mode -method static -corner max -create_binary_db true -write_static_currents true -honor_negative_energy true -ignore_control_signals true
set_power_output_dir -reset
set_power_output_dir ./
set_default_switching_activity -reset
set_default_switching_activity -input_activity 0.2 -period "${pwr_period}"
read_activity_file -reset
read_activity_file -format VCD -scope tb_fir/UUT -start {} -end {} -block {} "../vcd/${TopLevelDesign}_innovus.vcd"
set_power -reset
set_powerup_analysis -reset
set_dynamic_power_simulation -reset
report_power -rail_analysis_format VS -outfile ".//${TopLevelDesign}.rpt"
report_power -outfile "./powerReport_${pwr_period}.txt" -sort { total }
