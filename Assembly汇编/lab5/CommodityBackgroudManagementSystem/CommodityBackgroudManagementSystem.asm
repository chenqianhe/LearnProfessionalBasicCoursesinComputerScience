.686
.model FLAT,STDCALL
OPTION CASEMAP:NONE
 ExitProcess PROTO STDCALL :DWORD
 includelib  kernel32.lib  ; ExitProcess 在 kernel32.lib中实现
 printf PROTO C:VARARG
 scanf  PROTO C:VARARG
 sprintf PROTO C:VARARG
 includelib  ucrt.lib
 includelib  legacy_stdio_definitions.lib
 cmpstr proto:dword,:dword,:dword
 WinMain proto :DWORD
 WndProc proto :DWORD,:DWORD,:DWORD,:DWORD
 DialogProc proto :DWORD,:DWORD,:DWORD,:DWORD
 include windows.inc
 include user32.inc
 include kernel32.inc
 include gdi32.inc
 include resource.inc

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

.data
szClassName       db "MenuDialogTest",0
szTitle           db "Commodity Backgroud Management System",0
hInstance         dd  0
szMessageBoxTitle db "Message Box Title",0
szcalMessageBoxTitle db "计算完成",0
szcalInfo db "计算完成!",0
szgalInfo db "商品信息",0
szversionMessageBoxTitle db "版本",0
szauthorMessageBoxTitle db "作者信息",0
szexitMessageBoxTitle db "退出",0
szMessageConfirm  db "确定退出？",0
szAuthorInfo      db "陈千鹤",10,"U201915160",0
szVersionInfo     db "Version : 1.0",0
szInputText       db  100 dup(0)
dwInputLength     dd  0
szCancelPress     db "Cancel Button is pressed ",0
dwCancelPressLength = $ - szCancelPress -1
szClosePress      db  " Close Window is pressed. ",0
dwClosePressLength = $ - szClosePress -1
szClearText       db  100 dup(' ')
gpFmt   DB	"%s, %d, %d, %d, %d, %d%%, %s",0

lpFmt   DB	"%s",0ah,0dh,0
npFmt   DB "%d",0
spFmt   DB  "%s",0
INAME   DB  12 DUP(0)
INPASS  DB  12 DUP(0)
BNAME  DB  "chenqianhe",0,0  ;老板姓名（要求必须是自己名字的拼音）
BPASS  DB  "U201915160",0,0  ;密码（必须是自己的学号）
N    EQU   30
GA1   GOODS   <"PEN", 15, 20, 70, 25, 0>  ;商品1 名称, 进货价、销售价、进货数量、已售数量,利润率（尚未计算）
GA2   GOODS   <"PENCIL", 2, 3, 100, 50, 0>
GA3   GOODS   <"BOOK", 30, 40, 25, 5, 0>
GA4   GOODS   <"RULER", 3, 4, 200, 150,0>
GA5   GOODS   <"RUBBER" ,15,20,30,2,0>
LEN = $ - GA1
PGASINFO DB "商品名称,进货价,销售价,进货数量,已售数量,利润率",10
GASINFO DB 180 DUP(0)
PUBLIC GAN
GAN   GOODS N-5 DUP (<"TempValue" ,15,20,30,2,0>) ;除了4个已经具体定义了的商品信息以外,其他商品信息暂时假定为一样的。
PUBLIC GANUM
GANUM   DW 5,0

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
PROCUDTips  DB  "Existing goods:PEN,PENCIL,BOOK,RULER,RUBBER,Please enter the item you want to operate:",0
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


.code
START:

	invoke GetModuleHandle,NULL
	mov    hInstance,eax
	invoke WinMain,hInstance
	invoke ExitProcess,eax

;**************
WinMain proc hInst:DWORD
	LOCAL wc:WNDCLASSEX
	LOCAL msg:MSG
	LOCAL hwnd:HWND
	LOCAL hMenu:HMENU
    invoke RtlZeroMemory,ADDR wc,SIZEOF wc
	mov   wc.cbSize,SIZEOF WNDCLASSEX
	mov   wc.style, CS_HREDRAW or CS_VREDRAW
	mov   wc.lpfnWndProc, OFFSET WndProc
	push  hInst
	pop   wc.hInstance
	mov   wc.hbrBackground,COLOR_WINDOW+1
	mov   wc.lpszClassName,OFFSET szClassName
	invoke LoadIcon,NULL,IDI_APPLICATION
	mov   wc.hIcon,eax
	invoke LoadCursor,NULL,IDC_ARROW
	mov   wc.hCursor,eax
	invoke RegisterClassEx, ADDR wc
	invoke LoadMenu, hInst, IDM_MYMENU
	mov    hMenu,eax
	invoke CreateWindowEx,NULL,ADDR szClassName,ADDR szTitle,\
           WS_OVERLAPPEDWINDOW,CW_USEDEFAULT,\
           CW_USEDEFAULT,CW_USEDEFAULT,CW_USEDEFAULT,NULL,hMenu,\
           hInst,NULL
	mov   hwnd,eax
	invoke ShowWindow, hwnd,SW_SHOWNORMAL
	invoke UpdateWindow, hwnd
StartLoop:
    invoke GetMessage,ADDR msg,NULL,0,0
    cmp  eax,0
    je   ExitLoop
    invoke TranslateMessage, ADDR msg
    invoke DispatchMessage, ADDR msg
	jmp StartLoop 
ExitLoop:
     mov  eax,msg.wParam
	 ret
WinMain ENDP

;*************************
WndProc proc hWnd:DWORD,uMsg:DWORD,wParam:DWORD,lParam:DWORD
  LOCAL hdc:HDC
  LOCAL x:DWORD
  LOCAL GAINFOADDR:DWORD
.IF uMsg == WM_COMMAND
   .IF wParam == ID_ACTION_COMPUTERATE
       MOV ESI,offset GA1
       CALL cal
       MOV ESI,offset GA2
       CALL cal
       MOV ESI,offset GA3
       CALL cal
       MOV ESI,offset GA4
       CALL cal
       MOV ESI,offset GA5
       CALL cal
       invoke MessageBox, hWnd,addr szcalInfo, addr szcalMessageBoxTitle,MB_OK
	.ELSEIF  wParam == ID_ACTION_LISTSORT
	   CALL sort

       MOV EAX,0
       MOV ESI,DWORD PTR ADRESSARRAY
       SUB ESI,18
       PUSH EAX
       MOV EDI,OFFSET GASINFO
WRITEINFO:
       MOV DWORD PTR GAINFOADDR,EDI
       MOVSX EAX, WORD PTR [ESI]+10
       MOVSX EBX, WORD PTR [ESI]+12
       MOVSX ECX, WORD PTR [ESI]+14
       MOVSX EDX, WORD PTR [ESI]+16
       MOVSX EDI, WORD PTR [ESI]+18
       invoke sprintf,DWORD PTR GAINFOADDR,OFFSET gpFmt,ESI,EAX,EBX,ECX,EDX,EDI,OFFSET NEWLINE
       POP EAX
       ADD EAX,1
       MOV EDI,DWORD PTR GAINFOADDR
       ADD EDI,30
       MOV EBX,OFFSET ADRESSARRAY
       MOV ESI,DWORD PTR [EBX][EAX*4]
       SUB ESI,18
       CMP EAX,5
       PUSH EAX
       JNE WRITEINFO

       MOV EAX,-1
       MOV EDX,0
       MOV ESI,OFFSET GASINFO

DOCOUNT:
       CMP EAX,180
       JGE OUTCOUNT
       INC EAX
       CMP BYTE PTR [ESI][EAX],0
       JE DOCOUNT
       INC EDX
       JMP DOCOUNT


OUTCOUNT:
       SUB EDX,1
       MOV EAX,0
       MOV ESI,OFFSET GASINFO
DOCHECK:
       CMP EAX,EDX
       JGE OUTCHECK
       CMP BYTE PTR [ESI][EAX],0
       JE LEFTMOVE
       INC EAX
       JMP DOCHECK

LEFTMOVE:
       MOV EBX,EAX
DOMOVE:
       INC EBX
       MOV CL,BYTE PTR [ESI][EBX]
       MOV BYTE PTR [ESI][EBX-1],CL
       CMP EBX,150
       JL DOMOVE
       JMP DOCHECK


OUTCHECK:
       invoke MessageBox, hWnd,addr PGASINFO, addr szgalInfo,MB_OK

   .ELSEIF  wParam == ID_OP_EXIT
       invoke DestroyWindow, hWnd
;	   invoke PostQuitMessage,NULL
   .ELSEIF  wParam == ID_HELP_VERSION
       invoke MessageBox, hWnd,addr szVersionInfo, addr szversionMessageBoxTitle,MB_OK
   .ELSEIF  wParam == ID_HELP_AUTHOR
       invoke MessageBox, hWnd,addr szAuthorInfo, addr szauthorMessageBoxTitle,MB_OK
   .ENDIF
.ELSEIF uMsg==WM_CLOSE
      invoke MessageBox, hWnd,addr szMessageConfirm, addr szexitMessageBoxTitle,MB_YESNO
	  .if  eax == IDYES
           invoke DestroyWindow, hWnd
	  .endif
.ELSEIF uMsg==WM_DESTROY
      invoke PostQuitMessage,NULL
 .ELSE
      invoke DefWindowProc,hWnd,uMsg,wParam,lParam
      ret
 .ENDIF
  xor    eax,eax
  ret
WndProc endp

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

END  START