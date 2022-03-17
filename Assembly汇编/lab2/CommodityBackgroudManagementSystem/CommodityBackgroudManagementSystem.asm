.386     
.model flat, stdcall
 ExitProcess PROTO STDCALL :DWORD
 includelib  kernel32.lib  ; ExitProcess 在 kernel32.lib中实现
 printf PROTO C :VARARG
 scanf  PROTO C:VARARG
 includelib  ucrt.lib
 includelib  legacy_stdio_definitions.lib
 include winTimer.asm
 Sleep proto stdcall :dword


GOODS  STRUCT
    GOODSNAME  db 10 DUP(0)
    BUYPRICE   DW  0
    SELLPRICE  DW  0
    BUYNUM     DW  0
    SELLNUM    DW  0
    RATE       DW  0
GOODS  ENDS

.DATA
lpFmt   DB	"%s",0ah,0dh,0
npFmt   DB "%d",0
spFmt   DB  "%s",0
INAME   DB  12 DUP(0)
INPASS  DB  12 DUP(0)
BNAME  DB  "chenqianhe",0,0  ;老板姓名（要求必须是自己名字的拼音）
BPASS  DB  "U201915160",0,0  ;密码（必须是自己的学号）
N    EQU   30
GA1   GOODS   <"PEN", 15, 20, 70, 25, 0>  ;商品1 名称, 进货价、销售价、进货数量、已售数量,利润率（尚未计算）
GA2   GOODS  <"PENCIL", 2, 3, 100, 50, 0>
GA3   GOODS   <"BOOK", 30, 40, 25, 5, 0>
GA4   GOODS   <"RULER", 3, 4, 200, 150,0>
GAN   DB N-4 DUP( "TempValue" ,0,15,0,20,0,30,0,2,0,?,?) ;除了4个已经具体定义了的商品信息以外,其他商品信息暂时假定为一样的。
MENUTOP    DB  "                Commodity Backgroud Management System",10,
            "-----------------------------------------------------------------------",10,0
MENU    DB  "   1.Find the specified product and display its information",10,
            "   2.Selling",10,
            "   3.Replenishment",10,
            "   4.Calculate the profit margin of goods",10,
            "   5.Display commodity information from high to low profit margin",10,
            "   t.TESTTIME",10,
            "   9.Sign out",10,0
MENUBOTTOM  DB  "-----------------------------------------------------------------------",10,0
WELCOME DB  "                       Welcome to login system!",10,0
COUNTips    DB  "Please enter the account number:",0
PASSTips    DB  "Please input a password:",0
INPUTips    DB  "Please select your operation[1-9]:",0
PROCUDTips  DB  "Existing goods:PEN,PENCIL,BOOK,RULER,Please enter the item you want to operate:",0
SELLTips    DB  "Please input sales quantity:",0
REPLENISHMENTips    DB  "Please input replenishment quantity",0
LOGINERROR  DB  "Wrong user name or password!",0
NEWLINE DB  10,0
CHOICE  DB  4 DUP(0)
INGOODS DB  13 DUP(0)
GOODSERROR  DB  "Wrong trade name!",0
SALEERROR   DB  "Insufficient inventory!",0
GOODSINERROR    DB  "Quantity cannot be negative!",0
GOODINFO1   DB  "商品名称：",0
GOODINFO2   DB  "进货价：",0
GOODINFO3   DB  "销售价：",0
GOODINFO4   DB  "进货数量：",0
GOODINFO5   DB  "已售数量：",0
GOODINFO6   DB  "利润率：",0
OP2INFO1    DB  "请输入出售数量：",0
OP3INFO1    DB  "请输入进货数量：",0
SALENUM DW  0,0
INNUM   DW  0,0
BAIFENHAO   DB  "%",0
FUHAO   DB  "-",0,0,0
ARRAY DD 0,0,0,0,0,0,0,0


.STACK 200
.CODE
main proc c
    MOV EAX,-1
    JMP SHOWMENU

    ;登录，提示输入用户名和密码
    invoke printf,offset lpFmt,OFFSET MENUTOP
    invoke printf,offset lpFmt,OFFSET WELCOME
    invoke printf,offset lpFmt,OFFSET MENUBOTTOM
    invoke printf,offset lpFmt,OFFSET COUNTips
    invoke scanf,offset spFmt,OFFSET INAME
    invoke printf,offset lpFmt,OFFSET PASSTips
    invoke scanf,offset spFmt,OFFSET INPASS

    ;判断账号和密码的正确性
    MOV ECX,0
NAMEJUDGE:
    MOV EAX,DWORD PTR INAME[ECX*4]
    MOV EBX,DWORD PTR BNAME[ECX*4]
    CMP EAX,EBX
    JNE LOGINERRORMARK
    ADD ECX,1
    CMP ECX,3
    JNE NAMEJUDGE
    
    MOV ECX,0
PASSJUDGE:
    MOV EAX,DWORD PTR INPASS[ECX*4]
    MOV EBX,DWORD PTR BPASS[ECX*4]
    CMP EAX,EBX
    JNE LOGINERRORMARK
    ADD ECX,1
    CMP ECX,3
    JNE PASSJUDGE

    MOV EAX,-1  ;记录选项
SHOWMENU:
    ;打印菜单
    invoke printf,offset lpFmt,OFFSET MENUTOP
    invoke printf,offset lpFmt,OFFSET MENU
    invoke printf,offset lpFmt,OFFSET MENUBOTTOM
    invoke printf,offset lpFmt,OFFSET INPUTips
    ;输入选项
    MOV EAX,0
    MOV DWORD PTR CHOICE,EAX
    invoke scanf,offset spFmt,offset CHOICE
    MOV EAX,DWORD PTR CHOICE
    ;跳转
    CMP EAX,'9'
    JE EXITMARK
    CMP EAX,'1'
    JE CHOICE1
    CMP EAX,'2'
    JE CHOICE2
    CMP EAX,'3'
    JE CHOICE3
    CMP EAX,'4'
    JE CHOICE4
    CMP EAX,'5'
    JE CHOICE5
    CMP EAX,'t'
    JE TESTTIME
    ;输入除此之外的内容
    JMP SHOWMENU
;操作1：
CHOICE1:
    PUSH EAX
    CALL findgoods
    MOV EAX,offset GA1
    ADD EAX,80
    CMP EAX,ESI
    JLE GOODERROR 
    ;打印名称
    invoke printf,offset lpFmt,offset GOODINFO1
    invoke printf,offset lpFmt,ESI
    ;打印进货价
    invoke printf,offset lpFmt,offset GOODINFO2
    MOV AX,WORD PTR [ESI+10]
    invoke printf,offset npFmt,AX
    invoke printf,offset lpFmt,offset NEWLINE
    ;打印销售价
    invoke printf,offset lpFmt,offset GOODINFO3
    MOV AX,WORD PTR [ESI+12]
    invoke printf,offset npFmt,AX
    invoke printf,offset lpFmt,offset NEWLINE
    ;打印进货数量
    invoke printf,offset lpFmt,offset GOODINFO4
    MOV AX,WORD PTR [ESI+14]
    invoke printf,offset npFmt,AX
    invoke printf,offset lpFmt,offset NEWLINE
    ;打印已售数量
    invoke printf,offset lpFmt,offset GOODINFO5
    MOV AX,WORD PTR [ESI+16]
    invoke printf,offset npFmt,AX
    invoke printf,offset lpFmt,offset NEWLINE
    ;打印利润率
    invoke printf,offset lpFmt,offset GOODINFO6
    MOVSX EAX,WORD PTR [ESI+18]
    invoke printf,offset npFmt,EAX
    invoke printf,offset lpFmt,offset BAIFENHAO

    POP EAX
    JMP SHOWMENU
;操作2
CHOICE2:
    PUSH EAX
    CALL findgoods
    MOV EAX,offset GA1
    ADD EAX,80
    CMP EAX,ESI
    JLE GOODERROR
    
    invoke printf,offset lpFmt,offset GOODINFO1
    invoke printf,offset lpFmt,ESI
    MOV AX,WORD PTR [ESI+14]
    MOV BX,WORD PTR [ESI+16]
    SUB AX,BX
    MOV BX,AX
    invoke printf,offset lpFmt,offset OP2INFO1
    invoke scanf,offset npFmt,offset SALENUM
    CMP WORD PTR SALENUM,BX
    JNLE  OP2ERROR
    MOV BX,WORD PTR [ESI+16]
    ADD BX,WORD PTR SALENUM
    MOV WORD PTR [ESI+16],BX
    POP EAX
    JMP SHOWMENU
OP2ERROR:
    invoke printf,offset lpFmt,OFFSET SALEERROR
    POP EAX
    JMP SHOWMENU
;操作3
CHOICE3:
    PUSH EAX
    CALL findgoods
    MOV EAX,offset GA1
    ADD EAX,80
    CMP EAX,ESI
    JLE GOODERROR
    
    invoke printf,offset lpFmt,offset GOODINFO1
    invoke printf,offset lpFmt,ESI
    MOV BX,WORD PTR [ESI+14]
    invoke printf,offset lpFmt,offset OP3INFO1
    invoke scanf,offset npFmt,offset INNUM
    MOV EAX,0
    CMP AX,WORD PTR INNUM
    JNLE  OP3ERROR
    ADD BX,WORD PTR INNUM
    MOV WORD PTR [ESI+14],BX
    POP EAX
    JMP SHOWMENU
OP3ERROR:
    invoke printf,offset lpFmt,OFFSET GOODSINERROR
    JMP SHOWMENU
;操作4
CHOICE4:
    
    PUSH EAX
    CALL findgoods
    MOV EAX,offset GA1
    ADD EAX,80
    CMP EAX,ESI
    JLE GOODERROR 

    invoke printf,offset lpFmt,offset GOODINFO1
    invoke printf,offset lpFmt,ESI

    CALL cal

    POP EAX
    JMP SHOWMENU
;操作5
CHOICE5:
    PUSH EAX
    CALL sort
    POP EAX
    JMP SHOWMENU

TESTTIME:
    MOV EDI,0
    invoke winTimer,0	;;启动计时
TIMELOOP:    
    MOV ESI,offset GA1
    CALL cal
    MOV ESI,offset GA2
    CALL cal
    MOV ESI,offset GA3
    CALL cal
    MOV ESI,offset GA4
    CALL cal

    CALL sort
    ADD EDI,1
    CMP EDI,1000
    JNE TIMELOOP

    invoke winTimer,1	;;结束计时并显示计时信息（毫秒）

GOODERROR:
    invoke printf,offset lpFmt,OFFSET GOODSERROR
    POP EAX
    JMP SHOWMENU

LOGINERRORMARK:
    invoke printf,offset lpFmt,OFFSET LOGINERROR
EXITMARK:
    invoke ExitProcess, 0
main endp

cal proc
    ;优化后
    MOV EAX,0
    MOV EBX,0
    MOV ECX,0
    MOV EDX,0
    MOV AX,WORD PTR [ESI]+10
    MOV BX,WORD PTR [ESI]+12
    MOV CX,WORD PTR [ESI]+14
    MOV DX,WORD PTR [ESI]+16
    IMUL AX,CX
    IMUL BX,DX

    SUB BX,AX
    MOV CX,BX

    MOV DX,0
    XCHG AX,CX
    MOV EBX,0
    MOV BX,100
    IMUL BX
    IDIV CX
    MOV WORD PTR [ESI]+18,AX

    invoke printf,offset lpFmt,offset GOODINFO6
    MOV EAX,0
    MOVSX EAX,WORD PTR [ESI]+18
    invoke printf,offset npFmt,EAX
    invoke printf,offset lpFmt,offset BAIFENHAO

    RET
cal endp


sort proc
MOV ESI,OFFSET ARRAY
    MOV EAX,OFFSET GA1+18
    MOV DWORD PTR [ESI],EAX
    MOV EBX,OFFSET GA2+18
    MOV DWORD PTR [ESI+32],EBX
    MOV ECX,OFFSET GA3+18
    MOV DWORD PTR [ESI+64],ECX
    MOV EDX,OFFSET GA4+18
    MOV DWORD PTR [ESI+96],EDX

    MOV ESI,0
    
OUTSIDELOOP:

    CMP ESI,3
    JE OUTLOOP
    PUSH ESI
    MOV SI,WORD PTR [EAX]
    CMP SI,WORD PTR [EBX]
    JNL LOOP2
    XCHG EAX,EBX
LOOP2:
    MOV SI,WORD PTR[EBX]
    CMP SI,WORD PTR [ECX]
    JNL LOOP3
    XCHG EBX,ECX
LOOP3:
    MOV SI,WORD PTR[ECX]
    CMP SI,WORD PTR [EDX]
    JNL OUTCHG
    XCHG ECX,EDX
OUTCHG:
    POP ESI
    ADD ESI,1
    JMP OUTSIDELOOP
OUTLOOP:
    PUSHAD
    SUB EAX,18
    invoke printf,offset lpFmt,EAX
    POPAD
    PUSHAD
    invoke printf,offset lpFmt,offset GOODINFO6
    POPAD
    PUSHAD
    MOVSX ESI,WORD PTR [EAX]
    invoke printf,offset npFmt,ESI
    POPAD
    PUSHAD
    invoke printf,offset lpFmt,offset BAIFENHAO
    POPAD

    PUSHAD
    SUB EBX,18
    invoke printf,offset lpFmt,EBX
    POPAD
    PUSHAD
    invoke printf,offset lpFmt,offset GOODINFO6
    POPAD
    PUSHAD
    MOVSX ESI,WORD PTR [EBX]
    invoke printf,offset npFmt,ESI
    POPAD
    PUSHAD
    invoke printf,offset lpFmt,offset BAIFENHAO
    POPAD

    PUSHAD
    SUB ECX,18
    invoke printf,offset lpFmt,ECX
    POPAD
    PUSHAD
    invoke printf,offset lpFmt,offset GOODINFO6
    POPAD
    PUSHAD
    MOVSX ESI,WORD PTR [ECX]
    invoke printf,offset npFmt,ESI
    POPAD
    PUSHAD
    invoke printf,offset lpFmt,offset BAIFENHAO
    POPAD

    PUSHAD
    SUB EDX,18
    invoke printf,offset lpFmt,EDX
    POPAD
    PUSHAD
    invoke printf,offset lpFmt,offset GOODINFO6
    POPAD
    PUSHAD
    MOVSX ESI,WORD PTR [EDX]
    invoke printf,offset npFmt,ESI
    POPAD
    PUSHAD
    invoke printf,offset lpFmt,offset BAIFENHAO
    POPAD

    RET
sort endp


findgoods proc
    invoke printf,offset lpFmt,OFFSET PROCUDTips
    MOV ECX,0
    MOV DWORD PTR INGOODS,ECX
    MOV DWORD PTR INGOODS[4],ECX
    MOV DWORD PTR INGOODS[8],ECX
    invoke scanf,offset spFmt,offset INGOODS

    MOV ESI,offset GA1
    MOV ECX,0
    SUB ESI,20
FINDGOOD:
    MOV EDX,0
    ADD ESI,20
    ADD ECX,1
    CMP ECX,5
    JNE FINDLOOP
    RET

FINDLOOP:
    MOV AX,WORD PTR INGOODS[EDX*2]
    MOV BX,WORD PTR [ESI][EDX*2]
    CMP AX,BX
    JNE FINDGOOD
    ADD EDX,1
    CMP EDX,5
    JNE FINDLOOP
    RET

findgoods endp
END