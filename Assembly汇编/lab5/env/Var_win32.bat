@echo off
rem ����� Masm32 ������İ�װĿ¼�޸������ Masm32Dir ����������

rem һ��أ����QEDITOR.EXE����d:��Masm32�ļ��У������޸ġ�
rem ��Ҫ���޸������С�d:\Masm32���������ĳ�QEDITOR.EXE�ļ�����λ�á�
set Masm32Dir=d:\Masm32

rem ����һ�㲻���޸�
set include=%Masm32Dir%\Include;%include%
set lib=%Masm32Dir%\lib;%lib%
set path=%Masm32Dir%\Bin;%Masm32Dir%;%PATH%
set Masm32Dir=

rem ��������ʾ�����õĻ�������include��lib��path�Ľ��ֵ��
set include
set lib
set path
echo on
pause
