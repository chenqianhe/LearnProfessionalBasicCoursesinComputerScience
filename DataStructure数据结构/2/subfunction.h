#include "def.h"

status InitList(LinkList &L){
// ���Ա�L�����ڣ�����һ���յ����Ա�����OK�����򷵻�INFEASIBLE��
    if(!L){
        L=(LinkList)malloc(sizeof(LNode));
        L->next=NULL;
        return OK;
    }else{
        return INFEASIBLE;
    }
}
status DestroyList(LinkList &L){
// ������Ա�L���ڣ��������Ա�L���ͷ�����Ԫ�صĿռ䣬����OK�����򷵻�INFEASIBLE��
    if(L){
        free(L->next);
        L=NULL;
        return OK;
    }else{
        return INFEASIBLE;
    }
}

status ClearList(LinkList &L){
// ������Ա�L���ڣ�ɾ�����Ա�L�е�����Ԫ�أ�����OK�����򷵻�INFEASIBLE��
    if(L){
        free(L->next);
        L->next=NULL;
        return OK;
    }else{
        return INFEASIBLE;
    }
}
status ListEmpty(LinkList L){
// ������Ա�L���ڣ��ж����Ա�L�Ƿ�Ϊ�գ��վͷ���TRUE�����򷵻�FALSE��������Ա�L�����ڣ�����INFEASIBLE��
    if(L){
        if(L->next==NULL){
            return TRUE;
        }else{
            return FALSE;
        }
    }else{
        return INFEASIBLE;
    }
}
int ListLength(LinkList L){
// ������Ա�L���ڣ��������Ա�L�ĳ��ȣ����򷵻�INFEASIBLE��
    int length=0;
    LinkList p=L;
    if(L){
        while(p->next!=0){
            length++;
            p=p->next;
        }
        return length;
    }else{
        return INFEASIBLE;
    }
}
status GetElem(LinkList L,int i,ElemType &e){
// ������Ա�L���ڣ���ȡ���Ա�L�ĵ�i��Ԫ�أ�������e�У�����OK�����i���Ϸ�������ERROR��������Ա�L�����ڣ�����INFEASIBLE��
    if(L){
        int length=0;
        LinkList p=L;
        while(p->next!=0){
            length++;
            p=p->next;
        }
        if(i<1||i>length){
            return ERROR;
        }else{
            p=L;
            for(int j=0;j<i;j++){
                p=p->next;
            }
            e=p->data;
            return OK;
        }
    }else{
        return INFEASIBLE;
    }
}
status LocateElem(LinkList L,ElemType e){
// ������Ա�L���ڣ�����Ԫ��e�����Ա�L�е�λ����ţ����e�����ڣ�����ERROR�������Ա�L������ʱ������INFEASIBLE��
    if(L){
        int i=0;
        LinkList p=L;
        while(p->next){
            if(p->data==e){
                return i;
            }
            i++;
            p=p->next;
        }
        if(p->data==e){
            return i;
        }
        return ERROR;
        
    }else{
        return INFEASIBLE;
    }
}
status PriorElem(LinkList L,ElemType e,ElemType &pre){
// ������Ա�L���ڣ���ȡ���Ա�L��Ԫ��e��ǰ����������pre�У�����OK�����û��ǰ��������ERROR��������Ա�L�����ڣ�����INFEASIBLE��
    if(L){
        LinkList p=L;
        while(p->next){
            if(p->next->data==e&&p!=L){
                pre=p->data;
                return OK;
            }
            p=p->next;
        }
        return ERROR;
    }else{
        return INFEASIBLE;
    }
}
status NextElem(LinkList L,ElemType e,ElemType &next){
// ������Ա�L���ڣ���ȡ���Ա�LԪ��e�ĺ�̣�������next�У�����OK�����û�к�̣�����ERROR��������Ա�L�����ڣ�����INFEASIBLE��
    if(L){
        LinkList p=L;
        while(p->next){
            if(p->data==e){
                next=p->next->data;
                return OK;
            }
            p=p->next;
        }
        return ERROR;


    }else{
        return INFEASIBLE;
    }
}
status ListInsert(LinkList &L,int i,ElemType e){
// ������Ա�L���ڣ���Ԫ��e���뵽���Ա�L�ĵ�i��Ԫ��֮ǰ������OK��������λ�ò���ȷʱ������ERROR��������Ա�L�����ڣ�����INFEASIBLE��
    if(L){
        int t=0;
        LinkList p=L;
        int length=0;
        while(p->next!=0){
            length++;
            p=p->next;
        }
        p=L;
        if(i<1||i>length+1){
            return ERROR;
        }else{
            for(int j=0;j<i-1;j++){
                p=p->next;
            }
            LinkList temp=(LinkList)malloc(sizeof(LNode));
            temp->data=e;
            temp->next=p->next;
            p->next=temp;
            return OK;
        }

    }else{
        return INFEASIBLE;
    }
}
status ListDelete(LinkList &L,int i,ElemType &e){
// ������Ա�L���ڣ�ɾ�����Ա�L�ĵ�i��Ԫ�أ���������e�У�����OK����ɾ��λ�ò���ȷʱ������ERROR��������Ա�L�����ڣ�����INFEASIBLE��
    if(L){
        int t=0;
        LinkList p=L;
        int length=0;
        while(p->next!=0){
            length++;
            p=p->next;
        }
        p=L;
        if(i<1||i>length+1){
            return ERROR;
        }else{
            for(int j=0;j<i-1;j++){
                p=p->next;
            }
            LinkList temp=p->next->next;
            e=p->next->data;
            free(p->next);
            p->next=temp;
            return OK;
        }

    }else{
        return INFEASIBLE;
    }   
}
status ListTraverse(LinkList L){
// ������Ա�L���ڣ�������ʾ���Ա��е�Ԫ�أ�ÿ��Ԫ�ؼ��һ�񣬷���OK��������Ա�L�����ڣ�����INFEASIBLE��
    if(L){

        LinkList p=L->next;
        if(!(L->next)){
            return OK;
        }
        while(p->next){
            printf("%d ",p->data);
            p=p->next;
        }
        printf("%d",p->data);
        return OK;
    }else{
        return INFEASIBLE;
    }
}
status SaveList(LinkList L,char FileName[]){
// ������Ա�L���ڣ������Ա�L�ĵ�Ԫ��д��FileName�ļ��У�����OK�����򷵻�INFEASIBLE��
    FILE  *fp;
    if(!L){
        return INFEASIBLE;
    }else{
        LinkList p=L->next;

        if((fp=fopen(FileName,"wb"))!=NULL){
            while(p->next){
                fputc(p->data,fp);
                p=p->next;
            }
            fputc(p->data,fp);
            fclose(fp);

            return OK;
        }else{
             return INFEASIBLE;
         }
    }
}
status LoadList(LinkList &L,char FileName[]){
// ������Ա�L�����ڣ���FileName�ļ��е����ݶ��뵽���Ա�L�У�����OK�����򷵻�INFEASIBLE��
    FILE  *fp;
    if(L){
        return INFEASIBLE;
    }else{
        
        L=(LinkList)malloc(sizeof(LNode));
        L->next=(LinkList)malloc(sizeof(LNode));
        LinkList p=L->next;

        if ((fp=fopen(FileName,"rb"))!=NULL){
            
            while(1){
                p->data=fgetc(fp);
                if(feof(fp)){
                    p->next=NULL;
                    break;
                }
                p->next=(LinkList)malloc(sizeof(LNode));
                p=p->next;
            }
            p=L;
            while(p->next->next){
                p=p->next;
            }
            p->next=NULL;
            fclose(fp);
            return OK;
        }else{
            return INFEASIBLE;
        }
        
    }
}

