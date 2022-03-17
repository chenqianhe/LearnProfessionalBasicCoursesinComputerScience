;clockTest.asm:
.686P 
.model flat, c
  include winTimer.asm
  ExitProcess proto stdcall :dword
  Sleep proto stdcall :dword
  includelib  kernel32.lib
.stack   200
.code
main proc
  invoke winTimer,0	;;启动计时
  invoke Sleep, 3000;需要计时的程序
  invoke winTimer,1	;;结束计时并显示计时信息（毫秒）
  invoke ExitProcess, 0
main  endp
end
;--以下是上面include需要的文件winTimer.asm的内容。放在end后不起作用，只为留个备份--
;;win32汇编计时子程序winTimer.asm：
;;使用方法：在你的.asm文件中适当地方加入如下语句：
;;	include winTimer.asm	;假定winTimer.asm在你的.asm文件所在目录
;;	... ...
;;	invoke winTimer,0	;;启动计时
;;	;;需要计时的程序
;;	invoke winTimer,1	;;结束计时并显示计时信息（毫秒）
;;

timeGetTime proto stdcall
includelib  Winmm.lib
printf      proto c :vararg
includelib  libcmt.lib
includelib  legacy_stdio_definitions.lib
.DATA
__t1		dd	?
__t2		dd	?
__fmtTime	db	0ah,0dh,"Time elapsed is %ld ms",2 dup(0ah,0dh),0

.CODE
winTimer	proc stdcall, flag:DWORD
		jmp	__L1
__L1:		call	timeGetTime
		cmp	flag, 0
		jnz	__L2
		mov	__t1, eax
		ret	4
__L2:		mov	__t2, eax
		sub	eax, __t1
		invoke	printf,offset __fmtTime,eax
		ret	4
winTimer	endp
