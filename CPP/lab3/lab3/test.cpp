#include "lab3.h"

int main() {
    STACK stack(10);
    cout << "stackջ��Ԫ������" << int(stack) << endl;
    for (size_t i = 0; i < 18; i++)
    {
        stack.operator<<(i + 1);
    }
    cout << "stackջ��Ԫ������" << int(stack) << endl;

    //��ӡ
    cout << "stackջ��Ԫ��:";
    char* stack_b = new char[100];
    stack_b[0] = '\0';
    stack.print(stack_b);
    cout << stack_b << endl;

    //��ջ
    for (size_t i = 18; i > 0; i--)
    {
        int e = -1;
        stack >> e;
    }
    cout << "stackջ��Ԫ������" << int(stack) << endl;

    STACK s(10);
    STACK p(10);

    for (size_t i = 18; i > 0; i--)
    {
        s.operator<<(i + 1);
        p.operator<<(i + 1);
    }

    STACK stack2((STACK&&)s);
    cout << "sջ��Ԫ������" << int(s) << endl;
    cout << "stack2ջ��Ԫ������" << int(stack2) << endl;

    STACK stack3(p);
    cout << "pջ��Ԫ������" << int(p) << endl;
    cout << "stack3ջ��Ԫ������" << int(stack3) << endl;

    for (size_t i = 18; i > 0; i--)
    {
        int e = -1;
        p >> e;
    }
    cout << "stack2ջ��Ԫ������" << int(stack2) << endl;

    cout << "pջ��Ԫ������" << int(p) << endl;
    cout << "stack3ջ��Ԫ������" << int(stack3) << endl;

    stack.~STACK();
    p.~STACK();
    stack2.~STACK();
    stack3.~STACK();

    return 0;
}