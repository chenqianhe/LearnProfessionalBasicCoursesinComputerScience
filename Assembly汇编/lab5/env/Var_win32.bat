@echo off
rem 请根据 Masm32 软件包的安装目录修改下面的 Masm32Dir 环境变量！

rem 一般地，如果QEDITOR.EXE不在d:盘Masm32文件夹，才须修改。
rem 主要是修改这行中“d:\Masm32”字样，改成QEDITOR.EXE文件所在位置。
set Masm32Dir=d:\Masm32

rem 以下一般不用修改
set include=%Masm32Dir%\Include;%include%
set lib=%Masm32Dir%\lib;%lib%
set path=%Masm32Dir%\Bin;%Masm32Dir%;%PATH%
set Masm32Dir=

rem 以下是显示所设置的环境变量include、lib、path的结果值：
set include
set lib
set path
echo on
pause
