# Exception in C++

[TOC]

## **1 Why and When to use exceptions?**

分离了业务逻辑(Business Logic)和异常处理(Exception Handler)

```c++
try {
open the file;
determine its size;
allocate that much memory; read the file into memory; close the file;
} catch ( fileOpenFailed ) { 
  doSomething;
} catch ( sizeDeterminationFailed ) { 
  doSomething;
} catch ( memoryAllocationFailed ) { 
  doSomething;
} catch ( readFailed ) { 
  doSomething;
} catch ( fileCloseFailed ) {
  doSomething;
}
```

- try中应该放连续串行执行的句子。



Many times, you don't know what should be done.If you do *anything* you’ll be wrong 

Solution: *Make your caller (or its caller ...) responsible*



## **2 `throw`: Raise the exception**

### Propagation of Throw

- Control propagates back to *first handler* for that exception

  - Propagation follows the **call** chain
  - 直到回到try block中，而且有catch语句可以匹配throw的对象

  <img src="/Users/particle/Library/Application Support/typora-user-images/image-20220521163936659.png" alt="image-20220521163936659" style="zoom:50%;" />

- Objects on **stack** are properly destroyed(函数的本地变量会被正确地调用析构函数)



### `throw exp;` 

> `throw (exp);`是一样的

```c++
template <class T>
T& Vector<T>::operator[](int indx) {
  if (indx < 0 || indx >= m_size) {
  // throw is a keyword
  // exception is raised at this point
  throw <<something>>; 
  }
  return m_elements[indx];
}
```

- throw **anything**: 可以是int, float, 对象, 对象的指针/引用
  - 最常见的是定义异常类，然后throw异常类的对象


#### What do you throw? 异常类

```c++
// What do you have? Data!
// Define a class to represent the error
class VectorIndexError {
public:
  VectorIndexError(int v) : m_badValue(v) { }
  ~VectorIndexError() { } 
  void diagnostic() {
  	cerr << "index " << m_ badValue << "out of range!"; 
  }
private:
  int m_badValue;
};
```



```c++
template <class T>
T& Vector<T>::operator[](int indx) {
if (indx < 0 || indx >= m_size) { 
  // VectorIndexError e(indx); 
  // throw e;
	throw VectorIndexError(indx);
}
  return m_elements[indx];
}
```

异常类可以继承：

```c++
class MathErr { ...
  virtual void diagnostic();
};
class OverflowErr : public MathErr { ... } 
class UnderflowErr : public MathErr { ... }
class ZeroDivideErr : public MathErr { ... }
```



C++的标准库中的异常类及其子类定义在`<exception>`库当中

- what方法给出了产生异常的原因，是异常类之间都有的公共方法，已经被所有的子异常类重载

<img src="/Users/particle/Library/Application Support/typora-user-images/image-20220521165130257.png" alt="image-20220521165130257" style="zoom:50%;" />

### `throw;`

- **reraises** the exception being handled 
- valid **only within a handler**



## **3 `try` and `catch`: Handle Exception**

### `try`

- Establishes any number of handlers
- Not needed if you don’t use *any* handlers
- Shows where you expect to handle exceptions

### `catch`

Select exception by type

- Can re-raise exceptions

- Two forms
  - Take a single argument (like a formal parameter)
  - Catch anything

```c++
catch (SomeType v) { 
  // 从上往下依次比对catch的对象，一旦找到第一个匹配对象，后续的catch都不看了
}

catch (...) { // 万能处理器
}
```

匹配规则：

- Check for exact match

- Apply base class conversions ==子类对象/指针能被父类对象/指针抓住吗？==
  - Reference and pointer types, only
- Ellipses (...) match all



## **4 Exception Specifications and Uncaught Exceptions**

- Declare which exceptions function *might* raise

- Part of function prototypes
- **Not checked at compile time**
- At run time, if an exception not in the list propagates out, the *unexpected exception* is raised



```c++
Printer::print(Document&) throw(PrinterOffLine, BadDocument) { 
	...
}

// raises or doesn’t handle BadDocument
PrintManager::print(Document&) throw (BadDocument) { 
  ...
}

void goodguy() throw ()  {/* throws no exceptions  */}

void average() {/* may throw any exception*/}
```



### Unexpected exceptions

- Exceptions not in the exception specification are *unexpected.*
- Unexpected exceptions become a call to `std::unexpected()`.
- Offers a guarantee (and firewall) to callers.
- unexpected() behavior can be intercepted（可以被用户自定义行为覆盖）`std::set_unexpected(my_handler);`

```c++
#include <exception>
void my_handler() {
	std::cout << "unexpected exception!\n";
	exit(1); 
}
void f() throw(X, Y) {
  throw Z(); // whoops! Throwing Z
}
void main() {
  std::set_unexpected(my_handler);
  try {
		f(); 
  } catch (...) {
		std::cout << “caught it!” << endl;
	} 
}
```



## 6 Exceptions in Constructors

### 6.1 Way 1: Two stages construction

- Do normal work in ctor 

  - Initialize all member objects
  - Initialize all primitive members
  - Initialize all pointers to NULL

  - NEVER request any resource 
    - File
    - Network connection 
    - Memory

- Do addition initialization work in Init()



### 6.2 Way 2

如果对象是从heap中分配的（也即使用new操作符），可以在构造函数中用如下形式throw exp:

```c++
A() {
	try {}
	catch(…) {
	//…
	delete this;
	throw exp;
	}
}
```



## 7 Exception in Deconstructors

Destructors are called when:

- Normal call: object exits from scope

- During exceptions: stack unwinding invokes dtors on objects as scope is exited.

**What happens if an exception is thrown in a destructor?**

- Throwing an exception in a destructor that is itself being called as the result of an exception will invoke `std::terminate()`.

- Allowing exceptions to escape from destructors should be avoided.



## 8 Catch Exceptions by Reference

Throwing/catching by value involves slicing:

```c++
struct X {};
struct Y : public X {};
try {
  throw Y();
} catch(X x) {
  // was it X or Y?
}
```



Throwing/catching by pointer introduces coupling between normal and handler code:

```c++
try {
  throw new Y();
} catch(Y* p) {
// whoops, forgot to delete..
}
```



Catch exceptions by reference:

```c++
struct B {
	virtual void print() { /* ... */ }
};
struct D : public B { /* ... */ };
try {
	throw D(“D error”);
}
catch(B& b) {
	b.print() // print D’s error. }
```



### Exception Hierarchies

```c++
class B {};
class D1 : public B {}; 
class D2 : public B {}; ...
try {
	... throw D1(); 
}
catch(D2& t) { /* catch specific class here */ } 
catch(B& t) { /* anything else here. */ }
```



## 9 Unexpected and Uncaught exceptions

### Uncaught exceptions

- If an exception is thrown by not caught `std::terminate()` will be called.
- terminate() can also be intercepted.
- 如果在函数中进行异常处理并且触发了terminate，那么终止的是**当前函数**

```c++
void my_terminate() { /* ... */ } ...
set_terminate(my_terminate);
```

