.386     
.model flat, stdcall
 ExitProcess PROTO STDCALL :DWORD
 includelib  kernel32.lib  ; ExitProcess 在 kernel32.lib中实现
 printf PROTO C :VARARG
 scanf  PROTO C:VARARG
 includelib  ucrt.lib
 includelib  legacy_stdio_definitions.lib

.DATA
x dw 10,20


.STACK 200
.CODE
main proc c
	call display
	
	mas1 db 'good',0ah,0dh,0

	call display
	
	mas2 db 'good',0ah,0dh,0

	invoke ExitProcess,0
main endp

display proc
	
	pop ebx

p1:
	cmp byte ptr [ebx],0
	je exit
	add ebx,1
	jmp p1

exit:
	inc ebx 
	pop ebx
	ret
display endp
END