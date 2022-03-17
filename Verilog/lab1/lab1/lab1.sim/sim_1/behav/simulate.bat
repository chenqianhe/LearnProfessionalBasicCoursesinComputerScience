@echo off
set xv_path=E:\\xilinx\\Vivado\\2015.2\\bin
call %xv_path%/xsim lab1_tb_behav -key {Behavioral:sim_1:Functional:lab1_tb} -tclbatch lab1_tb.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
