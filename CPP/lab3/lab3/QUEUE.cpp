#include "lab3.h"

QUEUE::operator int() const noexcept	//���ض��е�ʵ��Ԫ�ظ���
{
    if (tail >= head) //tail>head
        return tail - head;
    else  return (max + tail - head); //tail<head,ʵ��Ԫ��������max+tail-head
}
int QUEUE::size() const noexcept		//���ض�����������Ԫ�ظ���max
{
    return max;
}

QUEUE& QUEUE::operator<<(int e)  	//��e�����β���������ص�ǰ����
{
    if (head == (tail + 1) % max) //�ж϶���
        throw "QUEUE is full!";
    else {
        elems[tail] = e;
        tail = (tail + 1) % max;
    }
    return *this; //���ص�ǰ����
}

 QUEUE& QUEUE::operator>>(int& e) 	//�Ӷ��׳�Ԫ�ص�e�������ص�ǰ����
{
    if (head == tail) {  //�ն���
        e = 0;
        throw "QUEUE is empty!";
    }
    else {
        e = elems[head];
        head = (head + 1) % max;
    }
    return *this; //���ص�ǰָ��
}

 QUEUE& QUEUE::operator=(const QUEUE& q)//�����ֵ�����ر���ֵ����
{
    if (this == &q)
        return *this;
    if (elems)
        delete[] elems;  //ʹ��new[]������ڴ��ͷ�ʱҪ��delete[]����

    *(int*)&(this->max) = q.max;
    *(int**)&(this->elems) = new int[q.max];
    int* elems = q.elems;
    head = q.head;
    tail = q.tail;
    memcpy(this->elems, q.elems, q.max * sizeof(int));
    return *this;
}
QUEUE& QUEUE::operator=(QUEUE&& q)noexcept//�ƶ���ֵ�����ر���ֵ����
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

char* QUEUE::print(char* s) const noexcept//��ӡ������sβ��������s��s[0]=��\0��
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
QUEUE::~QUEUE() 					//���ٵ�ǰ����
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


QUEUE::QUEUE(const QUEUE& q) : elems(new int[q.max]), max(q.max) { //��q�����ʼ������
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





