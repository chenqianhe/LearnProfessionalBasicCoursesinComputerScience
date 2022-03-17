#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <string.h>
#include <malloc.h>
#include <iostream>
extern const char* TestQueue(int& s);
struct Queue
{
    int* const elems;        //elems申请内存用于存放队列的元素
    int max;        //elems申请的最大元素个数max
    int head, tail;        //队列头head和尾tail，队空head=tail;初始head=tail=0
};

void initQueue(Queue* const p, int m);    //初始化p指队列：最多申请m个元素
void initQueue(Queue* const p, const Queue& s); //用s深拷贝初始化p指队列
void initQueue(Queue* const p, Queue&& s); //用s移动初始化p指队列
int number(const Queue* const p);    //返回p指队列的实际元素个数
int size(const Queue* const p);            //返回p指队列申请的最大元素个数max
Queue* const enter(Queue* const p, int e);  //将e入队列尾部，并返回p
Queue* const leave(Queue* const p, int& e); //从队首出元素到e，并返回p
Queue* const assign(Queue* const p, const Queue& q); //深拷贝赋s给队列并返回p
Queue* const assign(Queue* const p, Queue&& q); //移动赋s给队列并返回p
char* print(const Queue* const p, char* s);//打印p指队列至s并返回s
void destroyQueue(Queue* const p);     //销毁p指向的队列

int main()
{   
    int a[5] = { 1,2,3,4,5 };
    Queue* p = (Queue*)malloc(sizeof(Queue));
    initQueue(p, 6);
    std::cout << p->max << p->head << p->tail << sizeof(p->elems) << std::endl;
    Queue s = { a,5,0,4 };
    initQueue(p, s);
    std::cout << p->max << p->head << p->tail << sizeof(p->elems) << std::endl;

    int ss = 0;
    const char* e = TestQueue(ss);
    return 0;
}

void initQueue(Queue* const p, int m)
{
    p->head = p->tail = 0;
    *(int*)&(p->max) = m;
    *(int**)&(p->elems) = (int*)calloc(m, sizeof(int));
    return;
}
void initQueue(Queue* const p, const Queue& s)
{
    if (s.elems == nullptr)
    {
        p->head = 0;
        p->tail = 0;
        *(int*)&(p->max) = 0;
        *(int**)&(p->elems) = nullptr;
    }
    else {
        p->head = s.head;
        p->tail = s.tail;
        *(int*)&(p->max) = s.max;
        *(int**)&(p->elems) = (int*)malloc((s.max) * sizeof(int));
        for (int i = s.head; i < s.tail; i++)
            (p->elems)[i % (s.max)] = (s.elems)[i % (s.max)];
    }
    return;
}
void initQueue(Queue* const p, Queue&& s)
{
    p->head = s.head;
    p->tail = s.tail;
    *(int*)&(p->max) = s.max;
    *(int**)&(p->elems) = (int*)(s.elems);
    s.head = s.tail = 0;
    *(int*)&(s.max) = 0;
    *(int**)&(s.elems) = nullptr;
    return;
}
int  number(const Queue* const p)	//返回p指队列的实际元素个数
{
    if (p->max == 0)
        return 0;
    return ((p->tail) - (p->head) + (p->max)) % (p->max);
}
int  size(const Queue* const p)			//返回p指队列申请的最大元素个数max
{
    return (p->max);
}
Queue* const enter(Queue* const p, int e)  //将e入队列尾部，并返回p
{
    if (number(p) == (p->max - 1))
        throw "Queue is full!";
    else
    {
        (p->elems)[(p->tail) % (p->max)] = e;
        (p->tail)++;
    }
    return p;
}
Queue* const leave(Queue* const p, int& e) //从队首出元素到e，并返回p
{
    if (number(p) == 0)
        throw "Queue is empty!";
    else
    {
        e = (p->elems)[(p->head) % (p->max)];
        (p->head)++;
    }
    return p;
}
Queue* const assign(Queue* const p, const Queue& q) //深拷贝赋s给队列并返回p
{
    if (p == &q)
        return p;
    if (p->elems)
    {
        //delete[](p->elems) ;
        *(int**)&(p->elems) = nullptr;
    }
    initQueue(p, q);
    return p;
}
Queue* const assign(Queue* const p, Queue&& q) //移动赋s给队列并返回p
{
    if (p == &q)
        return p;
    if (p->elems)
    {
        *(int**)&(p->elems) = nullptr;
    }
    p->head = q.head;
    p->tail = q.tail;
    *(int*)&(p->max) = q.max;
    *(int**)&(p->elems) = (int*)(q.elems);
    q.head = q.tail = 0;
    *(int*)&(q.max) = 0;
    *(int**)&(q.elems) = nullptr;
    return p;
}
//char* print(const Queue* const p, char* s)//打印p指队列至s尾部并返回s：s[0]=’\0’
//{
//    int i = 0, e = 0;
//    int j = p->head;
//    int h = 0;
//    int num[100];
//    for (j = p->head; j < (p->tail); j++)
//    {
//        h = 0;
//        e = p->elems[j % (p->max)];
//        while (e)
//        {
//            num[h++] = e % 10 + '0';
//            e /= 10;
//        }
//        while (h)
//        {
//            s[i++] = num[--h];
//        }
//        s[i++] = ',';
//    }
//    if (i > 0)i--;
//    s[i] = '\0';
//    return s;
//
//}
char* print(const Queue* const p, char* s)//打印p指队列至s尾部并返回s：s[0]=’\0’
{

    int kk = 0;
    for (int k = p->head,i=0; i < number(p); k++,i++) {
        sprintf(s + kk, "%d,", p->elems[k%p->max]);
        kk = strlen(s);
    }
    
    //for (int i = 0, j = strlen(s)-1; i != j; i++, j--) {
    //    char temp = s[i];
    //    s[i] = s[j];
    //    s[j] = temp;
    //}
    return s;
}
void destroyQueue(Queue* const p)
{
    free(p->elems);
    p->head = p->tail = 0;
    *(int*)&(p->max) = 0;
    *(int**)&(p->elems) = nullptr;
    return;
}
