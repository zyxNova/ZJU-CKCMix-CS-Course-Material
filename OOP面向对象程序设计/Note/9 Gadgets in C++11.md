# Gadgets in C++11

## 1 Initialization 

### C++98中的初始化方法

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2022-05-06 at 12.43.57.png" alt="Screen Shot 2022-05-06 at 12.43.57" style="zoom:50%;" />

### C++11: 万物皆可大括号

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2022-05-06 at 12.44.14.png" alt="Screen Shot 2022-05-06 at 12.44.14" style="zoom:50%;" />

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2022-05-06 at 12.44.32.png" alt="Screen Shot 2022-05-06 at 12.44.32" style="zoom:50%;" />



## 2 Type of Function Parameters and Return Value

> 与C++11无关

### 2.1 3 Way in

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2022-05-06 at 12.46.17.png" alt="Screen Shot 2022-05-06 at 12.46.17" style="zoom:50%;" />

### 2.2 3 Way out

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2022-05-06 at 12.46.51.png" alt="Screen Shot 2022-05-06 at 12.46.51" style="zoom:50%;" />

### 2.3 Tips

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2022-05-06 at 12.47.10.png" alt="Screen Shot 2022-05-06 at 12.47.10" style="zoom:50%;" />





## 3 右值引用和移动构造函数

### 3.1 右值引用

```c++
int x=20; // 左值
int&& rx = x * 2; // x*2的结果是一个右值，rx延⻓其生命周期
int y = rx + 2; // y获得计算结果42
rx = 100; 			// 一旦你初始化一个右值引用变量，该变量就成为了一个左值，可以被赋值
int&& rrx1 = x; // 非法:右值引用无法被左值初始化
const int&& rrx2 = x; // 非法:右值引用无法被左值初始化
```

### 3.2 右值参数

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2022-05-06 at 12.51.30.png" alt="Screen Shot 2022-05-06 at 12.51.30" style="zoom:50%;" />

```c++
fun(rx); //输出l-value
```



<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2022-05-06 at 12.52.16.png" alt="Screen Shot 2022-05-06 at 12.52.16" style="zoom:50%;" />



### 3.3 `std::move()`与移动构造函数

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2022-05-06 at 12.53.23.png" alt="Screen Shot 2022-05-06 at 12.53.23" style="zoom:50%;" />

我们希望将v1移动给v3，而不保留v1本身（这与拷贝构造的含义不同，拷贝构造后同时存在两个v1的副本），所以需要拷贝构造

`std::move()`的用处是将其参数转化为右值，从而调用移动构造函数

移动构造函数：

```c++
class A {
public:
  	A(const A&& that); //移动构造函数
  	A(const A& that);  //拷贝构造函数
};
```

