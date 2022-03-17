
#include "menu.h"
#include "op_for_multi_linear.h"


status RemoveList(LISTS &Lists,char ListName[]); 
int LocateList(LISTS Lists,char ListName[]); 
void menu(SqList& L,char FileName[]);



char initname[]= "_list.dat";
char FileName[30];

int main(){
	int op=1;
	LISTS Lists;
	Lists.length=0;
	Lists.listsize=10;
	while(op){
		system("cls");	printf("\n\n");
		printf("      Menu for Multi Linear Table Management System \n");
		printf("-------------------------------------------------\n");
		printf("    	  1. Insert     \n");
		printf("    	  2. Delete     \n");
		printf("    	  3. Lookup  \n");
		printf("    	  4. Operating linear table  \n");
		printf("    	  5. Overview \n");
		printf("    	  0. Exit\n");
		printf("-------------------------------------------------\n");
		printf("    ��ѡ����Ĳ���[0~5]:");
		scanf("%d",&op);
		switch(op){
			case 1:{
				if(Lists.length==10){
					printf("�����Ա����ϵͳΪ�գ��޷�����\n");
				}else{
					printf("�����������Ա����ƣ�");
					char name[30];
					scanf("%s",name);
					j=AddList(Lists,name);
					if(j){
						printf("����ɹ���\n");
					}else{
						printf("ERROR��\n");
					}
				}
				getchar();getchar();
				break;
			}
			case 2:{
				if(Lists.length==0){
					printf("�����Ա����ϵͳΪ�գ��޷�ɾ��\n");
				}else{
					printf("������Ҫɾ�������Ա����ƣ�");
					char name[30];
					scanf("%s",name);
					j=RemoveList(Lists,name);
					if(j){
						printf("ɾ���ɹ���\n");
					}else{
						printf("ERROR��\n");
					}					
				}
				getchar();getchar();
				break;
			}
			case 3:{
				if(Lists.length==0){
					printf("�����Ա����ϵͳΪ�գ��޷�����\n");
				}else{
					printf("������Ҫ���ҵ����Ա����ƣ�");
					char name[30];
					scanf("%s",name);
					j=LocateList(Lists,name);
					if(j){
						printf("�������ҵ��ǵ�%d�����Ա�\n",j);
					}else{
						printf("�����Ա����ڣ�\n");
					}					
				}
				getchar();getchar();
				break;
			}
			case 4:{
				if(Lists.length==0){
					printf("�����Ա����ϵͳΪ�գ��޷�����\n");
				}else{
					printf("������Ҫ���������Ա����ƣ�");
					char name[30];
					scanf("%s",name);
					j=LocateList(Lists,name);
					if(j){
						printf("��Ҫ�������ǵ�%d�����Ա�\n",j);
						strcpy(FileName,strcat(name,initname));

						menu(Lists.elem[j-1].L,FileName);
						printf("�������");
						
					}else{
						printf("�����Ա����ڣ�\n");
					}					
				}
				getchar();getchar();
				break;
			}
			case 5:{
				printf("���Ա����ϵͳĿǰ����%d�����Ա�\n",Lists.length);
				for(int i=0;i<Lists.length;i++){
					printf("��%d�����Ա�����Ϊ%s,����Ϊ%d\n",i+1,Lists.elem[i].name,Lists.elem[i].L.length);
				}
				getchar();getchar();
				break;
			}
			
			case 0:{
				break;
			}
		
		}
		
	}
	printf("��ӭ�´���ʹ�ñ�ϵͳ��\n");
	return 0;
	
}

	
	
