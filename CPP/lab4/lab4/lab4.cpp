#define _CRT_SECURE_NO_WARNINGS 
#include <iomanip> 
#include <exception>
#include <typeinfo>
#include <string.h>
#include<iostream>
using namespace std;
template <typename T>
class MAT {
	T* const e;							//指向所有整型矩阵元素的指针
	const int r, c;							//矩阵的行r和列c大小
public:
	MAT(int r, int c) :MAT::r(r), MAT::c(c), e(new T[r * c]) {};						//矩阵定义
	MAT(const MAT& a) :r(a.r), c(a.c), e(NULL) {
		T* arr = new T[r * c];
		for (int i = 0; i < r * c; i++)
			arr[i] = a.e[i];
		*(T**)&e = arr;
	};			//深拷贝构造
	MAT(MAT&& a)noexcept :r(a.r), c(a.c), e(a.e) {
		*(int*)&(a.c) = 0;
		*(int*)&(a.r) = 0;
		*(T**)&(a.e) = NULL;
	};	//移动构造
	virtual ~MAT()noexcept {
		delete[]e;
		*(T**)&e = NULL;
		*(int*)&c = 0;
		*(int*)&r = 0;
	};
	virtual T* const operator[](int r) {
		if (r > this->r - 1 || r < 0)
			throw "error";
		else
			return &e[r * c];
	};//取矩阵r行的第一个元素地址，r越界抛异常
	virtual MAT operator+(const MAT& a)const {
		T* arr = new T[r * c];
		MAT R(r, c);
		*(T**)&R.e = arr;
		if (r != a.r || c != a.c)
			throw "error";
		else {
			memset(arr, 0, r * c);
			for (int i = 0; i < r * c; i++)
				arr[i] = e[i] + a.e[i];
		}
		return R;
	};	//矩阵加法，不能加抛异常
	virtual MAT operator-(const MAT& a)const {
		T* arr = new T[r * c];
		MAT R(r, c);
		*(T**)&R.e = arr;
		if (r != a.r || c != a.c)
			throw "error";
		else {
			memset(arr, 0, r * c);
			for (int i = 0; i < r * c; i++)
				arr[i] = e[i] - a.e[i];
		}
		return R;
	};	//矩阵减法，不能减抛异常
	virtual MAT operator*(const MAT& a)const {
		T* arr = new T[r * a.c];
		memset(arr, 0, sizeof(T) * r * a.c);
		MAT<T> R(r, a.c);
		*(T**)&R.e = arr;
		if (c != a.r || !e || !a.e)
			throw "error";
		else
		{
			for (int i = 0; i < r; i++)
				for (int j = 0; j < a.c; j++) {
					for (int k = 0; k < c; k++)
						arr[i * a.c + j] += e[i * c + k] * a.e[k * a.c + j];
				}
		}
		return R;
	};	//矩阵乘法，不能乘抛异常
	virtual MAT operator~()const {
		MAT M(c, r);
		for (int i = 0; i < c; i++)
			for (int j = 0; j < r; j++)
				M.e[i * r + j] = e[j * c + i];
		return M;
	};					//矩阵转置
	virtual MAT& operator=(const MAT& a) {
		if (e == a.e) return *this;
		if (e != NULL) *(T**)&e = NULL;
		T* arr = new T[r * c];
		for (int i = 0; i < r * c; i++)
			arr[i] = a.e[i];
		*(T**)&e = arr;
		*(int*)&r = a.r;
		*(int*)&c = a.c;
		return *this;
	};		//深拷贝赋值运算
	virtual MAT& operator=(MAT&& a)noexcept {
		if (e == a.e) return *this;
		if (e != NULL) *(T**)&e = NULL;
		*(int*)&r = a.r;
		*(int*)&c = a.c;
		*(T**)&e = a.e;
		*(int*)&(a.c) = 0;
		*(int*)&(a.r) = 0;
		*(T**)&(a.e) = NULL;
	};	//移动赋值运算
	virtual MAT& operator+=(const MAT& a) {
		if (r != a.r || c != a.c)
			throw "error";
		else
			for (int i = 0; i < r * c; i++)
				e[i] += a.e[i];
		return *this;
	};		//“+=”运算
	virtual MAT& operator-=(const MAT& a) {
		if (r != a.r || c != a.c)
			throw "error";
		else
			for (int i = 0; i < r * c; i++)
				e[i] -= a.e[i];
		return *this;
	};		//“-=”运算
	virtual MAT& operator*=(const MAT& a) {
		T* arr = new T[r * a.c];
		memset(arr, 0, sizeof(T) * r * a.c);
		if (c != a.r || !e || !a.e)
			throw "error";
		else
		{
			for (int i = 0; i < r; i++)
				for (int j = 0; j < a.c; j++) {
					for (int k = 0; k < c; k++)
						arr[i * a.c + j] += e[i * c + k] * a.e[k * a.c + j];
				}
			*(int*)&c = a.c;
			*(T**)&e = arr;
		}
		return *this;
	};		//“*=”运算
//print输出至s并返回s：列用空格隔开，行用回车结束
	virtual char* print(char* s)const noexcept {
		s[0] = '\0';
		for (int i = 0; i < r * c; i++) {
			char* ss = s + strlen(s);
			if (typeid(e) == typeid(int*))
				sprintf(ss, "%6ld ", e[i]);
			else
				if (typeid(e) == typeid(long long*))
					sprintf(ss, "%8d ", e[i]);
			if ((i + 1) % c == 0) {
				ss = s + strlen(s);
				sprintf(ss, "\n");
			}
		}
		return s;
	};
};
template MAT<int>;			//用于实验四
template MAT<long long>;		//用于实验四
extern const char* TestMAT(int& s);	//用于实验四
int main(int argc, char* argv[]) 					
{
	const char* e;
	int s;
	e = TestMAT(s);
	cout << e << endl;
	cout << s << endl;
	return 0;
}
