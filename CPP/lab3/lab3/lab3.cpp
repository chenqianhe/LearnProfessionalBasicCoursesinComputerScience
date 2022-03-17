#include "lab3.h"
//extern const char* TestSTACK(int& s);
//int main(void) {
//    const char* e;
//    int s;
//    e = TestSTACK(s);
//    cout << e << endl;
//    cout << s << endl;
//}
int main() {
    STACK stack(10);
    cout << "stack栈中元素数量" << int(stack) << endl;
    for (size_t i = 0; i < 18; i++)
    {
        stack.operator<<(i + 1);
    }
    cout << "stack栈中元素数量" << int(stack) << endl;

    //打印
    cout << "stack栈中元素:";
    char* stack_b = new char[100];
    stack_b[0] = '\0';
    stack.print(stack_b);
    cout << stack_b << endl;

    //出栈
    for (size_t i = 18; i > 0; i--)
    {
        int e = -1;
        stack >> e;
    }
    cout << "stack栈中元素数量" << int(stack) << endl;

    STACK s(10);
    STACK p(10);

    for (size_t i = 18; i > 0; i--)
    {
        s.operator<<(i + 1);
        p.operator<<(i + 1);
    }

    STACK stack2((STACK&&)s);
    cout << "s栈中元素数量" << int(s) << endl;
    cout << "stack2栈中元素数量" << int(stack2) << endl;

    STACK stack3(p);
    cout << "p栈中元素数量" << int(p) << endl;
    cout << "stack3栈中元素数量" << int(stack3) << endl;

    for (size_t i = 18; i > 0; i--)
    {
        int e = -1;
        p >> e;
    }
    cout << "stack2栈中元素数量" << int(stack2) << endl;

    cout << "p栈中元素数量" << int(p) << endl;
    cout << "stack3栈中元素数量" << int(stack3) << endl;

    stack.~STACK();
    p.~STACK();
    stack2.~STACK();
    stack3.~STACK();

    return 0;
}