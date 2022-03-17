#include "subfunction.h"

status CreateCraph(ALGraph &G,VertexType V[],KeyType VR[][2]);
status DestroyGraph(ALGraph &G);
int LocateVex(ALGraph G,KeyType u); 
status PutVex(ALGraph &G,KeyType u,VertexType value);
int FirstAdjVex(ALGraph G,KeyType u);
int NextAdjVex(ALGraph G,KeyType v,KeyType w);
status InsertVex(ALGraph &G,VertexType v); 
status DeleteVex(ALGraph &G,KeyType v);
status InsertArc(ALGraph &G,KeyType v,KeyType w);
status DeleteArc(ALGraph &G,KeyType v,KeyType w);
void visit(VertexType v);
status DFSTraverse(ALGraph &G,void (*visit)(VertexType));
status BFSTraverse(ALGraph &G,void (*visit)(VertexType));
status SaveGraph(ALGraph G, char FileName[]);
status LoadGraph(ALGraph &G, char FileName[]);

int e = 0;
//int i = -1;
int j=0; 
int flag1=0;
int pre = -1; 
int next=-1;


void menu(ALGraph& L,char FileName[]){
	flag1 = 0; 
//	if(!L)	flag1=0;
//	else flag1=1;
	char name[30];
	strcpy(name,FileName);
	int op=1;
	while(op){
		system("cls");	printf("\n\n");
		printf("      Menu for Graph On Linked Structure \n");
		printf("-------------------------------------------------\n");
		printf("    	  1. CreatGraph    8. DeleteVex\n");
		printf("    	  2. DestroyGraph  9. InsertArc \n");
		printf("    	  3. LocateVex     10. DeleteArc\n");
		printf("    	  4. PutVex        11. DFSTraverse\n");
		printf("    	  5. FirstAdjVex   12. BFSTraverse\n");
		printf("    	  6. NextAdjVex    13. SaveGraph\n");
		printf("    	  7. InsertVex     14. LoadGraph\n");
		printf("    	  0. Exit\n");
		printf("-------------------------------------------------\n");
		printf("    ��ѡ����Ĳ���[0~14]:");
		scanf("%d",&op);
	    switch(op){
		   	case 1:
			 	if (!flag1){
				 	
					VertexType V[30];
					KeyType VR[100][2];
					int i=0;
					do {
					    scanf("%d%s",&V[i].key,V[i].others);
					} while(V[i++].key!=-1);
					i=0;
					do {
					    scanf("%d%d",&VR[i][0],&VR[i][1]);
					   } while(VR[i++][0]!=-1);
					if (CreateCraph(L,V,VR)==ERROR) printf("�������ݴ��޷�����");
					else {
						for(int i=0;i<L.vexnum;i++)
						{
					     ArcNode *p=L.vertices[i].firstarc;
					     printf("%d %s",L.vertices[i].data.key,L.vertices[i].data.others);
					     while (p)
					     {
					         printf(" %d",p->adjvex);
					         p=p->nextarc;
					     }
					     printf("\n");
						}
						flag1 = 1;
					}
				}else{
			     	printf("���ܻ���Ѿ����ڵ�ͼ��ʼ��");
				} 
			 	getchar();getchar();
			 	break;
		   	case 2:
				if (!flag1)
				{
					printf("���ܶԲ����ڵ�ͼ�������ٲ�����\n");	
				}
				else
			    { 
			    	j = DestroyGraph(L); 
			        if(j==OK){
		            	printf("ͼ���ٳɹ���\n");
		            	flag1=0;	
					}else printf("δ��ȷ����ͼ");
			    } 
			 	getchar();getchar();
			 	break;
		   	case 3:
			    if (!flag1) { 
			    	printf("ͼδ����");
			    }
				else {
					KeyType u;
					printf("������Ҫ���ҵĶ��㣺\n");
					scanf("%d",&u);  
					j=LocateVex(L,u);
					if (j!=-1) printf("���Ҷ����λ��Ϊ%d\n",j);
					else	printf("�ڵ㲻����\n");
			    }
				getchar();getchar();
				break;
		   	case 4:
		   		if(!flag1){
		   			printf("���ܻ��޸Ĳ����ڵ�ͼ");
				}else {
					KeyType u;
					VertexType value;
					printf("������Ҫ�޸ĵĶ��㣺\n");
					scanf("%d",&u);  
					printf("�������޸�ֵ��\n");
					scanf("%d%s",&value.key,value.others);
					j = PutVex(L,u,value);
					if(j)	printf("�޸ĳɹ�\n");
					else	printf("����ʧ��\n"); 
				}   
				getchar();getchar();
				break;
		   	case 5:
				if(!flag1){
		   			printf("ͼδ����\n");
				}else{
					KeyType u;
					printf("������Ҫ���ҵĶ��㣺\n");
					scanf("%d",&u); 
					j = FirstAdjVex(L,u);
					if (j!=-1)
						printf("%d %s",L.vertices[j].data.key,L.vertices[j].data.others);
					else
						printf("����ʧ��");
				}     
			 	getchar();getchar();
			 	break;
		   	case 6:
		   		if(!flag1){
		   			printf("���ܻ�Բ����ڵ�ͼ���в�ѯ\n");
				}else{
					int v,w;
					printf("������v��w"); 
					scanf("%d%d",&v,&w);
					j = NextAdjVex(L,v,w);
					if (j!=-1)
						printf("%d %s",L.vertices[j].data.key,L.vertices[j].data.others);
					else
						printf("����һ�ڽӶ���");
				} 
			 	getchar();getchar();
				break;
		   	case 7:
		   		if(!flag1){
		   			printf("���ܻ�Բ����ڵ�ͼ���ж������\n");
				}else{
					VertexType v;
					printf("������Ҫ����Ķ������Ϣ\n");
					scanf("%d%s",&v.key,v.others);
					j = InsertVex(L,v);
					if (j==OK)
						for(int i=0;i<L.vexnum;i++)
						{
					     ArcNode *p=L.vertices[i].firstarc;
					     printf("%d %s",L.vertices[i].data.key,L.vertices[i].data.others);
					     while (p)
					     {
					         printf(" %d",p->adjvex);
					         p=p->nextarc;
					     }
					     printf("\n");
						}
					else printf("�������ʧ��");
				} 
			 	getchar();getchar();
			 	break;
		   	case 8:
		   		if(!flag1){
		   			printf("���ܻ�Բ����ڵ�ͼ���нڵ�ɾ��\n");
				}else{
					KeyType v;
					printf("������Ҫɾ���Ķ���:\n"); 
					scanf("%d",&v);
					
					j = DeleteVex(L,v);
					if (j==OK) {
						for(int i=0;i<L.vexnum;i++)
						{
					     ArcNode *p=L.vertices[i].firstarc;
					     printf("%d %s",L.vertices[i].data.key,L.vertices[i].data.others);
					     while (p)
					     {
					         printf(" %d",p->adjvex);
					         p=p->nextarc;
					     }
					     printf("\n");
						}
					}
					else printf("ɾ���������ʧ��");
				}    
			 	getchar();getchar();
			 	break;
		   	case 9:
		   		if(!flag1){
		   			printf("���ܻ�Բ����ڵ�ͼ���в���\n");
				}else{
					KeyType v,w;
					printf("������Ҫ����Ļ����������㣺\n");
					scanf("%d%d",&v,&w);
					j=InsertArc(L,v,w);
					if (j==OK) {
						for(int i=0;i<L.vexnum;i++)
						{
					     ArcNode *p=L.vertices[i].firstarc;
					     printf("%d %s",L.vertices[i].data.key,L.vertices[i].data.others);
					     while (p)
					     {
					        printf(" %d",p->adjvex);
					        p=p->nextarc;
					     }
					     printf("\n");
						}
					}
					else printf("���뻡����ʧ��");
				} 
			 	getchar();getchar();
			 	break;
		   	case 10:
		   		if(!flag1){
		   			printf("���ܻ�Բ����ڵ�ͼ���б�ɾ��\n");
				}else{
					KeyType v,w;
					printf("������Ҫɾ���Ļ����������㣺\n");
					scanf("%d%d",&v,&w);
					j = DeleteArc(L,v,w);
					if (j==OK) {
						for(int i=0;i<L.vexnum;i++)
						{
					     ArcNode *p=L.vertices[i].firstarc;
					     printf("%d %s",L.vertices[i].data.key,L.vertices[i].data.others);
					     while (p)
					     {
					        printf(" %d",p->adjvex);
					        p=p->nextarc;
					     }
					     printf("\n");
						}
					}
					else printf("ɾ��������ʧ��");
				} 
			 	getchar();getchar();
			 	break;
		   	case 11:
				if(!flag1){
		   			printf("���ܻ�Բ����ڵ�ͼ���б���\n");
				}else{
					DFSTraverse(L,visit);
				}
			 	getchar();getchar();
			 	break;
		 	case 12:
				if(!flag1){
		   			printf("���ܻ�Բ����ڵ�ͼ���б���\n");
				}else{
					BFSTraverse(L,visit);
				}    
			 	getchar();getchar();
			 	break;
			case 13:{
				if(!flag1){
		   			printf("���ܻ�Բ����ڵ�ͼ���д洢\n");
				}else{
					j=SaveGraph(L, name);
					if(j==OK){
						printf("����ɹ���\n"); 
					}
				} 
				getchar();getchar();
				break;
			}
			case 14:{
				if(flag1){
					printf("���ܶ��Ѵ��ڵ�ͼ���ж��ļ�������");
				}else{
//					L = (ALGraph*)malloc(sizeof(ALGraph));  
					j=LoadGraph(L, name);
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



