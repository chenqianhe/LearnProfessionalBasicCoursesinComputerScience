#include "subfunction.h"

int e = 0;
int i = -1;
int j=0; 
int flag1=0;
int pre = -1; 
int next=-1;

int CreateBiTree(BiTree &T,TElemType definition[]);
status DestroyBiTree(BiTree &L);
status ClearBiTree(BiTree&L);
status BiTreeEmpty(BiTree L);
int BiTreeDepth(BiTree T);
BiTNode* LocateNode(BiTree T,KeyType e); 
status Assign(BiTree &T,KeyType e,TElemType value); 
BiTNode* GetSibling(BiTree T,KeyType e); 
status InsertNode(BiTree &T,KeyType e,int LR,TElemType c);
status DeleteNode(BiTree &T,KeyType e);
void visit(BiTree T);
status PreOrderTraverse(BiTree T,void (*visit)(BiTree));
status InOrderTraverse(BiTree T,void (*visit)(BiTree));
status PostOrderTraverse(BiTree T,void (*visit)(BiTree));
status LevelOrderTraverse(BiTree T,void (*visit)(BiTree));
status SaveBiTree(BiTree T, char FileName[]);
status LoadBiTree(BiTree &T, char FileName[]);
void visit(BiTree T);
void visual(BiTree &T);

void menu(BiTree& L,char FileName[]){
	if(!L)	flag1=0;
	else flag1=1;
	char name[30];
	strcpy(name,FileName);
	int op=1;
	while(op){
		system("cls");	printf("\n\n");
		printf("      Menu for Binary Tree On Linked Structure \n");
		printf("-------------------------------------------------\n");
		printf("    	  1. CreateBiTree    9. InsertNode\n");
		printf("    	  2. DestroyBiTree  10. DeleteNode \n");
		printf("    	  3. ClearBiTree    11. PreOrderTraverse\n");
		printf("    	  4. BiTreeEmpty    12. InOrderTraverse\n");
		printf("    	  5. BiTreeDepth    13. PostOrderTraverse\n");
		printf("    	  6. LocateNode     14. LevelOrderTraverse\n");
		printf("    	  7. Assign         15. Save In File\n");
		printf("    	  8. GetSibling     16. Read In File\n");
		printf("    	  0. Exit\n");
		printf("-------------------------------------------------\n");
		printf("    ��ѡ����Ĳ���[0~16]:");
		scanf("%d",&op);
	    switch(op){
		   	case 1:
			 	if (!flag1){
				 	L = (BiTree)malloc(sizeof(BiTNode)); 
					TElemType definition[100];
					int ans,i=0;
					do {
						scanf("%d%s",&definition[i].key,definition[i].others);
					} while (definition[i++].key!=-1);
										
					j=CreateBiTree(L->lchild,definition);
					
					if (j==OK)
					{
						flag1 = 1; 
					    PreOrderTraverse(L->lchild,visit);
					    printf("\n");
					    InOrderTraverse(L->lchild,visit);
					    visual(L);
					}else printf("�ؼ��ֲ�Ψһ");
				}else{
			     	printf("���ܻ���Ѿ����ڵĶ�������ʼ��");
				} 
			 	getchar();getchar();
			 	break;
		   	case 2:
				if (!flag1)
				{
					printf("���ܶԲ����ڵĶ������������ٲ�����\n");	
				}
				else
			    { 
			    	j = DestroyBiTree(L); 
			        if(j==OK){
		            	printf("���������ٳɹ���\n");
		            	flag1=0;	
					}else printf("δ��ȷ��ն�����");
			    } 
			 	getchar();getchar();
			 	break;
		   	case 3:
			    if (!flag1) { 
			    	printf("���ܻ�Բ����ڵĶ��������");
			    }
				else {
					j=ClearBiTree(L->lchild);
					if (j==OK) printf("��������ճɹ���\n");
					else if(L->lchild)	printf("��ͷ�ڵ��̽ڵ�ָ��δ��ΪNULL");
			    }
				getchar();getchar();
				break;
		   	case 4:
		   		if(!flag1){
		   			printf("���ܻ�Բ����ڵĶ������п�");
				}else if(BiTreeEmpty(L)==OK) printf("������Ϊ�գ�\n");
			    else printf("��������Ϊ�գ�\n");   
				getchar();getchar();
				break;
		   	case 5:
				if(!flag1){
		   			printf("���ܻ�Բ����ڵĶ����������\n");
				}else printf("���������Ϊ %d\n",BiTreeDepth(L->lchild));     
				visual(L);
			 	getchar();getchar();
			 	break;
		   	case 6:
		   		if(!flag1){
		   			printf("���ܻ�Բ����ڵĶ���������Ԫ�ز�ѯ\n");
				}else{
					printf("������Ҫ��ѯ�Ĺؼ���\n");
					scanf("%d",&i);
					BiTNode* n = LocateNode(L->lchild,i);
					if(n){
						printf("����ѯ�Ľڵ�����Ϊ��%d,%s",n->data.key,n->data.others);
					}else{
						printf("����ѯ�Ľڵ㲻����");
					}
					visual(L);
				} 
			 	getchar();getchar();
				break;
		   	case 7:
		   		if(!flag1){
		   			printf("���ܻ�Բ����ڵĶ��������нڵ㸳ֵ\n");
				}else{
					printf("������Ҫ��ֵ�Ľڵ�ؼ��֣�\n");
					scanf("%d",&i);
					TElemType value;
					printf("�����븳ֵ���������ݣ�");
					scanf("%d%s",&value.key,&value.others); 
					j = Assign(L->lchild,i,value);
					if(j==OK){
						printf("��ֵ�ɹ�");
					}else{
						printf("��Ҫ��ֵ�Ľڵ㲻����");
					}
					visual(L);
				} 
			 	getchar();getchar();
			 	break;
		   	case 8:
		   		if(!flag1){
		   			printf("���ܻ�Բ����ڵĶ����������ֵܽڵ��ѯ\n");
				}else{
					printf("������Ҫ��ѯ�Ĺؼ���\n");
					scanf("%d",&i);
					BiTNode* n = GetSibling(L->lchild,i);
					if(n){
						printf("����ѯ�Ľڵ���ֵܽڵ�Ϊ%d%s",n->data.key,n->data.others);
					}else{
						printf("���ֵܽ��");
					}
					visual(L);
				}    
			 	getchar();getchar();
			 	break;
		   	case 9:
		   		if(!flag1){
		   			printf("���ܻ�Բ����ڵĶ��������в���\n");
				}else{
					int LR;
					printf("������Ҫ�����λ�õĹؼ��ֺ�λ�ã�-1���ڵ㣬0��ڵ㣬1�ҽڵ㣩\n");
					scanf("%d%d",&i,&LR);
					TElemType c;
					
					printf("������Ҫ�����Ԫ������\n");
					scanf("%d%s",&c.key,&c.others);
					j=InsertNode(L,i,LR,c);
					if(j==OK){
						printf("����ɹ�\n");
					}else{
						printf("����λ�ô���\n");
					} 
					visual(L);
				} 
			 	getchar();getchar();
			 	break;
		   	case 10:
		   		if(!flag1){
		   			printf("���ܻ�Բ����ڵĶ���������ɾ��\n");
				}else{
					printf("������Ҫɾ����Ԫ�عؼ��֣�\n");
					scanf("%d",&i);
					j=DeleteNode(L->lchild,i); 
					if(j==OK){
						printf("ɾ���ɹ�\n");
						
					}else{
						printf("ɾ��λ�ô���\n");
					}
					visual(L);
				} 
			 	getchar();getchar();
			 	break;
		   	case 11:
				if(!flag1){
		   			printf("���ܻ�Բ����ڵĶ��������б���\n");
				}else if(BiTreeEmpty(L)){
					printf("������Ϊ��\n");
				}else{
					PreOrderTraverse(L->lchild,visit); 
					visual(L);
				}    
			 	getchar();getchar();
			 	break;
		 	case 12:
				if(!flag1){
		   			printf("���ܻ�Բ����ڵĶ��������б���\n");
				}else if(BiTreeEmpty(L)){
					printf("������Ϊ��\n");
				}else{
					InOrderTraverse(L->lchild,visit); 
					visual(L);
				}    
			 	getchar();getchar();
			 	break;
			case 13:
				if(!flag1){
		   			printf("���ܻ�Բ����ڵĶ��������б���\n");
				}else if(BiTreeEmpty(L)){
					printf("������Ϊ��\n");
				}else{
					PostOrderTraverse(L->lchild,visit); 
					visual(L);
				}    
			 	getchar();getchar();
			 	break;	 	
			case 14:
				if(!flag1){
		   			printf("���ܻ�Բ����ڵĶ��������б���\n");
				}else if(BiTreeEmpty(L)){
					printf("������Ϊ��\n");
				}else{
					LevelOrderTraverse(L->lchild,visit); 
					visual(L);
				}    
			 	getchar();getchar();
			 	break;	
			case 15:{
				if(!flag1){
		   			printf("���ܻ�Բ����ڵĶ��������д洢\n");
				}else{
					j=SaveBiTree(L->lchild,name);
					if(j==OK){
						printf("����ɹ���\n"); 
					}
				} 
				getchar();getchar();
				break;
			}
			case 16:{
				if(flag1){
					printf("���ܶ��Ѵ��ڵĶ��������ж��ļ�������");
				}else{
					L = (BiTree)malloc(sizeof(BiTNode)); 
					j=LoadBiTree(L->lchild,name);
					if(j==OK){
						flag1=1;
						printf("��ȡ�ɹ���\n");
						visual(L);
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



