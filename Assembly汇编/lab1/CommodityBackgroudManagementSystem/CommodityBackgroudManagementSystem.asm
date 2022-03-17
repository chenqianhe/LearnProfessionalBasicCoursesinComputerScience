.386     
.model flat, stdcall
 ExitProcess PROTO STDCALL :DWORD
 includelib  kernel32.lib  ; ExitProcess 在 kernel32.lib中实现
 printf PROTO C :VARARG
 scanf  PROTO C:VARARG
 includelib  ucrt.lib
 includelib  legacy_stdio_definitions.lib

.DATA
lpFmt   DB	"%s",0ah,0dh,0
npFmt   DB "%d",0
spFmt   DB  "%s",0
INAME   DB  12 DUP(0)
INPASS  DB  12 DUP(0)
BNAME  DB  "chenqianhe",0,0  ;老板姓名（要求必须是自己名字的拼音）
BPASS  DB  "U201915160",0,0  ;密码（必须是自己的学号）
N    EQU   30
GA1   DB   "PEN", 7 DUP(0)  ;商品1 名称
      DW   15,20,70,25,? ; 进货价、销售价、进货数量、已售数量,利润率（尚未计算）
GA2   DB  "PENCIL", 4 DUP(0) ;商品2 名称
      DW   2,3,100,50,?
GA3   DB   "BOOK", 6 DUP(0) ;商品3 名称
      DW   30,40,25,5,?
GA4   DB   "RULER",5 DUP(0)  ;商品4 名称
      DW   3,4,200,150,?
GAN   DB N-4 DUP( "TempValue" ,0,15,0,20,0,30,0,2,0,?,?) ;除了4个已经具体定义了的商品信息以外,其他商品信息暂时假定为一样的。
MENUTOP    DB  "                Commodity Backgroud Management System",10,
            "-----------------------------------------------------------------------",10,0
MENU    DB  "   1.Find the specified product and display its information",10,
            "   2.Selling",10,
            "   3.Replenishment",10,
            "   4.Calculate the profit margin of goods",10,
            "   5.Display commodity information from high to low profit margin",10,
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


.STACK 200
.CODE
main proc c
    MOV EAX,-1

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
    ;输入除此之外的内容
    JMP SHOWMENU
;操作1：
CHOICE1:
    invoke printf,offset lpFmt,OFFSET PROCUDTips
    MOV ECX,0
    MOV DWORD PTR INGOODS,ECX
    MOV DWORD PTR INGOODS[4],ECX
    MOV DWORD PTR INGOODS[8],ECX
    invoke scanf,offset spFmt,offset INGOODS
    PUSH EAX
;判断操作的物品，并将对应地址存住ESI
OP1GA1GUDGE:
    MOV ECX,0
OP1GA1LOOP:
    MOV AX,WORD PTR INGOODS[ECX*2]
    MOV BX,WORD PTR GA1[ECX*2]
    CMP AX,BX
    JNE OP1GA2JUAGE
    ADD ECX,1
    CMP ECX,5
    JNE OP1GA1LOOP

    MOV ESI,offset GA1
    JMP OP1

OP1GA2JUAGE:
    MOV ECX,0
OP1GA2LOOP:
    MOV AX,WORD PTR INGOODS[ECX*2]
    MOV BX,WORD PTR GA2[ECX*2]
    CMP AX,BX
    JNE OP1GA3JUAGE
    ADD ECX,1
    CMP ECX,5
    JNE OP1GA2LOOP

    MOV ESI,offset GA2
    JMP OP1

OP1GA3JUAGE:
    MOV ECX,0
OP1GA3LOOP:
    MOV AX,WORD PTR INGOODS[ECX*2]
    MOV BX,WORD PTR GA3[ECX*2]
    CMP AX,BX
    JNE OP1GA4JUDGE
    ADD ECX,1
    CMP ECX,5
    JNE OP1GA3LOOP

    MOV ESI,offset GA3
    JMP OP1

OP1GA4JUDGE:
    MOV ECX,0
OP1GA4LOOP:
    MOV AX,WORD PTR INGOODS[ECX*2]
    MOV BX,WORD PTR GA4[ECX*2]
    CMP AX,BX
    JNE OP1ERROR
    ADD ECX,1
    CMP ECX,5
    JNE OP1GA4LOOP

    MOV ESI,offset GA4
    JMP OP1

    MOV ECX,0
OP1:
    invoke printf,offset lpFmt,offset GOODINFO1
    invoke printf,offset lpFmt,ESI
    ;invoke printf,offset lpFmt,offset NEWLINE
    ADD ESI,10
    invoke printf,offset lpFmt,offset GOODINFO2
    MOV AX,WORD PTR [ESI]
    invoke printf,offset npFmt,AX
    invoke printf,offset lpFmt,offset NEWLINE
    ADD ESI,2
    invoke printf,offset lpFmt,offset GOODINFO3
    MOV AX,WORD PTR [ESI]
    invoke printf,offset npFmt,AX
    invoke printf,offset lpFmt,offset NEWLINE
    ADD ESI,2
    invoke printf,offset lpFmt,offset GOODINFO4
    MOV AX,WORD PTR [ESI]
    invoke printf,offset npFmt,AX
    invoke printf,offset lpFmt,offset NEWLINE
    ADD ESI,2
    invoke printf,offset lpFmt,offset GOODINFO5
    MOV AX,WORD PTR [ESI]
    invoke printf,offset npFmt,AX
    invoke printf,offset lpFmt,offset NEWLINE
    ADD ESI,2
    invoke printf,offset lpFmt,offset GOODINFO6
    MOV AX,WORD PTR [ESI]
    SHR AX,15
    CMP AX,1
    JNE OP1POSPRI

    invoke printf,offset lpFmt,offset FUHAO
    MOV AX,WORD PTR [ESI]
    IMUL AX,-1
    invoke printf,offset npFmt,AX
    invoke printf,offset lpFmt,offset BAIFENHAO

    POP EAX
    JMP SHOWMENU
OP1POSPRI:
    MOV AX,WORD PTR [ESI]
    invoke printf,offset npFmt,AX
    invoke printf,offset lpFmt,offset BAIFENHAO
    ;invoke printf,offset lpFmt,offset NEWLINE

    POP EAX
    JMP SHOWMENU
OP1ERROR:
    invoke printf,offset lpFmt,OFFSET GOODSERROR
    POP EAX
    JMP SHOWMENU

;操作2
CHOICE2:
    invoke printf,offset lpFmt,OFFSET PROCUDTips
    MOV ECX,0
    MOV DWORD PTR INGOODS,ECX
    MOV DWORD PTR INGOODS[4],ECX
    MOV DWORD PTR INGOODS[8],ECX
    invoke scanf,offset spFmt,offset INGOODS
    PUSH EAX
;判断操作的物品，并将对应地址存住ESI
OP2GA1JUDGE:
    MOV ECX,0
OP2GA1LOOP:
    MOV AX,WORD PTR INGOODS[ECX*2]
    MOV BX,WORD PTR GA1[ECX*2]
    CMP AX,BX
    JNE OP2GA2JUDGE
    ADD ECX,1
    CMP ECX,5
    JNE OP2GA1LOOP

    MOV ESI,offset GA1
    JMP OP2

OP2GA2JUDGE:
    MOV ECX,0
OP2GA2LOOP:
    MOV AX,WORD PTR INGOODS[ECX*2]
    MOV BX,WORD PTR GA2[ECX*2]
    CMP AX,BX
    JNE OP2GA3JUDGE
    ADD ECX,1
    CMP ECX,5
    JNE OP2GA2LOOP

    MOV ESI,offset GA2
    JMP OP2

OP2GA3JUDGE:
    MOV ECX,0
OP2GA3LOOP:
    MOV AX,WORD PTR INGOODS[ECX*2]
    MOV BX,WORD PTR GA3[ECX*2]
    CMP AX,BX
    JNE OP2GA4JUDGE
    ADD ECX,1
    CMP ECX,5
    JNE OP2GA3LOOP

    MOV ESI,offset GA3
    JMP OP2

OP2GA4JUDGE:
    MOV ECX,0
OP2GA4LOOP:
    MOV AX,WORD PTR INGOODS[ECX*2]
    MOV BX,WORD PTR GA4[ECX*2]
    CMP AX,BX
    JNE OP2ERROR
    ADD ECX,1
    CMP ECX,5
    JNE OP2GA4LOOP

    MOV ESI,offset GA4
    JMP OP2

    MOV ECX,0
OP2:
    invoke printf,offset lpFmt,offset GOODINFO1
    invoke printf,offset lpFmt,ESI
    ;invoke printf,offset lpFmt,offset NEWLINE
    ADD ESI,14
    MOV AX,WORD PTR [ESI]
    ADD ESI,2
    MOV BX,WORD PTR [ESI]
    SUB AX,BX
    MOV BX,AX
    invoke printf,offset lpFmt,offset OP2INFO1
    invoke scanf,offset npFmt,offset SALENUM
    CMP WORD PTR SALENUM,BX
    JNLE  OP2ERROR2
    MOV BX,WORD PTR [ESI]
    ADD BX,WORD PTR SALENUM
    MOV WORD PTR [ESI],BX
    
    POP EAX
    JMP SHOWMENU
OP2ERROR:
    invoke printf,offset lpFmt,OFFSET GOODSERROR
    POP EAX
    JMP SHOWMENU
OP2ERROR2:
    invoke printf,offset lpFmt,OFFSET SALEERROR
    POP EAX
    JMP SHOWMENU

;操作3
CHOICE3:
    invoke printf,offset lpFmt,OFFSET PROCUDTips
    MOV ECX,0
    MOV DWORD PTR INGOODS,ECX
    MOV DWORD PTR INGOODS[4],ECX
    MOV DWORD PTR INGOODS[8],ECX
    invoke scanf,offset spFmt,offset INGOODS
    PUSH EAX
;判断操作的物品，并将对应地址存住ESI
OP3GA1GUDGE:
    MOV ECX,0
OP3GA1LOOP:
    MOV AX,WORD PTR INGOODS[ECX*2]
    MOV BX,WORD PTR GA1[ECX*2]
    CMP AX,BX
    JNE OP3GA2JUAGE
    ADD ECX,1
    CMP ECX,5
    JNE OP3GA1LOOP

    MOV ESI,offset GA1
    JMP OP3

OP3GA2JUAGE:
    MOV ECX,0
OP3GA2LOOP:
    MOV AX,WORD PTR INGOODS[ECX*2]
    MOV BX,WORD PTR GA2[ECX*2]
    CMP AX,BX
    JNE OP3GA3JUAGE
    ADD ECX,1
    CMP ECX,5
    JNE OP3GA2LOOP

    MOV ESI,offset GA2
    JMP OP3

OP3GA3JUAGE:
    MOV ECX,0
OP3GA3LOOP:
    MOV AX,WORD PTR INGOODS[ECX*2]
    MOV BX,WORD PTR GA3[ECX*2]
    CMP AX,BX
    JNE OP3GA4JUDGE
    ADD ECX,1
    CMP ECX,5
    JNE OP3GA3LOOP

    MOV ESI,offset GA3
    JMP OP3

OP3GA4JUDGE:
    MOV ECX,0
OP3GA4LOOP:
    MOV AX,WORD PTR INGOODS[ECX*2]
    MOV BX,WORD PTR GA4[ECX*2]
    CMP AX,BX
    JNE OP3ERROR
    ADD ECX,1
    CMP ECX,5
    JNE OP3GA4LOOP

    MOV ESI,offset GA4
    JMP OP3

    MOV ECX,0
OP3:
    invoke printf,offset lpFmt,offset GOODINFO1
    invoke printf,offset lpFmt,ESI
    ;invoke printf,offset lpFmt,offset NEWLINE
    ADD ESI,14
    MOV BX,WORD PTR [ESI]
    invoke printf,offset lpFmt,offset OP3INFO1
    invoke scanf,offset npFmt,offset INNUM
    MOV EAX,0
    CMP AX,WORD PTR INNUM
    JNLE  OP3ERROR2
    ADD BX,WORD PTR INNUM
    MOV WORD PTR [ESI],BX

    POP EAX
    JMP SHOWMENU
OP3ERROR:
    invoke printf,offset lpFmt,OFFSET GOODSERROR
    POP EAX
    JMP SHOWMENU
OP3ERROR2:
    invoke printf,offset lpFmt,OFFSET GOODSINERROR
    JMP SHOWMENU
;操作4
CHOICE4:
    invoke printf,offset lpFmt,OFFSET PROCUDTips
    MOV ECX,0
    MOV DWORD PTR INGOODS,ECX
    MOV DWORD PTR INGOODS[4],ECX
    MOV DWORD PTR INGOODS[8],ECX
    invoke scanf,offset spFmt,offset INGOODS
    PUSH EAX
;判断操作的物品，并将对应地址存住ESI
OP4GA1GUDGE:
    MOV ECX,0
OP4GA1LOOP:
    MOV AX,WORD PTR INGOODS[ECX*2]
    MOV BX,WORD PTR GA1[ECX*2]
    CMP AX,BX
    JNE OP4GA2JUAGE
    ADD ECX,1
    CMP ECX,5
    JNE OP4GA1LOOP

    MOV ESI,offset GA1
    JMP OP4

OP4GA2JUAGE:
    MOV ECX,0
OP4GA2LOOP:
    MOV AX,WORD PTR INGOODS[ECX*2]
    MOV BX,WORD PTR GA2[ECX*2]
    CMP AX,BX
    JNE OP4GA3JUAGE
    ADD ECX,1
    CMP ECX,5
    JNE OP4GA2LOOP

    MOV ESI,offset GA2
    JMP OP4

OP4GA3JUAGE:
    MOV ECX,0
OP4GA3LOOP:
    MOV AX,WORD PTR INGOODS[ECX*2]
    MOV BX,WORD PTR GA3[ECX*2]
    CMP AX,BX
    JNE OP4GA4JUDGE
    ADD ECX,1
    CMP ECX,5
    JNE OP4GA3LOOP

    MOV ESI,offset GA3
    JMP OP4

OP4GA4JUDGE:
    MOV ECX,0
OP4GA4LOOP:
    MOV AX,WORD PTR INGOODS[ECX*2]
    MOV BX,WORD PTR GA4[ECX*2]
    CMP AX,BX
    JNE OP4ERROR
    ADD ECX,1
    CMP ECX,5
    JNE OP4GA4LOOP

    MOV ESI,offset GA4
    JMP OP4

    MOV ECX,0
OP4:
    invoke printf,offset lpFmt,offset GOODINFO1
    invoke printf,offset lpFmt,ESI
    ;invoke printf,offset lpFmt,offset NEWLINE
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
    
    CMP BX,AX
    JNLE POSI
    PUSH AX
    PUSH BX
    PUSH AX
    POP BX
    POP AX

    SUB BX,AX
    POP AX
    MOV CX,BX
    IMUL CX,100
    MOV DX,0
    PUSH AX
    PUSH CX
    POP AX
    POP CX
    IDIV CX
    IMUL AX,-1
    MOV WORD PTR [ESI]+18,AX
    JMP SHOWRATE

POSI:
    SUB BX,AX
    MOV CX,BX
    IMUL CX,100
    MOV DX,0
    PUSH AX
    PUSH CX
    POP AX
    POP CX
    IDIV CX
    MOV WORD PTR [ESI]+18,AX
SHOWRATE:
    invoke printf,offset lpFmt,offset GOODINFO6
    MOV ECX,0
    MOV CX,WORD PTR [ESI]+18
    SHR CX,15
    CMP CX,1
    JNE PPOSI

    invoke printf,offset lpFmt,offset FUHAO
    MOV ECX,0
    MOV CX,WORD PTR [ESI]+18
    IMUL CX,-1
    invoke printf,offset npFmt,CX
    invoke printf,offset lpFmt,offset BAIFENHAO
    POP EAX 
    JMP SHOWMENU
PPOSI:
    MOV ECX,0
    MOV CX,WORD PTR [ESI]+18
    invoke printf,offset npFmt,CX
    invoke printf,offset lpFmt,offset BAIFENHAO

    POP EAX
    JMP SHOWMENU
OP4ERROR:
    invoke printf,offset lpFmt,OFFSET GOODSERROR
    POP EAX
    JMP SHOWMENU

CHOICE5:
    
    JMP SHOWMENU


LOGINERRORMARK:
    invoke printf,offset lpFmt,OFFSET LOGINERROR
EXITMARK:
    invoke ExitProcess, 0
main endp
END