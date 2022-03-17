.386
STACK	SEGMENT	USE16	STACK	;主程序堆栈段
		DB 200 DUP(0)
STACK	ENDS
;
CODE	SEGMENT	USE16
		ASSUME	CS:CODE,DS:CODE,SS:STACK
;新的INT 08H使用的变量
		COUNT	DB	18			;“嘀嗒”计数
		HOUR	DB	?,?,':'		;时的ASCII码
		MIN		DB	?,?,':'		;分的ASCII码
		SEC		DB	?,?			;秒的ASCII码
		BUF_LEN = $ - HOUR		;计算显示信息长度
		CURSOR	DW	?			;原光标位置
		OLD_INT	DW	?,?			;原INT 08H的中断矢量
		CMP_INT	DW	0FEA5H, 0F000H	;原INT 08H的中断矢量
;新的INT 08H的代码
NEW08H	PROC	FAR
		PUSHF
		CALL	DWORD	PTR	CS:OLD_INT
								;完成原功能（变量在汇编后使用的默认段寄存器）
								;为DS，故必须加前缀CS
		DEC		CS:COUNT		;（倒）计数
		JZ		DISP			;计满18次，转时钟显示
		IRET					;未计满，中断返回
DISP:	MOV		CS:COUNT,18		;重置计数初值
		STI						;开中断
		PUSHA
		PUSH	DS
		PUSH	ES
		MOV		AX,CS			;将DS、ES指向CS
		MOV		DS,AX
		MOV		ES,AX
		CALL	GET_TIME		;获取当前时间，并转为ASCII码
		MOV 	BH,0			;获取0号显示页面当前光标的位置
		MOV		AH,3
		INT		10H
		MOV		CURSOR,DX		;保存原光标位置
		MOV		BP,OFFSET HOUR	;ES:[BP]指向显示信息的起始地址
		MOV		BP,0			;显示到0号页面
		MOV		DH,0			;显示在0行
		MOV		DL,80 - BUF_LEN	;显示在最后几列（光标位置设到右上角）
		MOV		BL,07H			;显示字符的属性（白色）
		MOV		CX,BUF_LEN		;显示的字符串长度
		MOV		AL,0			;BL包含显示属性，写后光标不动
		MOV		AH,13H			;调用显示字符串的功能
		INT		10H				;在右上角显示出当前时间
		MOV		BH,0			;对0号页面操作
		MOV		DX,CURSOR		;恢复光标位置的功能号
		MOV		AH,2			;设置光标位置的功能号
		INT		10H				;还原光标位置（保证主程序的光标不受影响）
		POP		ES
		POP		DS
		POPA					;恢复现场
		IRET					;中断返回
NEW08H	ENDP
;取时间子程序。从RT/CMOS RAM中取得时分秒并转化成ASCII码存放到对应变量中
GET_TIME	PROC
			MOV		AL,4		;4是“时”信息的偏移地址
			OUT		70H,AL		;设定将要访问的单元是偏移值为4的“时”信息
			JMP		$+2			;延时，保证端口操作的可靠性
			IN		AL,71H		;读取“时”信息
			MOV		AH,AL		;将2位压缩的BCD码转换为未压缩的BCD码
			AND		AL,0FH		
			SHR		AH,4
			ADD		AX,3030H	;转换成对应的SCII码
			XCHG	AH,AL
			MOV		WORD PTR HOUR,AX
								;保存到HOUR变量指示的前两个字节中
			MOV		AL,2		;2是“分”信息的偏移地址
			OUT		70H,AL
			JMP		$+2
			IN		AL,71H		;读取“分”信息
			MOV		AH,AL		
			AND		AL,0FH		
			SHR		AH,4
			ADD		AX,3030H	;转换成对应的SCII码
			XCHG	AH,AL
			MOV		WORD PTR MIN,AX		
								;保存到MIN变量指示的前两个字节中
			MOV		AL,0		;0是“秒”信息的偏移地址
			OUT		70H,AL
			JMP		$+2
			IN		AL,71H		;读取“秒”信息
			MOV		AH,AL		
			AND		AL,0FH		
			SHR		AH,4
			ADD		AX,3030H	;转换成对应的SCII码
			XCHG	AH,AL
			MOV		WORD PTR SEC,AX
								;保存到SEC变量指示的前两个字节中
			RET
GET_TIME	ENDP
;
;初始化（中断处理程序的安装）及主程序
BEGIN:		
			PUSH	CS
			POP		DS	
			MOV 	AX,0
			MOV 	ES,AX
			MOV 	AX,ES:[08H*4]
			MOV		BX,OFFSET NEW08H
			CMP 	AX,BX
			JE		QUIT
			
			MOV		AX,3508H	;获取原08H的中断矢量
			INT 	21H
	
			MOV		OLD_INT,BX
			MOV		OLD_INT+2,ES
			
			MOV		DX,OFFSET NEW08H
			MOV		AX,2508H	;设置新的08H中断变量
			INT		21H
			
			;
NEXT:		MOV		AH,0		;等待按键
			INT		16H
			CMP		AL,'q'		;若按下了q键则退出
			JNE		NEXT
			;LDS		DX,DWORD PTR OLD_INT
								;保存取出的原08H中断矢量
			;MOV		AX,2508H
			;INT 	21H			;恢复原08H中断矢量
			;MOV		AH,4CH
			;INT		21H			;退出
			
			MOV 	DX,OFFSET BEGIN+15
			
			MOV 	CL,4
			SHR		DX,CL
			ADD		DX,10H
			MOV 	AL,0
			MOV 	AH,31H
			INT 	21H
QUIT:
			
CODE		ENDS
			END		BEGIN
			