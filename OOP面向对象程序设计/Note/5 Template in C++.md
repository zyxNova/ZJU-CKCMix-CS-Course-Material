# Template in C++

[TOC]

## 0 Why use Template?

Reuse source code

- generic programming

- use types as parameters in class or function definitions

## 1 Function Template 函数模板

### 1.1 函数模板的声明

```c++
template <class T> 	
void swap(T& x, T& y) {
	T temp = x; x = y; y = temp;
}
```

 The ***template*** keyword introduces the template

The ***class T*** specifies a **parameterized type name** 

- ***class*** means any built-in type or user-defined type
- Inside the template, use ***T*** as a type name



也可以有两个及以上的类型参数

```c++
template <class T1, class T2>
void f(T1& a, T2& b) {}
```



可以有确定的类型（甚至是默认参数）

```c++
template <class T, double d = 1.0>
void f(T& a, double d = 1.0) {}
```



### 1.2 函数模板的实例化

> 实例化为模板函数

在调用含有模板的函数时，实例化函数模板，生成了一个新的函数，称之为模板函数

- Types are substituted into template

- New body of function or class definition is created

- Specialization
  - a version of a template for a particular argument(s)

可以显式/隐式地调用：

```c++
template <class T> 	
void swap(T& x, T& y) {
	T temp = x; x = y; y = temp;
}

int main() {
  int x = 1, y = 2;
  swap(x, y); // <=> swap<int> (x, y) 显式地声明 T = int
  double a = 1.0, b = 2.0;
  swap<double>(a, b);
}
```



模板的参数类型必须 ***exactly match***，不允许隐式类型转换

```c++
swap(int, int); // ok
swap(double, double); // ok 
swap(int, double); // error!
```



### 1.3 Overloading Rules

Template functions and regular functions coexist

- Check first for unique function match，精确匹配

- Then check for unique function template match，匹配模板
  - `template<>`是具体化的模板，在模板中优先匹配

- 最后是隐式的强制类型转换



```c++
void f(float i,float k) {}; 
template <class T>
void f(T t, T u) {}; 

f(1.0,2.0); // call f(float, float)
f(1,2); // call the template
f(1,2.0); // error!
```



## 2 Class Template 类模板

### 2.1 类模板的声明

```c++
template <class T>
class Vector {
public:
  Vector(int);
  ~Vector();
  Vector(const Vector&);
  Vector& operator=(const Vector&); 
    T& operator[](int);
private:
   T*  m_elements;
   int m_size;
};
```



### ==2.2 类模板的成员函数==

> 成员函数也是函数模板，注意书写细节
>
> 在类的声明外写成员函数的规范格式

```c++
template <class T> // 必须有这一行,考试容易考这个考点
Vector<T>::Vector(int size) : m_size(size) { // 注意是Vector<T>
	m_elements = new T[m_size]; 
}
```



### 2.3 类模板的实例化

> 类模板 -> 对象

```c++
Vector<int> v1(100);
Vector<Complex> v2(256);
```



- Templates nest — they’re just new types!

```c++
   Vector< Vector< double *> > // note space > >
```

- Type arguments can be complicated

```c++
   Vector< int (*)(Vector<double>&, int)>
```



## 3 About Template

### 3.1 Non-type parameters

```c++
template <class T, int bounds = 100> class FixedVector {
public:
	FixedVector();
	// ...
	T& operator[](int);
private:
  T elements[bounds]; // fixed size array!
};
```

- Usage

```c++
FixedVector<int, 50> v1;
FixedVector<int, 10*5> v2;
FixedVector<int> v3; // uses default
```



**Summary**

- Embedding sizes not necessarily a good idea

- Can make code faster

- Makes use more complicated
  - size argument appears everywhere!

- Can lead to (even more) code bloat



### 3.2 Template and Inheritance

- Templates can inherit from non-template classes

```c++
template <class A>
 class Derived : public Base { ...
```

- Templates can inherit from template classes

```c++
template <class A>
 class Derived : public List<A> { ...
```

- Non-template classes can inherit from templates

```c++
class SupervisorGroup : public List<Employee*> { ... // 这里要指定base class的类型参数
```



### 3.3 Put Template in `.h` File

 In general put the declaration and the **definition** for the template in the header file

- won't allocate storage for the class at that point

- compiler/linker has mechanism for removing multiple definitions

> 必须把定义也放在头文件里！！和inline函数一样，模板的定义即声明



### ==3.4 Static Member in Class Template==

一个普通类的静态成员变量使用如下：

```c++
class Obj{
public:
    // 声明类静态成员
    static int m_a;
};

// 初始化类静态成员（通过范围解析符::)
int Obj::m_a = 0;

int main(){
    // 通过对象访问静态属性
    Obj o;
    o.m_a = 10;
    cout << o.m_a << endl;

    // 通过类访问静态属性
    cout << Obj::m_a <<endl;
}
```



类模板要声明和定义在头文件中，类的静态成员变量的声明和初始化也要放在头文件中。而且在初始化时，需要使用`template <class T>`等关键字。

```c++
template<typename T>
class Obj{
public:
    static T m_t;
};

template<typename T>
T Obj<T>::m_t = 0;		// 类模板中的静态成员变量。对于每一种类都有一个共享的静态成员变量，不同类有不同的静态成员变量
```



### ==3.5 Friend Function and Class Template==

#### 3.5.1 三种形式的友元函数

**（1）普通友元：**

```c++
template<class T>
class A{
  friend void fun();
};
```

fun中没有涉及类型参数T。此例中fun可访问A任意类实例中的私有和保护成员



**（2）一般模板友元关系：**

```c++
template<class type>
class A{
 	template<class T>
  friend void fun(T u);
};
```

这时友元使用**与类不同的模板形参**，T可以是任意合法标志符，友元函数可以访问A类的任何类实例的数据，即不论A的形参是int，double或其他。



**（3）特定的模板友元关系：**

```c++
template<class T> void fun(T u);//对于特定的模板友元关系，这里的声明是必须的

template<class T>
class A{
  friend void fun<T>(T u);//这里也可以是friend void fun<char>(char u);
};
```

此时fun只有访问类中特定实例的数据。换句话说，此时具有相同模板实参的fun函数与A类才是友元关系。即假如调用fun时其模板实参为int，则它只具有`A<int>`的访问权限。



#### 3.5.2 三种定义友元函数的方法

**Way 1: 封闭型**

> 适用于简短的内联函数

```c++
template< typename T >
class MyClass {
    friend void function( MyClass< T > &arg )
    {
        //要点：友元函数定义在模板体内
     }
};　　
```



**Way 2: 二重模板**

> 如果希望使用函数与模板特化的类型相独立，则使用方法2（二重模板）

```c++
template< typename T >
class MyClass
{
    template< typename C >
    friend void function( MyClass< C > &arg );
 };

template< typename C >
void function( MyClass< C > &arg )
{
    /...
 }　　
```



**Way 3:**

> 如果希望使用函数与模板特化的类型相对应，则使用方法3（模板显式声明）

```c++
template < typename T >
class A {
    friend ostream &operator<< < T >( ostream &, const A< T > & );
 };

template < typename T > //要点：显式地在重载的运算符或者函数后面加上模板声明<T>，告诉编译器友元函数是一个类型一致的模板。
ostream &operator<< ( ostream &output, const A< T > &a ) {
    output << "重载成功" << endl;
    return output;
 }
```

