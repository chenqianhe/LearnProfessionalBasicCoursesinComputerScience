@echo off
set xv_path=E:\\xilinx\\Vivado\\2015.2\\bin
call %xv_path%/xelab  -wto 9104d43940fc46be9e7e13db250d33b9 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot lab1_tb_behav xil_defaultlib.lab1_tb xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
