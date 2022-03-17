#include <stdio.h>
#include <string.h>
#include <malloc.h>
#include <cstdlib>

#define TRUE 1
#define FALSE 0
#define OK 1
#define ERROR 0
#define INFEASIBLE -1
#define OVERFLOW -2
#define MAX_VERTEX_NUM 20
typedef int status;
typedef int KeyType; 
typedef enum {DG,DN,UDG,UDN} GraphKind;
typedef struct {
     KeyType  key;
     char others[20];
} VertexType; //�������Ͷ���
typedef struct ArcNode {         //�������Ͷ���
        int adjvex;              //����λ�ñ�� 
     struct ArcNode  *nextarc;       //��һ������ָ��
} ArcNode;
typedef struct VNode{                //ͷ��㼰���������Ͷ���
        VertexType data;           //������Ϣ
     ArcNode *firstarc;           //ָ���һ����
    } VNode,AdjList[MAX_VERTEX_NUM];
typedef  struct {  //�ڽӱ�����Ͷ���
    AdjList vertices;          //ͷ�������
    int vexnum,arcnum;         //������������
    GraphKind  kind;        //ͼ������
   } ALGraph, *aLGraph;
typedef struct{  
     struct { char name[30];
     		  ALGraph L;	
      } elem[10];
      int length;
      int listsize;
 }LISTS;
