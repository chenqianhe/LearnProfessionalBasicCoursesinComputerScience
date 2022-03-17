#include "menu.h"
#include "op_for_graph.h"
#include <cstdlib>
status AddList(LISTS &Lists,char ListName[]);
status RemoveList(LISTS &Lists,char ListName[]); 
int LocateList(LISTS Lists,char ListName[]); 
void menu(ALGraph& L,char FileName[]);



char initname[]= "_list.dat";
char FileName[30];

int main(){
	int op=1;
	LISTS Lists;
	Lists.length=0;
	Lists.listsize=10;
	while(op){
		system("cls");	printf("\n\n");
		printf("      Menu for Multi Graph Management System \n");
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
					printf("ͼ����ϵͳ�������޷�����\n");
				}else{
					printf("������ͼ�����ƣ�");
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
					printf("ͼ����ϵͳΪ�գ��޷�ɾ��\n");
				}else{
					printf("������Ҫɾ����ͼ�����ƣ�");
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
					printf("ͼ����ϵͳΪ�գ��޷�����\n");
				}else{
					printf("������Ҫ���ҵ�ͼ�����ƣ�");
					char name[30];
					scanf("%s",name);
					j=LocateList(Lists,name);
					if(j){
						printf("�������ҵ��ǵ�%d��ͼ\n",j);
					}else{
						printf("��ͼ�����ڣ�\n");
					}					
				}
				getchar();getchar();
				break;
			}
			case 4:{
				if(Lists.length==0){
					printf("ͼ����ϵͳΪ�գ��޷�����\n");
				}else{
					printf("������Ҫ������ͼ�����ƣ�");
					char name[30];
					scanf("%s",name);
					j=LocateList(Lists,name);
					if(j){
						printf("��Ҫ�������ǵ�%d��ͼ\n",j);
						strcpy(FileName,strcat(name,initname));

						menu(Lists.elem[j-1].L,FileName);
						printf("�������");
						
					}else{
						printf("��ͼ�����ڣ�\n");
					}					
				}
				getchar();getchar();
				break;
			}
			case 5:{
				printf("ͼ����ϵͳĿǰ����%d��ͼ\n",Lists.length);
				for(int i=0;i<Lists.length;i++){
					printf("��%d��ͼ������Ϊ%s\n",i+1,Lists.elem[i].name);
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

	
	
