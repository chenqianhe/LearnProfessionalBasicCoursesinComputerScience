;;˵����(1) Ϊ����vs2019�Ļ������е���C�ĺ�������Ҫִ��vs2019�����ĳ�ʼ�����롣
;;          �ó�ʼ����������libcmt.lib�е�_mainCRTStartup()������_mainCRTStartup()����main()��
;;			���ԣ�������Ҫ����main�������ӳ���,ͬʱ��Ҫ��libcmt.lib������ȥ��includelib libcmt.lib��
;;      (2) ���ڳ��������main()����˲����ٳ���ĩβ��end����ϼӱ�ţ������� end start��start�ǵ�һ�����ı�ţ�
;;      (3) C��������_mainCRTStartup()��printf()�����ǰ�c�淶���ú��������Ա�������� .model flat,c��������stdcall��
;;      (4) printf��������legacy_stdio_definitions.lib�ж���ģ���Ҫincludelib  legacy_stdio_definitions.lib��
;;���ܣ���������ʾ���ڻ���е���C��scanf()��printf().

.686P
.model flat, c  ;;.model flat,stdcall������
 MessageBoxA proto stdcall,:dword,:dword,:dword,:dword
 ExitProcess proto stdcall :dword
 scanf       proto c :vararg
 printf      proto c :vararg
 includelib  user32.lib						;;MessageBoxA()
 includelib  kernel32.lib					;;ExitProcess()
 includelib  libcmt.lib						;;_mainCRTStartup => main
 includelib  legacy_stdio_definitions.lib	;;printf

.data
 inMsg		db	"Input an integer: ", 0
 inFmt		db	"%ld",0
 outFmt		db	"The number is %ld", 0ah,0dh,0
 x			dd  0
 winMsg		db	"How are you", 0
 winTopic	db	"Title", 0

.stack	200

.code
main	proc
start:	
		invoke printf,offset inMsg
		invoke scanf,offset inFmt,offset x
		invoke printf,offset outFmt,x
		invoke MessageBoxA,0,offset winMsg,offset winTopic,0
		invoke ExitProcess, 0
main	endp
		end		;;end start������
