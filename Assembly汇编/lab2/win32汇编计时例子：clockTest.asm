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
  invoke winTimer,0	;;������ʱ
  invoke Sleep, 3000;��Ҫ��ʱ�ĳ���
  invoke winTimer,1	;;������ʱ����ʾ��ʱ��Ϣ�����룩
  invoke ExitProcess, 0
main  endp
end
;--����������include��Ҫ���ļ�winTimer.asm�����ݡ�����end�������ã�ֻΪ��������--
;;win32����ʱ�ӳ���winTimer.asm��
;;ʹ�÷����������.asm�ļ����ʵ��ط�����������䣺
;;	include winTimer.asm	;�ٶ�winTimer.asm�����.asm�ļ�����Ŀ¼
;;	... ...
;;	invoke winTimer,0	;;������ʱ
;;	;;��Ҫ��ʱ�ĳ���
;;	invoke winTimer,1	;;������ʱ����ʾ��ʱ��Ϣ�����룩
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
