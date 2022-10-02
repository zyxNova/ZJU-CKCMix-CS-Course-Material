# Smart Pointer

[TOC]



## 1 Reference Counting

### 引用计数的基本思想

- A reference count is a count of the number of times an object is shared
  - When the reference count of an object = 0 (cannot access to this object from outer), delete the space of this object from heap automatically.（自动回收垃圾）

- Pointer manipulations have to maintain the count

<img src="/Users/particle/Library/Application Support/typora-user-images/image-20220527140721699.png" alt="image-20220527140721699" style="zoom:50%;" />

### 引用计数的缺陷：循环引用

设想堆中有两块空间a和b，a指向b，b指向a，则a和b的引用计数都为1。但外界没有其他指针指向a或b，则a和b成为一组无法被外界访问的垃圾孤岛，无法被自动回收。



### 引用计数的例子

<img src="/Users/particle/Library/Application Support/typora-user-images/image-20220527141029665.png" alt="image-20220527141029665" style="zoom:50%;" />



> 这里是浅拷贝，也即`abc`和`def`指向同一块内存

<img src="/Users/particle/Library/Application Support/typora-user-images/image-20220527141048445.png" alt="image-20220527141048445" style="zoom:50%;" />







<img src="/Users/particle/Library/Application Support/typora-user-images/image-20220527141213446.png" alt="image-20220527141213446" style="zoom:50%;" />



## 2 Overview: 4 Classes

<img src="/Users/particle/Library/Application Support/typora-user-images/image-20220527141331734.png" alt="image-20220527141331734" style="zoom:50%;" />





### `class UCObject`

引用计数器

```c++
class UCObject {
public:
    UCObject() : m_refCount(0) { }
    virtual ~UCObject() { assert(m_refCount == 0);}; 
    UCObject(const UCObject&) : m_refCount(0) { } // 为了配合StringRep的拷贝构造（深拷贝）
    void incr() { m_refCount++; }
    void decr() {
        m_refCount -= 1;
        if (m_refCount == 0) {
            delete this;
        }   
    }
    int references() { return m_refCount; }
private:
    int m_refCount;
};
```



### `class StringRep: public UCOject`

继承自`UCObject`，包含引用计数器和字符串data（以`char*`形式）两部分

`StringRep`是存放字符串的实体对象，其拷贝构造函数应为对象的深拷贝

```c++
class StringRep : public UCObject {
public:
    StringRep(const char * s) {
        if (s) {
            int len = strlen(s) + 1;
            m_pChars = new char[len];
            strcpy(m_pChars, s);
        }
        else {
            m_pChars = new char[1];
            *m_pChars = '\0';
        }
    }
    ~StringRep() {
        delete [] m_pChars;
    }
    // 深度拷贝
    StringRep(const StringRep& s) {
        int len = s.length() + 1;
        m_pChars = new char[len];
        strcpy(m_pChars, s.m_pChars);
    }
    int length() const{ return strlen(m_pChars); } 
    int equal(const StringRep& s) const {
        return (strcmp(m_pChars, s.m_pChars) == 0);
    }
    const char * getStrAddr() const {
        return m_pChars;
    }
private:
    char *m_pChars;
    // reference semantics -- no assignment op!
    // 不允许两个对象之间的赋值
    void operator=(const StringRep&) { } 
};
```



### `template<class T> class UCPointer`

类模板，成员变量是模板的指针

模板类的类型必须是`UCObject`的子类（即必须含有引用计数器）

```c++
template <class T>
class UCPointer {
private:
    T* m_pObj; //UCP的成员变量即一个含有引用计数的指针（UCO的子类，包含UCO的引用计数变量和实际data)
    void increment() { 
        if (m_pObj) m_pObj->incr(); //m_pObj有incr()和decr()方法，说明m_pObj必须是UCO或UCO的继承子类
    }
    void decrement() { 
        if (m_pObj) m_pObj->decr();
    }
public:
    UCPointer(T* r = 0): m_pObj(r) {
        increment(); //少了这句话
    }
    ~UCPointer() { decrement(); }; 
    UCPointer(const UCPointer<T> & p) {
        m_pObj = p.m_pObj;
        increment();
    }
    UCPointer& operator=(const UCPointer<T> &p) {
        if (m_pObj != p.m_pObj) {
            decrement();
            m_pObj = p.m_pObj;
            increment();
        }
        return *this;
    }
    T* operator->() const { return m_pObj;} // UCP->f() 重载为 m_pObj->f()
    T& operator*() const { return *m_pObj; }
};
```



### `class String`

对外的接口类，成员变量是`UCPointer<StringRep>`，即`StringRep`类对象的UCP

```c++
class String
{
public:
    String(const char * s);
    ~String() {}
    String(const String &s) :m_rep(s.m_rep){}
    String &operator=(const String &s);
    int operator==(const String &s) const;
    String operator+(const String &s) const;
    int length() const {
        return m_rep->length();
    }
    const char *getRaw() const {
        return m_rep->getStrAddr();
    }
    int refCount() const {
        return m_rep->references();
    }
private:
    //  define your own private members
    UCPointer<StringRep> m_rep;
};
```



<img src="/Users/particle/Library/Application Support/typora-user-images/image-20220527163255348.png" alt="image-20220527163255348" style="zoom:50%;" />





