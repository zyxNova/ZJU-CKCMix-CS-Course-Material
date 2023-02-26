# Overloaded Operators in C++

[TOC]



## 1 重载运算符的种类和限制

### 1.1 可以重载的运算符

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2022-04-29 at 10.32.32.png" alt="Screen Shot 2022-04-29 at 10.32.32" style="zoom:40%;" />



### 1.2 不可以重载的运算符

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2022-04-29 at 10.32.52.png" alt="Screen Shot 2022-04-29 at 10.32.52" style="zoom:40%;" />

### 1.3 运算符重载的限制

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2022-04-29 at 10.33.41.png" alt="Screen Shot 2022-04-29 at 10.33.41" style="zoom:40%;" />



## 2 运算符重载的本质和类型

### 2.1 运算符重载是什么

一个有着特殊名称的函数

<img src="/Users/particle/Library/Application Support/typora-user-images/image-20220429112958750.png" alt="image-20220429112958750" style="zoom:50%;" />



### 2.2 Member Function

- Implicit first argument

  ```c++
  x + y; //====> x.operator+(y);
  ```

- Developer must have access to class definition

- No type conversion performed on receiver

  ```c++
  z = x + y; // z = x.operator+(y);
  z = x + 3; // z = x.operator+(Integer(3));
  z = 3 + y; // error, Integer类型没有方法转成int
  ```

- 双目运算符需要一个参数

  ```c++
  const Integer operator+(const Integer& n) const {
    return Integer(i + n.i);
  }
  ```

- 单目运算符不需要参数

  ```c++
  const Integer operator-() const { 
  	return Integer(-i);
  }
  ```

  ```c++
  z = -x; // z.operator=(x.operator-());
  ```



### 2.3 Global Function

- Explicit first argument

- Can be made a friend

  <img src="/Users/particle/Library/Application Support/typora-user-images/image-20220429113801469.png" alt="image-20220429113801469" style="zoom:50%;" />

- Type conversions performed on both arguments

  <img src="/Users/particle/Library/Application Support/typora-user-images/image-20220429113848139.png" alt="image-20220429113848139" style="zoom:50%;" />



### 2.4 Member vs. Global Functions

**成员函数**

- 单目运算符
- === () [] -> ->* 必须是成员函数==

**全局函数**

- 其他双目运算符



## 3 运算符重载的函数原型

### 3.1 函数的组成部分

**参数**

- `const A&`: 传入只读的参数

**返回值**

- `const A`: 含有`const`关键字，则返回值无法作为左值，如`a+b`结果是一个新的对象，无法作为左值
- `bool`: 关系运算结果
- `A`和`A&`: 运算的结果可以作为左值

**const成员函数**



### 3.2 函数原型

- 算术与逻辑运算符，`+ - * / % ^ & | ~`

```c++
const T operatorX(const T& l, const T& r);
```

- 关系运算，`! && || < <= == >= >`

```c++
bool operatorX(const T& l, const T& r);
```

- `[]`

```c++
E& T::operator[](int index); //注意返回的是Element&,因为可以作为左值被修改
```

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2022-04-29 at 13.12.23.png" alt="Screen Shot 2022-04-29 at 13.12.23" style="zoom:50%;" />

- `++a, a++`

```c++
const Integer& operator++(); //++a
const Integer operator++(int); //a++
```



### 3.3 函数实现模版

#### ++a, a++

```c++
const Integer& Integer::operator++() {
	*this += 1; //调用+=重载运算符
  return *this;	//返回自增后的对象
}

const Integer Integer::operator++(int) {
  Integer old = *this;
  ++(*this);
  return old;	//返回一个新的对象，不可作为左值
}
```

- User-defined prefix is more efficient than postfix.



#### ==, !=

`!=`借助`==`实现

```c++
bool Integer::operator==(const Integer& rhs) {
  return i == rhs.i;
}

bool Integer::operator!=(const Integer& rhs) {
  return !(*this == rhs);
}
```



#### <, >, <=, >=

`>`, `<=`, `>=`借助`<`实现

```c++
bool Integer::operator< (const Integer& rhs) {
  return i < rhs.i;
}

bool Integer::operator> (const Integer& rhs) {
  return rhs < *this;
}

bool Integer::operator<= (const Integer& rhs) {
  return !(rhs < *this);
}

bool Integer::operator>= (const Integer& rhs) {
  return !(*this < rhs);
}
```



## 4 重载流插入运算符`<<`和流提取运算符`>>`

C++的流插入运算符“<<”(inserter)和流提取运算符“>>”(extractor)是C++在类库中提供的，所有C++编译系统都在类库中提供输入流类istream和输出流类ostream。cin和cout分别是istream类和ostream类的对象。在类库提供的头文件中已经对“<<”和“>>”进行了重载，使之作为流插入运算符和流提取运算符，能用来输出和输入**C++标准类型**的数据。

用户自己定义的类型的数据，是不能直接用“<<”和“>>”来输出和输入的。如果想用它们输出和输入自己声明的类型的数据，必须对它们重载。

### 4.1 重载`>>`

```c++
istream& operator>>(istream& is, T& obj) {
       // specific code to read obj
      return is;
}
```

- 必须是全局函数（声明为友元函数）
- 返回值和参数都不是const，因为要修改`is`和`obj`

- Return an `istream&` for chaining 

  ```c++
  cin >> a >> b >> c;
  ((cin >> a) >> b) >> c;
  ```



### 4.2 重载`<<`

```c++
ostream& operator<<(ostream& os, const T& obj) {
       // specific code to write obj
      return os;
}
```

- 必须是全局函数（声明为友元函数）
- `ostream&`不是const，因为要修改`os`，但是obj一般是const

- Return an `ostream&` for chaining 

  ```c++
  cout << a << b << c;
  ((cout << a) << b) << c;
  ```



#### ostream manipulator

```c++
ostream& tab ( ostream& out ) {
         return out << '\t';
}
cout << "Hello" << tab << "World!" << endl;
```



#### 重载`<<`的例子：

```c++
#include <iostream>
using namespace std;
class Complex
{
   public:
   Complex( ){real=0;imag=0;}
   Complex(double r,double i){real=r;imag=i;}
   Complex operator + (Complex &c2);  //运算符“+”重载为成员函数
   friend ostream& operator << (ostream&,Complex&);  //运算符“<<”重载为友元函数
   private:
   double real;
   double imag;
};

Complex Complex::operator + (Complex &c2)//定义运算符“+”重载函数
{
   return Complex(real+c2.real,imag+c2.imag);
}
ostream& operator << (ostream& output,Complex& c) //定义运算符“<<”重载函数
{
   output<<"("<<c.real<<"+"<<c.imag<<"i)"<<endl;
   return output;
}

int main( )
{
   Complex c1(2,4),c2(6,10),c3;
   c3=c1+c2;
   cout<<c3;	//operator<<(cout, c3)
   return 0;
}
```



## 5 赋值运算符 Operator=

### 5.1 Default Opearator=

- The compiler will automatically create a **type::operator=(type)**  (memberwise assignment) if you don’t make one.
  - 如果成员变量没有指针，不需要重载赋值运算符和定义拷贝构造函数，使用默认提供的即可。
  - 如果成员变量有指针，则需要重载赋值运算符和拷贝构造函数

- **To prevent assignment, explicitly declare operator= as private**

### 5.2 函数模版

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2022-05-06 at 12.28.18.png" alt="Screen Shot 2022-05-06 at 12.28.18" style="zoom:50%;" />

```c++
Array& operator=(const Array& that) {
        if (this != &that) {
            size = that.size;
            delete [] data; // 一定要释放原来的空间！
            data = new int[size];
            for (int i = 0; i < size; i++) {
                data[i] = that.data[i];
            }
        }
        return *this;
    }
```



## 6 Type Conversion

### 6.1 C++中的类型转换

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2022-05-06 at 12.33.31.png" alt="Screen Shot 2022-05-06 at 12.33.31" style="zoom:50%;" />



### 6.2 隐式类型转换(Single Argument Constructor)

```c++
class PathName {
   string name;
public:
// or could be multi-argument with defaults 
  PathName(const string&);
	~ PathName();
};
...
string abc("abc");
PathName xyz(abc); // OK!
xyz = abc; // OK, 首先创建临时对象，abc => PathName，再将临时对象用默认赋值运算符复制给xyz
```



#### 阻止隐式类型转换

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2022-05-06 at 12.36.37.png" alt="Screen Shot 2022-05-06 at 12.36.37" style="zoom:50%;" />



### 6.3 显式类型转换 `X::operator T ()`

- Operator name is any type descriptor

- No explicit arguments

- **No return type, but need to return value!**

- Compiler will use it as a type conversion from X ⇒ *T*

```c++
class Rational {
public:
...
   operator double() const;  // Rational to double
}
Rational::operator double() const { return numerator_/(double)denominator_; }

Rational r(1,3); double d = 1.3 * r; // r=>double
```



Use explicit conversion functions. For example, in class Rational instead of the conversion operator, declare a member function:

```c++
double toDouble() const;
```



### 6.4 Overloading and Type Conversion

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2022-05-06 at 12.41.02.png" alt="Screen Shot 2022-05-06 at 12.41.02" style="zoom:50%;" />

