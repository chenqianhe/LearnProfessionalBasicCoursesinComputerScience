.386     
.model flat, stdcall
 ExitProcess PROTO STDCALL :DWORD
 includelib  kernel32.lib  ; ExitProcess 在 kernel32.lib中实现
 printf PROTO C:VARARG
 scanf  PROTO C:VARARG
 login  PROTO C:VARARG
 showmenuC PROTO C:VARARG
 addgoodsC PROTO C:VARARG
 includelib  ucrt.lib
 includelib  legacy_stdio_definitions.lib
 cmpstr proto:dword,:dword,:dword

 
myprint macro A,B
        PUSHAD
        invoke printf, A, B
        POPAD
        endm

GOODS  STRUCT
    GOODSNAME  db 10 DUP(0)
    BUYPRICE   DW  0
    SELLPRICE  DW  0
    BUYNUM     DW  0
    SELLNUM    DW  0
    RATE       DW  0
GOODS  ENDS

EXTERN rname:byte

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
PUBLIC GAN
GAN   GOODS N-4 DUP (<"TempValue" ,15,20,30,2,0>) ;除了4个已经具体定义了的商品信息以外,其他商品信息暂时假定为一样的。
PUBLIC GANUM
GANUM   DW 4,0

MENUTOP    DB  "                Commodity Backgroud Management System",10,
            "-----------------------------------------------------------------------",10,0
MENU    DB  "   1.Find the specified product and display its information",10,
            "   2.Selling",10,
            "   3.Replenishment",10,
            "   4.Calculate the profit margin of goods",10,
            "   5.Display commodity information from high to low profit margin",10,
            "   6.Increase commodities",10,
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
ADRESSARRAY DD N DUP(0)
NUMARRAY DB N DUP(0)

.STACK 200
.CODE


main proc c
    MOV EAX,-1
    ;MOV al,byte ptr rname

    ;JMP SHOWMENU

    ;登录，提示输入用户名和密码
    myprint offset lpFmt,OFFSET MENUTOP
    myprint offset lpFmt,OFFSET WELCOME
    myprint offset lpFmt,OFFSET MENUBOTTOM
    ;myprint offset lpFmt,OFFSET COUNTips
    ;invoke scanf,offset spFmt,OFFSET INAME
    ;myprint offset lpFmt,OFFSET PASSTips
    ;invoke scanf,offset spFmt,OFFSET INPASS
    CALL login
    CMP EAX,1
    JNE LOGINERRORMARK

    ;判断账号和密码的正确性
    ;MOV ECX,0
    ;NAMEJUDGE:
    ;invoke cmpstr, offset INAME, offset BNAME, 12
    ;CMP EAX,1
    ;JNE LOGINERRORMARK

    ;PASSJUDGE:
    ;invoke cmpstr, offset INPASS, offset BPASS, 12
    ;CMP EAX,1
    ;JNE LOGINERRORMARK

    MOV EAX,-1  ;记录选项
SHOWMENU:
    ;打印菜单
    ;myprint offset lpFmt,OFFSET MENUTOP
    ;myprint offset lpFmt,OFFSET MENU
    ;myprint offset lpFmt,OFFSET MENUBOTTOM
    call showmenuC
    myprint offset lpFmt,OFFSET INPUTips
    


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
    CMP EAX,'6'
    JE CHOICE6
    ;输入除此之外的内容
    JMP SHOWMENU
;操作1：
CHOICE1:
    PUSH EAX
    CALL findgoods
    MOV EBX,20
    IMUL BX,GANUM
    MOV EAX,offset GA1
    ADD EAX,EBX
    CMP EAX,ESI
    JLE GOODERROR 
    ;打印名称
    myprint offset lpFmt,offset GOODINFO1
    myprint offset lpFmt,ESI
    ;打印进货价
    myprint offset lpFmt,offset GOODINFO2
    MOV AX,WORD PTR [ESI+10]
    myprint offset npFmt,AX
    myprint offset lpFmt,offset NEWLINE
    ;打印销售价
    myprint offset lpFmt,offset GOODINFO3
    MOV AX,WORD PTR [ESI+12]
    myprint offset npFmt,AX
    myprint offset lpFmt,offset NEWLINE
    ;打印进货数量
    myprint offset lpFmt,offset GOODINFO4
    MOV AX,WORD PTR [ESI+14]
    myprint offset npFmt,AX
    myprint offset lpFmt,offset NEWLINE
    ;打印已售数量
    myprint offset lpFmt,offset GOODINFO5
    MOV AX,WORD PTR [ESI+16]
    myprint offset npFmt,AX
    myprint offset lpFmt,offset NEWLINE
    ;打印利润率
    myprint offset lpFmt,offset GOODINFO6
    MOVSX EAX,WORD PTR [ESI+18]
    myprint offset npFmt,EAX
    myprint offset lpFmt,offset BAIFENHAO

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
    
    CALL sell
    
    POP EAX
    JMP SHOWMENU
;操作3
CHOICE3:
    PUSH EAX
    CALL findgoods
    MOV EBX,20
    IMUL BX,GANUM
    MOV EAX,offset GA1
    ADD EAX,EBX
    CMP EAX,ESI
    JLE GOODERROR

    CALL purchase
    
    POP EAX
    JMP SHOWMENU
;操作4
CHOICE4:
    
    PUSH EAX
    CALL findgoods
    MOV EBX,20
    IMUL BX,GANUM
    MOV EAX,offset GA1
    ADD EAX,EBX
    CMP EAX,ESI
    JLE GOODERROR 

    CALL cal

    POP EAX
    JMP SHOWMENU
;操作5
CHOICE5:
    PUSH EAX

    CALL sort

    POP EAX
    JMP SHOWMENU
;操作6
CHOICE6:
    PUSH EAX

    CALL addgoodsC

    POP EAX
    JMP SHOWMENU

GOODERROR:
    myprint offset lpFmt,OFFSET GOODSERROR
    POP EAX
    JMP SHOWMENU

LOGINERRORMARK:
    myprint offset lpFmt,OFFSET LOGINERROR
EXITMARK:
    invoke ExitProcess, 0
main endp

sell proc
    myprint offset lpFmt,offset GOODINFO1
    myprint offset lpFmt,ESI
    MOV AX,WORD PTR [ESI+14]
    MOV BX,WORD PTR [ESI+16]
    SUB AX,BX
    MOV BX,AX
    myprint offset lpFmt,offset OP2INFO1
    invoke scanf,offset npFmt,offset SALENUM
    CMP WORD PTR SALENUM,BX
    JNLE  OP2ERROR
    MOV BX,WORD PTR [ESI+16]
    ADD BX,WORD PTR SALENUM
    MOV WORD PTR [ESI+16],BX
    RET
OP2ERROR:
    myprint offset lpFmt,OFFSET SALEERROR
    RET
sell endp

purchase proc
    myprint offset lpFmt,offset GOODINFO1
    myprint offset lpFmt,ESI
    MOV BX,WORD PTR [ESI+14]
    myprint offset lpFmt,offset OP3INFO1
    invoke scanf,offset npFmt,offset INNUM
    MOV EAX,0
    CMP AX,WORD PTR INNUM
    JNLE  OP3ERROR
    ADD BX,WORD PTR INNUM
    MOV WORD PTR [ESI+14],BX
    RET
OP3ERROR:
    myprint offset lpFmt,OFFSET GOODSINERROR
    RET
purchase endp



cal proc
    myprint offset lpFmt,offset GOODINFO1
    myprint offset lpFmt,ESI
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

    myprint offset lpFmt,offset GOODINFO6
    MOV EAX,0
    MOVSX EAX,WORD PTR [ESI]+18
    myprint offset npFmt,EAX
    myprint offset lpFmt,offset BAIFENHAO

    RET
cal endp


sort proc
    MOV EAX,OFFSET GA1+18
    MOV EBX,0
ASSIGNMENT:
    MOV DWORD PTR ADRESSARRAY[EBX*4],EAX
    ADD EAX,20
    INC BX
    CMP BX,WORD PTR GANUM
    JL ASSIGNMENT

    MOV ESI,OFFSET ADRESSARRAY
    MOV EAX,0
OUTLOOP:
    MOV EBX,0
    MOVSX EDX,WORD PTR GANUM
    SUB EDX,1
    CMP EAX,EDX
    JE OUTRANK

INNERLOOP:
    MOV EDI,DWORD PTR [ESI][EBX*4]
    MOVSX ECX,WORD PTR [EDI]
    ADD EBX,1
    MOV EDI,DWORD PTR [ESI][EBX*4]
    MOVSX EDX,WORD PTR [EDI]
    SUB EBX,1
    CMP ECX,EDX
    JL EXCHANGE
    JMP INJUDGE
EXCHANGE:
    MOV ECX,DWORD PTR [ESI][EBX*4]
    ADD EBX,1
    MOV EDX,DWORD PTR [ESI][EBX*4]
    XCHG ECX,DWORD PTR [ESI][EBX*4]
    SUB EBX,1
    XCHG EDX,DWORD PTR [ESI][EBX*4]

INJUDGE:
    MOVSX EDX,WORD PTR GANUM
    SUB EDX,EAX
    SUB EDX,1
    INC EBX
    CMP EBX,EDX
    JNE INNERLOOP
    INC EAX
    JMP OUTLOOP
OUTRANK:
    MOV ESI,OFFSET ADRESSARRAY
    MOV EAX,0

SHOWRANK:
    MOV EDI,DWORD PTR [ESI][EAX*4]
    SUB EDI,18
    myprint offset lpFmt,EDI
    ADD EDI,18
    MOVSX ECX,WORD PTR [EDI]
    myprint offset npFmt,ECX
    myprint offset lpFmt,offset BAIFENHAO
    INC EAX
    CMP AX, WORD PTR GANUM
    JNE SHOWRANK

    RET
sort endp

findgoods proc
    myprint offset lpFmt,OFFSET PROCUDTips
    MOV ECX,0
    MOV DWORD PTR INGOODS,ECX
    MOV DWORD PTR INGOODS[4],ECX
    MOV DWORD PTR INGOODS[8],ECX
    invoke scanf,offset spFmt,offset INGOODS

    MOVSX EBX,WORD PTR GANUM
    INC EBX
    MOV EDX,offset GA1
    MOV ECX,0
FINDGOOD:
    PUSH ECX
    invoke cmpstr,EDX,offset INGOODS,10
    POP ECX
    CMP EAX,1
    JNE CONTINUE
    MOV ESI,EDX
    RET
CONTINUE:
    ADD EDX,20
    ADD ECX,1
    CMP ECX,EBX
    JNE FINDGOOD
    RET
findgoods endp

END