.386     
.model flat, stdcall

.CODE
cmpstr proc stdcall,p1:dword,p2:dword,l:dword
    LOCAL TEMPvalue:DWORD 
    MOV ESI,p1
    MOV EDI,p2
    MOV ECX,l
    CLD
    REPE CMPSB
    JNZ NOTEQU
    MOV EAX,1
    ret
NOTEQU:
    MOV EAX,0
    ret
cmpstr endp
END
