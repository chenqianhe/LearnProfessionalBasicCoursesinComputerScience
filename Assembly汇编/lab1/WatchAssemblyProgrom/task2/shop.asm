.386
.model flat,stdcall
    ExitProcess proto stdcall:dword
    includelib kernel32.lib
    printf proto c:vararg
    scanf proto c:vararg
    includelib libcmt.lib
    includelib legacy_stdio_definitions.lib


.data
	BNAME  DB  'LIUCHENGXI',0  ;老板姓名
    BPASS  DB  'U201915168',0  ;密码
    N    EQU   30
    GA1   DB   'PEN',7 DUP(0)  ;商品1 名称
     		   DW   15,20,70,25,?  ; 进货价、销售价、进货数量、已售数量，利润率（尚未计算）
    GA2   DB  'PENCIL',4 DUP(0) ;商品2 名称
      		   DW   2,3,100,50,?
    GA3   DB   'BOOK', 6 DUP(0);商品3 名称
     		   DW   30,40,25,5,?
    GA4   DB   'RULER',5 DUP(0);商品4 名称
      		   DW   3,4,200,150,?
    GAN  DB N-4 DUP( 'TempValue' ,0,15,0,20,0,30,0,2,?,?,?)
    
    user DB 11 DUP(0);接收输入的用户名
    pass DB 11 DUP(0);接收输入的密码
    gdsname DB 10 DUP(0);接收输入的商品名
    op DW 0;操作选项
    buyNum DW 0
    sellNum DW 0

    Fmt1 DB "%s",0Ah,0
    Fmt2 DB "%s",0
    Fmt3 DB "%hd  ",0
    Fmt4 DB "%d",0
    Info1 DB "Please enter username:",0Ah,0
    Info2 DB "Please enter password:",0Ah,0
    Info3 DB "usernamer or password is wrong!",0Ah,0
    Menu1 DB "Please enter 1-9 to choose the next option:",0Ah,0
    Menu2 DB "1.Search the goods an show its information;",0Ah,0
    Menu3 DB "2.Sell out;",0Ah,0
    Menu4 DB "3.Buy in;",0Ah,0
    Menu5 DB "4.Caculate the profit rate;",0Ah,0
    Menu6 DB "9.Exit;",0Ah,0
    Display1 DB "NAME:",0Ah,0
    Display2 DB "Buy_Price:",0Ah,0
    Display3 DB "Sell_Price:",0Ah,0
    Display4 DB "Buy_Num:",0Ah,0
    Display5 DB "Sell_Num:",0Ah,0
    Display6 DB "Profit_Rate:",0Ah,0
    FindInfo1 DB "Please enter the goods' name you want to find",0Ah,0
    FindInfo2 DB "Successful!",0Ah,0
    FindInfo3 DB "Details: ",0Ah,0
    FindInfo4 DB "The goods isn't existed!",0Ah,0
    SellInfo1 DB "Please enter the goods' name you sell:",0Ah,0
    SellInfo2 DB "Enter the num:",0Ah,0
    SellInfo3 DB "Sell Default!",0Ah,0
    SellInfo4 DB "Sell Successfully!",0Ah,0

    ExitInfo DB "Welcome to use this system again!",0Ah,0


    .stack 200

    .code
        main proc c;主程序
            invoke printf,offset Fmt1,offset Info1;登录信息
            invoke scanf,offset Fmt2,offset user
            invoke printf,offset Fmt1,offset Info2
            invoke scanf,offset Fmt2,offset pass
            mov ebx,0
        checkn:
            mov al,BNAME[ebx];用户名验证
            cmp al,user[ebx]
            jne default
            inc ebx
            cmp ebx,11
            js checkn
            mov ebx,0
        checkp:
            mov al,BPASS[ebx];密码验证
            cmp al,pass[ebx] 
            jne default
            inc ebx
            cmp ebx,11
            js checkp
        menu:
            invoke printf,offset Fmt1,offset Menu1;菜单信息
            invoke printf,offset Fmt1,offset Menu2
            invoke printf,offset Fmt1,offset Menu3
            invoke printf,offset Fmt1,offset Menu4
            invoke printf,offset Fmt1,offset Menu5
            invoke printf,offset Fmt1,offset Menu6
            
            

            
        NextOP:
            invoke scanf,offset Fmt4,offset op
            cmp op,1
            je OP1
            cmp op,2
            je OP2
            ;cmp op,3
            ;je OP3
            ;cmp op,4
            ;je OP4
            cmp op,9
            je Exit

        OP1:
            invoke printf,offset Fmt1,offset  FindInfo1
            invoke scanf,offset Fmt2,offset gdsname
            push offset GA1
            push offset gdsname
            call find
            add esp,8
            jmp menu

        OP2:
            invoke printf,offset Fmt1,offset SellInfo1
            invoke scanf,offset Fmt2,offset gdsname
            invoke printf,offset Fmt1,offset SellInfo2
            invoke scanf,offset Fmt4,offset sellNum
            push offset GA1
            push offset gdsname
            push offset sellNum
            call sell
            add esp,12
            jmp menu








        default:
            invoke printf,offset Fmt1,offset Info3
            invoke ExitProcess,0
        Exit:
            invoke printf,offset Fmt1,offset ExitInfo
            invoke ExitProcess,0
        main endp

        find proc ;查找商品并显示信息子程序
            push ebp
            mov ebp,esp
            push esi
            push edi
            push eax
            push ebx
            push edx
            mov edi,[ebp+8]
            mov esi,[ebp+12]
            mov ebx,0
            mov eax,0
        find_start:
            mov dl,[edi]
            cmp dl,[esi]
            jne Trav
            inc esi
            inc edi
            inc eax
            cmp dl,0
            je  find_scs
            jne find_start
        Trav:
            inc ebx
            sub esi,eax
            sub edi,eax
            add esi,20
            mov eax,0
            cmp ebx,30
            jbe find_start
            jmp find_fail
        find_scs:
            sub esi,eax
            invoke printf,offset Fmt1,offset FindInfo2
            invoke printf,offset Fmt1,offset FindInfo3
            invoke printf,offset Fmt1,esi
            mov dx,[esi+10]
            invoke printf,offset Fmt3,dx
            mov dx,[esi+12]
            invoke printf,offset Fmt3,dx
            mov dx,[esi+14]
            invoke printf,offset Fmt3,dx
            mov dx,[esi+16]
            invoke printf,offset Fmt3,dx
            mov dx,[esi+18]
            invoke printf,offset Fmt3,dx
            invoke printf,offset Fmt1,0
            jmp find_exit
        find_fail:
            invoke printf,offset Fmt1,offset FindInfo4
        find_exit:
            pop edx
            pop ebx
            pop eax
            pop edi
            pop esi
            pop ebp
            ret
        find endp

        sell proc;出货子程序
            push ebp
            mov ebp,esp
            push esi
            push edi
            push eax
            push ebx
            push ecx
            push edx
            mov ecx,[ebp+8]
            mov edi,[ebp+12]
            mov esi,[ebp+16]
            mov ebx,0
            mov eax,0
        sell_start:
            mov dl,[edi]
            cmp dl,[esi]
            jne Travsell
            inc esi
            inc edi
            inc eax
            cmp dl,0
            je  sell_scs
            jne sell_start
        Travsell:
            inc ebx
            sub esi,eax
            sub edi,eax
            add esi,20
            mov eax,0
            cmp ebx,30
            jbe sell_start
            jmp sell_fail
        sell_scs:
            sub esi,eax
            mov eax,[ecx]
            add eax,[esi+16]
            cmp eax,[esi+14]
            jae sell_fail
            mov [esi+16],eax
            invoke printf,offset Fmt1,offset SellInfo4
            invoke printf,offset Fmt1,esi
            mov dx,[esi+10]
            invoke printf,offset Fmt3,dx
            mov dx,[esi+12]
            invoke printf,offset Fmt3,dx
            mov dx,[esi+14]
            invoke printf,offset Fmt3,dx
            mov dx,[esi+16]
            invoke printf,offset Fmt3,dx
            mov dx,[esi+18]
            invoke printf,offset Fmt3,dx
            invoke printf,offset Fmt1,0
            jmp sell_exit
        sell_fail:
            invoke printf,offset Fmt1,offset SellInfo3
        sell_exit:
            pop edx
            pop ecx
            pop ebx
            pop eax
            pop edi
            pop esi
            pop ebp
            ret
        sell endp

END