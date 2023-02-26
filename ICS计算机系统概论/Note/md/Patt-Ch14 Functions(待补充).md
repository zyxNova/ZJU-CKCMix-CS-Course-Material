# Patt-Ch14 Functions

[TOC]



## 1 Run-Time Stack

### 1.1 Activation Record

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-07-26 at 09.15.11.png" alt="Screen Shot 2021-07-26 at 09.15.11" style="zoom:50%;" />

#### (1) Arguments

- Pushed by **caller**
- 倒着存，如上图，先存b再存a



#### (2) Bookkeeping

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-07-26 at 09.23.33.png" alt="Screen Shot 2021-07-26 at 09.23.33" style="zoom:50%;" />

#### (3) Frame Pointer and Local Variables

Frame pointer (R5) points to the **beginning** of a region of activation record that stores **local variables** for the current function



### 1.2 Run-Time Stack

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-07-26 at 09.27.47.png" alt="Screen Shot 2021-07-26 at 09.27.47" style="zoom:50%;" />

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-07-26 at 09.30.15.png" alt="Screen Shot 2021-07-26 at 09.30.15" style="zoom:50%;" />



### 1.3 Example

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-07-26 at 09.30.51.png" alt="Screen Shot 2021-07-26 at 09.30.51" style="zoom:50%;" />



补充新ppt上的形象图片



<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-07-26 at 09.41.29.png" alt="Screen Shot 2021-07-26 at 09.41.29" style="zoom:50%;" />



<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-07-26 at 09.43.05.png" style="zoom:50%;" />

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-07-26 at 09.49.45.png" alt="Screen Shot 2021-07-26 at 09.49.45" style="zoom:50%;" />



<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-07-26 at 09.52.14.png" alt="Screen Shot 2021-07-26 at 09.52.14" style="zoom:50%;" />

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-07-26 at 09.57.47.png" alt="Screen Shot 2021-07-26 at 09.57.47" style="zoom:50%;" />



## 2 Pointer

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-07-26 at 11.02.01.png" alt="Screen Shot 2021-07-26 at 11.02.01" style="zoom:50%;" />

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-07-26 at 11.04.32.png" alt="Screen Shot 2021-07-26 at 11.04.32" style="zoom:50%;" />



<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-07-26 at 11.12.11.png" alt="Screen Shot 2021-07-26 at 11.12.11" style="zoom:50%;" />





## Array

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-07-26 at 11.22.25.png" alt="Screen Shot 2021-07-26 at 11.22.25" style="zoom:50%;" />

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-07-26 at 11.25.21.png" alt="Screen Shot 2021-07-26 at 11.25.21" style="zoom:50%;" />

