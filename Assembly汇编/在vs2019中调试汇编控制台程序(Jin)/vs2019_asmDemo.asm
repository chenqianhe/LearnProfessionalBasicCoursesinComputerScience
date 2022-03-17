;;说明：(1) 为了在vs2019的汇编程序中调用C的函数，需要执行vs2019产生的初始化代码。
;;          该初始化代码会调用libcmt.lib中的_mainCRTStartup()，再由_mainCRTStartup()调用main()。
;;			所以，我们需要定义main函数（子程序）,同时需要将libcmt.lib包含进去（includelib libcmt.lib）
;;      (2) 由于程序入口是main()，因此不能再程序末尾的end语句上加标号，即不能 end start（start是第一条语句的标号）
;;      (3) C函数（如_mainCRTStartup()、printf()）都是按c规范调用函数，所以必须有语句 .model flat,c（不能是stdcall）
;;      (4) printf函数是在legacy_stdio_definitions.lib中定义的（需要includelib  legacy_stdio_definitions.lib）
;;功能：本程序演示了在汇编中调用C的scanf()和printf().

.686P
.model flat, c  ;;.model flat,stdcall（错误）
 MessageBoxA proto stdcall,:dword,:dword,:dword,:dword
 ExitProcess proto stdcall :dword
 scanf       proto c :vararg
 printf      proto c :vararg
 includelib  user32.lib						;;MessageBoxA()
 includelib  kernel32.lib					;;ExitProcess()
 includelib  libcmt.lib						;;_mainCRTStartup => main
 includelib  legacy_stdio_definitions.lib	;;printf

.data
 inMsg		db	"Input an integer: ", 0
 inFmt		db	"%ld",0
 outFmt		db	"The number is %ld", 0ah,0dh,0
 x			dd  0
 winMsg		db	"How are you", 0
 winTopic	db	"Title", 0

.stack	200

.code
main	proc
start:	
		invoke printf,offset inMsg
		invoke scanf,offset inFmt,offset x
		invoke printf,offset outFmt,x
		invoke MessageBoxA,0,offset winMsg,offset winTopic,0
		invoke ExitProcess, 0
main	endp
		end		;;end start（错误）
