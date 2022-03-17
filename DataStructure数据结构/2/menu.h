#include "subfunction.h"

int e = 0;
int i = -1;
int j=0; 
int flag1=0;
int pre = -1; 
int next=-1;

status InitList(LinkList &L);
status DestroyList(LinkList &L);
status ClearList(LinkList&L);
status ListEmpty(LinkList L);
int ListLength(LinkList L);
status GetElem(LinkList L,int i,ElemType &e);
status LocateElem(LinkList L,ElemType e); //�򻯹�
status PriorElem(LinkList L,ElemType e,ElemType &pre);
status NextElem(LinkList L,ElemType cur,ElemType& next_e);
status ListInsert(LinkList& L,int i,ElemType e);
status ListDelete(LinkList& L,int i,ElemType& e);
status ListTraverse(LinkList L);  //�򻯹�
status SaveList(LinkList L,char FileName[]);
status LoadList(LinkList &L,char FileName[]);

void menu(LinkList& L,char FileName[]){
	if(!L)	flag1=0;
	else flag1=1;
	char name[30];
	strcpy(name,FileName);
	int op=1;
	while(op){
		system("cls");	printf("\n\n");
		printf("      Menu for Linear Table On Linked Structure \n");
		printf("-------------------------------------------------\n");
		printf("    	  1. InitList       8. PriorElem\n");
		printf("    	  2. DestroyList    9. NextElem \n");
		printf("    	  3. ClearList      10. ListInsert\n");
		printf("    	  4. ListEmpty      11. ListDelete\n");
		printf("    	  5. ListLength     12. ListTrabverse\n");
		printf("    	  6. GetElem        13. Write File\n");
		printf("    	  7. LocateElem     14. Read In File\n");
		printf("    	  0. Exit\n");
		printf("-------------------------------------------------\n");
		printf("    ��ѡ����Ĳ���[0~14]:");
		scanf("%d",&op);
	    switch(op){
		   	case 1:
			 	if (!flag1)
					{ 
					j=InitList(L);
			 		if (L==NULL) printf("����û����ȷ�����ͷ�ڵ�ռ�");
					if (L->next!=NULL) printf("��ͷ�ڵ����û����ȷ��ʼ��");
				    if (j==OK) {
				               printf("���Ա��ʼ���ɹ�");
				               flag1=1;
				               }
				    }
				else
				    {
				 	j=InitList(L);
				    if (j==INFEASIBLE){
				     	printf("INFEASIBLE");
				     	printf("���ܻ���Ѿ����ڵ����Ա��ʼ��");
					} 
				    }
			 	getchar();getchar();
			 	break;
		   	case 2:
			    j=DestroyList(L);
				if (!flag1)
				{
					printf("���ܶԲ����ڵ����Ա�������ٲ�����\n");	
				}
				else
			    { 
			        if(j==OK){
			            	printf("���Ա����ٳɹ���\n");
			            	flag1=0;	
					}else printf("INFEASIBLE");
			    } 
			 	getchar();getchar();
			 	break;
		   	case 3:
			    if (!flag1) { 
			    	printf("���ܻ�Բ����ڵ����Ա����");
			    }
				else {
					j=ClearList(L);
					if (j==OK) printf("���Ա���ճɹ���\n");
					else if(j==INFEASIBLE)	printf("INFEASIBLE");
					if(L->next)	printf("��ͷ�ڵ��̽ڵ�ָ��δ��ΪNULL");
			    }
				getchar();getchar();
				break;
		   	case 4:
		   		if(!flag1){
		   			printf("���ܻ�Բ����ڵ����Ա��п�");
				}else if(ListEmpty(L)==OK) printf("���Ա�Ϊ�գ�\n");
			    else printf("���Ա�Ϊ�գ�\n");   
				getchar();getchar();
				break;
		   	case 5:
				if(!flag1){
		   			printf("���ܻ�Բ����ڵ����Ա����\n");
				}else printf("���Ա�Ϊ %d\n",ListLength(L));     
			 	getchar();getchar();
			 	break;
		   	case 6:
		   		if(!flag1){
		   			printf("���ܻ�Բ����ڵ����Ա����Ԫ��\n");
				}else{
					printf("������Ҫ��ȡ�ڼ���Ԫ��\n");
					scanf("%d",&i);
	
			   		if(GetElem(L,i,e)==OK){
			   			printf("��%d��Ԫ��Ϊ%d\n",i,e);
					}else{
						printf("�����ڵ�%d��Ԫ��\n",i); 
					}
				}
			 	getchar();getchar();
				break;
		   	case 7:
		   		if(!flag1){
		   			printf("���ܻ�Բ����ڵ����Ա����Ԫ�ز�ѯ\n");
				}else{
					printf("������Ҫ��ѯ��Ԫ��\n");
					scanf("%d",&i);
					if((e=LocateElem(L,i))){
						printf("�������Ԫ���ǵ�%d��\n",e);
					}else{
						printf("�������Ԫ�ز�����\n");
					} 
				} 
			 	getchar();getchar();
			 	break;
		   	case 8:
		   		if(!flag1){
		   			printf("���ܻ�Բ����ڵ����Ա����ǰ��Ԫ�ز�ѯ\n");
				}else{
					printf("������Ҫ��ѯǰ��Ԫ�ص�Ԫ��\n");
					scanf("%d",&i);
					if(PriorElem(L,i,pre)){
						printf("�������Ԫ�ص�ǰ��Ԫ����%d\n",pre);
					}else{
						printf("�������Ԫ�ز�����ǰ��Ԫ��\n");
					} 
				}    
			 	getchar();getchar();
			 	break;
		   	case 9:
		   		if(!flag1){
		   			printf("���ܻ�Բ����ڵ����Ա���к���Ԫ�ز�ѯ\n");
				}else{
					printf("������Ҫ��ѯ����Ԫ�ص�Ԫ��\n");
					scanf("%d",&i);
					if(NextElem(L,i,next)){
						printf("�������Ԫ�صĺ���Ԫ����%d\n",next);
					}else{
						printf("�������Ԫ�ز����ں���Ԫ��\n");
					} 
				}    
			 	getchar();getchar();
			 	break;
		   	case 10:
		   		if(!flag1){
		   			printf("���ܻ�Բ����ڵ����Ա���в���\n");
				}else{
					printf("������Ҫ�����λ��\n");
					scanf("%d",&i);
					printf("������Ҫ�����Ԫ��\n");
					scanf("%d",&e);
					j=ListInsert(L,i,e);
					if(j==OK){
						printf("����Ԫ�سɹ�\n");
					}else if(j==ERROR){
						printf("����λ�ô���\n");
					} 
				} 
   
			 	getchar();getchar();
			 	break;
		   	case 11:
		   		if(!flag1){
		   			printf("���ܻ�Բ����ڵ����Ա����ɾ��\n");
				}else{
					printf("������Ҫɾ���ڼ���Ԫ�أ�\n");
					scanf("%d",&i);
					j=ListDelete(L,i,e); 
					if(j==OK){
						printf("ɾ���ɹ�\n");
						
					}else if(j==ERROR){
						printf("ɾ��λ�ô���\n");
					}
				} 
			 	getchar();getchar();
			 	break;
		   	case 12:
				if(!flag1){
		   			printf("���ܻ�Բ����ڵ����Ա���б���\n");
				}else if(ListEmpty(L)){
					printf("���Ա�Ϊ��\n");
				}else{
					ListTraverse(L); 
				}    
			 	getchar();getchar();
			 	break;
			case 13:{
				if(!flag1){
		   			printf("���ܻ�Բ����ڵ����Ա���д洢\n");
				}else{
					j=SaveList(L,name);
					if(j==OK){
						printf("����ɹ���\n"); 
					}
				} 
				getchar();getchar();
				break;
			}
			case 14:{
				if(flag1){
					printf("���ܶ��Ѵ��ڵ����Ա���ж��ļ�������");
				}else{
					j=LoadList(L,name);
					if(j==OK){
						flag1=1;
						printf("��ȡ�ɹ���\n");
					}else{
						printf("�ļ���ַ����");
					}
				}
				getchar();getchar();
				break;
			}
			case 0:
	         	break;
			}//end of switch
	  }//end of while
	
}//end of menu



