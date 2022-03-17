	QEMU汇编语言环境

内容：
MASM 6.0
Link 5
Turbo Debugger 3.1
DOS7.1
Borland C 3.1（含Tasm、Tlink、TD、BCC、BC）
QEMU
WinImage

用法：
1、双击运行dosAsm.cmd
   即启动Qemu虚拟机映像文件dosAsm.vmdk，进入MS-DOS 7.1环境。
   然后可执行Edit、MASM（或ML）、Link、Tasm、Tlink、BCC、BC、TD等等命令，
   完成编辑、汇编/编译、连接、调试程序。

2、拖dosAsm.vmdk到dosAsm.cmd
   即以WinImage打开映像文件dosAsm.vmdk。可拖放文件实现虚拟机与宿主机沟通。

注：
1、鼠标不灵的话需纯键盘操作。TD、BC全屏时可能鼠标灵。
2、遇报毒自行处理。

补充：
1、这里Edit是QEdit。基本用法：
   F1帮助、F2存盘、ALT+X退出。
2、Qemu基本操作：
   Ctrl+Alt+G将鼠标从虚拟机中释放，归宿主机控制。
   Ctrl+Alt+F全屏/非全屏切换。
   Ctrl+Alt+Q退出。
3、dosAsm.vmdk不要改名。拖dosAsm.vmdk到dosAsm.cmd之前，
   要关掉Qemu窗口以释放其对dosAsm.vmdk的占用（锁定）。
   dosAsm.vmdk也可用作VMware虚拟硬盘映像文件。
4、键入bc回车即可进入Borland C 3.1，ALT+X退出。

						班鹏新  2017.4.9