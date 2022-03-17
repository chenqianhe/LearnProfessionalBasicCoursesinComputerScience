# 
# Synthesis run script generated by Vivado
# 

debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir F:/Cqh_files/2021verilog/upload/lab3/lab3_3/lab3_3.cache/wt [current_project]
set_property parent.project_path F:/Cqh_files/2021verilog/upload/lab3/lab3_3/lab3_3.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
read_verilog -library xil_defaultlib F:/Cqh_files/2021verilog/upload/lab3/marquee.v
read_xdc F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master4.xdc
set_property used_in_implementation false [get_files F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master4.xdc]

synth_design -top marquee -part xc7a100tcsg324-1
write_checkpoint -noxdef marquee.dcp
catch { report_utilization -file marquee_utilization_synth.rpt -pb marquee_utilization_synth.pb }
