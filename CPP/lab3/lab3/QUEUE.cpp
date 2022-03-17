#include "lab3.h"

QUEUE::operator int() const noexcept	//返回队列的实际元素个数
{
    if (tail >= head) //tail>head
        return tail - head;
    else  return (max + tail - head); //tail<head,实际元素数量是max+tail-head
}
int QUEUE::size() const noexcept		//返回队列申请的最大元素个数max
{
    return max;
}

QUEUE& QUEUE::operator<<(int e)  	//将e入队列尾部，并返回当前队列
{
    if (head == (tail + 1) % max) //判断队满
        throw "QUEUE is full!";
    else {
        elems[tail] = e;
        tail = (tail + 1) % max;
    }
    return *this; //返回当前队列
}

 QUEUE& QUEUE::operator>>(int& e) 	//从队首出元素到e，并返回当前队列
{
    if (head == tail) {  //空队列
        e = 0;
        throw "QUEUE is empty!";
    }
    else {
        e = elems[head];
        head = (head + 1) % max;
    }
    return *this; //返回当前指针
}

 QUEUE& QUEUE::operator=(const QUEUE& q)//深拷贝赋值并返回被赋值队列
{
    if (this == &q)
        return *this;
    if (elems)
        delete[] elems;  //使用new[]申请的内存释放时要用delete[]才行

    *(int*)&(this->max) = q.max;
    *(int**)&(this->elems) = new int[q.max];
    int* elems = q.elems;
    head = q.head;
    tail = q.tail;
    memcpy(this->elems, q.elems, q.max * sizeof(int));
    return *this;
}
QUEUE& QUEUE::operator=(QUEUE&& q)noexcept//移动赋值并返回被赋值队列
{
    if (this == &q)
        return *this;
    if (elems)
        delete[] elems;
    head = q.head;
    tail = q.tail;
    *(int*)&max = q.max;
    *(int**)&elems = q.elems;
    *(int**)&q.elems = 0;
    *(int*)&q.max = 0;
    q.head = q.tail = 0;
    return *this;
}

char* QUEUE::print(char* s) const noexcept//打印队列至s尾部并返回s：s[0]=’\0’
{
    int m = max;
    if (!m) {
        return s;
    }
    for (int i = head; i != tail; i = (i + 1) % m) {
        char* ss = s + strlen(s);
        sprintf(ss, "%d,", elems[i]);
    }
    return s;

}
QUEUE::~QUEUE() 					//销毁当前队列
{
    if (elems) {
        delete[] elems;
        (int*&)elems = 0;
        tail = 0;
        head = 0;
        (int*&)(max) = 0;
    }
}

QUEUE::QUEUE(int m) : elems(new int[m]), max(m) {
    head = tail = 0;
}


QUEUE::QUEUE(const QUEUE& q) : elems(new int[q.max]), max(q.max) { //用q深拷贝初始化队列
    head = q.head;
    tail = q.tail;
    for (int i = 0; i < max; i++)
        *(elems + i) = q.elems[i];
}

QUEUE::QUEUE(QUEUE&& q)noexcept : elems(q.elems), max(q.max), head(q.head), tail(q.tail) {
    *(int**)&q.elems = 0;
    *(int*)&q.max = 0;
    q.head = q.tail = 0;
}





