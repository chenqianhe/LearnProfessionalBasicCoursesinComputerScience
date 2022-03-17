#include "lab3.h"
STACK::STACK(int m) :QUEUE(m), q(m) {}
STACK::STACK(const STACK& s) : QUEUE(s), q(s.q) {}
STACK::STACK(STACK&& s)noexcept :QUEUE((QUEUE&&)s), q((QUEUE&&)s.q) {}
int STACK::size() const noexcept {
    return 2 * q.size();
}
STACK::operator int()const noexcept {
    return q.operator int() + QUEUE::operator int();
}
STACK& STACK::operator<<(int e) {
    if (QUEUE::operator int() < QUEUE::size() - 1) {
        QUEUE::operator<<(e);
        return *this;
    }
    if (q.operator int() < q.size() - 1) {
        q << e;
        return *this;
    }
    throw "STACK is full!";
}
STACK& STACK::operator>>(int& e) {
    int m = operator int();//基类中队列实际含有元素个数
    int n = q.operator int();//后一队列实际含有元素个数
    int* elem = NULL;
    if (m == 0)    throw"STACK is empty!";
    else {
        elem = new int[m];//用来暂时存储元素
        int i;
        if (n == 0) {
            for (i = 0; i < m - 1; i++) {
                QUEUE::operator>>(elem[i]);
            }
            QUEUE::operator>>(e);
            for (i = 0; i < m - 1; i++) {
                QUEUE::operator<<(elem[i]);
            }
            return *this;
        }
        else {
            elem = new int[n];
            int i;
            for (i = 0; i < n - 1; i++) {
                q >> (elem[i]);
            }
            q >> (e);
            for (i = 0; i < n - 1; i++) {
                q << (elem[i]);
            }
            return *this;
        }
    }
}
STACK& STACK::operator=(const STACK& s) {
    QUEUE::operator=(s);
    q = s.q;
    return *this;
}
STACK& STACK::operator=(STACK&& s)noexcept {
    QUEUE::operator=((QUEUE&&)s);
    q = (QUEUE&&)s.q;
    return *this;
}
char* STACK::print(char* b)const noexcept {
    QUEUE::print(b);
    q.print(b);
    return b;
}