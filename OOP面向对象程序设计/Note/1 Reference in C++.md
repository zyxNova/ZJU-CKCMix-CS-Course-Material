# Reference in C++

[TOC]

## 1 What is a reference in C++?

an alternative name for an existing variable

 A reference has the same memory address as the item it references.

```c++
#include<iostream>
using namespace std;

int main()
{
int x = 10;

// ref is a reference to x.
int& ref = x;

// Value of x is now changed to 20
ref = 20;
cout << "x = " << x << endl ;

// Value of x is now changed to 30
x = 30;
cout << "ref = " << ref << endl ;

return 0;
}
```



## 2 Application of Reference

### 2.1 Modify the passed parameters in a function

If a function receives a reference to a variable, it modifies a variable without having to create a copy of it. **The memory location of the passed variable and the reference is the same** and therefore, any change to the reference reflects in the variable as well.

> 按我的理解是，传参的时候传递的是变量的地址，在函数中对reference操作就是直接修改变量地址的内容，所以main函数中的变量内容也会跟着变

> 对reference操作更加接近操作一个变量，而不是像pointer一样需要很多* &等符号。但是本质上reference可以理解为简化版的、包装好的指针

```c++
#include<iostream>
using namespace std;

void swap (int& first, int& second)
{
	int temp = first;
	first = second;
	second = temp;
}

int main()
{
	int a = 2, b = 3;
	swap( a, b );
	cout << a << " " << b;
	return 0;
}
```



Note: the target of a reference must have an address!

```c++
void func(int &);
  func (i * 3);      // Warning or error!
```



### 2.2 Avoid a copy of large objects

Imagine a function that has to receive a large object. If we pass it without reference, a new copy of it is created which causes wastage of CPU time and memory.

```c++
struct Student {
string name;
string address;
int rollNo;
}

// If we remove & in below function, a new
// copy of the student object is created.
// We use const to avoid accidental updates
// in the function as the purpose of the function
// is to print s only.
void print(const Student &s)
{
	cout << s.name << " " << s.address << " " << s.rollNo;
}
```

> 这相当于只是传递了结构体的地址进去。注意reference参数调用结构体使用.而不是->



## 3 Reference vs. Pointer

| Reference                                              | Pointer                                                      |
| ------------------------------------------------------ | ------------------------------------------------------------ |
| Bindings don’t change at run time                      | can be re-assigned                                           |
| must be assigned to an existing variable               | can be assigned NULL                                         |
| cannot                                                 | can use increment/decrement operators                        |
| has the same memory address as the item it references. | holds a memory address                                       |
| a reference uses a ‘.’                                 | A pointer to a class/struct uses ‘->’ (arrow operator) to access its members |
| can be used directly                                   | be dereferenced with * to access the memory location it points to |



```c++
// C++ program to demonstrate differences
// between pointer and reference
#include <iostream>
using namespace std;

struct demo {
	int a;
};

int main()
{
	int x = 5;
	int y = 6;
	demo d;

	int* p;
	p = &x;
	p = &y; // 1. Pointer reintialization allowed

	int& r = x;
	// &r = y;				 // 1. Compile Error

	r = y; // 1. x value becomes 6

	p = NULL;
	// &r = NULL;			 // 2. Compile Error

	// 3. Points to next memory location
	p++;

	// 3. x values becomes 7
	r++;

	cout << &p << " " << &x << '\n'; // 4. Different address
	cout << &r << " " << &x << '\n'; // 4. Same address

	demo* q = &d;
	demo& qq = d;

	q->a = 8;
	// q.a = 8;				 // 5. Compile Error
	qq.a = 8;
	// qq->a = 8;			 // 5. Compile Error

	// 6. Prints the address
	cout << p << '\n';

	// 6. Print the value of x
	cout << r << '\n';

	return 0;
}
```



## 4 Restrictions

- No reference to reference
  - `int&& k //illegal`
  - but `int i; int& k = i; int& r = k;` is ok
- No pointers to references
  - `int&* p //illegal`
- Reference to pointer is ok
  - `int*& p //legal`
- No arrays of references



