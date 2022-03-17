;;
;;win32汇编计时子程序
;;使用方法：在你的.asm文件中加入如下语句：
;;	include winTimer.asm
;;
;;	... ...
;;	invoke winTimer 0	;;启动计时
;;	... ...		;;需要计时的程序
;;	... ...
;;	invoke winTimer 1	;;结束计时并显示计时信息（毫秒）
;;

timeGetTime proto stdcall
includelib  Winmm.lib

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
