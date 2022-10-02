# DS3-树及其遍历

[TOC]

## **3.1 树与树的表示**

### ==3.1.1 引子（二分查找判定树）==

> 判定树, Decision Tree



<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-07 at 21.50.15.png" alt="Screen Shot 2021-08-07 at 21.50.15" style="zoom:50%;" />

<img src="/Users/particle/Desktop/大二上/数据结构基础/学长笔记/Notes-for-Data-Structure-master/picture/5-1.png" alt="5-1" style="zoom:80%;" />

> ==WHY?==判定树是完全二叉树吗？
>
> 二叉搜索树不一定是判定树？但是判定树一定是二叉搜索树？
>
> ==The correct answer is A.==

### 3.1.2 树的定义

> A tree is a collection of nodes. 
>
> - The collection can be empty; 
> - otherwise, a tree consists of 
>   - (1)  a distinguished node r, called the root; 
>   - (2) and zero or more nonempty (sub)trees, each of whose roots are connected by a directed edge from r.

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-08 at 10.02.55.png" alt="Screen Shot 2021-08-08 at 10.02.55" style="zoom:50%;" />



<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-08 at 10.04.27.png" alt="Screen Shot 2021-08-08 at 10.04.27" style="zoom:50%;" />

> 关于N-1条边：从下往上看，除了根结点，每一个结点都有一个父结点（向上的一条边）



### 3.1.3 树的术语

#### (1) 结点的称呼

- parent : 有子树的结点
- children : the roots of the subtrees of a parent
- siblings : children of the same parent

- leaf(terminal node) : a node with degree 0(no children)
- ancestors of a node : 从此结点到根结点的路径上的所有结点
- descendants of a node : 此结点的子树中的所有结点

#### (2) 度

- degree of a node : 结点的子树个数
- degree of a tree : 结点的度的最大值

#### (3) 路径、高度、深度

- path from $n_1$ to $n_k$ : a **unique** sequence of nodes $n_1,n_2,\cdots,n_k$ such that $n_i$ is the parent of $n_{i+1}$ for $1\leq i<k$ 
  - ==树是保持结点联通的边最少的方式==。任给两个结点，有且仅有一条路径（找两个结点共同的祖先）
- length of path : 路径上边的条数
- depth of $n_i$ : 从根结点到$n_i$结点的路径的长度
  - $Depth(root)=0$，有些题目里树根深度为1
  - 向上走
- height of $n_i$ : 从$n_i$结点到叶结点的最长路径的长度
  - $Height(leaf)=0$
  - 向下走
- height/depth of a tree : 根结点的高度/最深的叶结点的深度



### 3.1.4 一般树的表示

#### (1) 数组或多指针域链表？

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-08 at 10.18.39.png" alt="Screen Shot 2021-08-08 at 10.18.39" style="zoom:50%;" />

数组？x没有办法便捷索引父结点、子结点 **但是表示还是可以的！！**

n个指针域的链表？x浪费许多空间，难以插入、删除

<img src="/Users/particle/Desktop/大二上/数据结构基础/学长笔记/Notes-for-Data-Structure-master/picture/4-2.png" alt="4-2" style="zoom: 120%;" />

#### (2) 儿子-兄弟表示法

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-08 at 10.20.06.png" alt="Screen Shot 2021-08-08 at 10.20.06" style="zoom:50%;" />



树都可以用儿子-兄弟表示法统一、便捷的表示

儿子-兄弟表示法一般是不唯一的（因为FirstChild,NextSibling是可以替换的）

##### 多叉树 -> 二叉树

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-08 at 10.21.14.png" alt="Screen Shot 2021-08-08 at 10.21.14" style="zoom:50%;" />



<img src="/Users/particle/Desktop/大二上/数据结构基础/学长笔记/Notes-for-Data-Structure-master/picture/4-3.png" alt="4-3" style="zoom:150%;" />

------

## **3.2 二叉树**

### **3.2.1 二叉树的定义及性质**

#### (1) 二叉树的定义及特殊二叉树

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-08 at 10.33.03.png" alt="Screen Shot 2021-08-08 at 10.33.03" style="zoom:50%;" />



<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-08 at 10.33.25.png" alt="Screen Shot 2021-08-08 at 10.33.25" style="zoom:50%;" />

> 完全二叉树在以后的章节中会详细探讨

#### (2) 二叉树的重要性质

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-08 at 10.33.44.png" alt="Screen Shot 2021-08-08 at 10.33.44" style="zoom:50%;" />

证明上述结论，由边的角度出发。$n_0 + n_1 + n_2 - 1 = 0*n_0 + 1 * n_1 + 2 * n_2$

推广：在二叉树中，我们知道叶结点总数 n0 与有两个儿子的结点总数 n2 之间的关系是：n0=n2+1.。那么类似关系是否可以推广到m叉树中？也就是，如果在m叉树中，叶结点总数是 n0，有一个儿子的结点总数是 n1，有2个儿子的结点总数是 n2，有3个儿子的结点总数是 n3，...那么，ni之间存在什么关系？

$$
n_0 = n_2 + 2n_3 + ... + (m - 1)n_m+1
$$




> Q：有一颗二叉树，其两个儿子的结点个数为15个，一个儿子的结点个数为32个，问该二叉树的叶结点个数是多少？
>
> A：16个。两个儿子的结点个数，意思是度为2的结点有15个，即n2=15；一个儿子的结点个数，意思是度为1的结点有32个，即n1=32。由n0=n2+1知，n0=16。
>
> 
>
> Q：若有一二叉树的总结点数为98，只有一个儿子的结点数为48，则该树的叶结点数是多少？
>
> A：这样的树不存在。总结点数=n0+n1+n2=98，已知n1=48，n2=n0-1,，代入得n0=51/2，故这样的树不存在。



#### (3) 二叉树的ADT

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-08 at 10.41.06.png" alt="Screen Shot 2021-08-08 at 10.41.06" style="zoom:50%;" />



### **3.2.2 二叉树的存储结构**

#### (1) 顺序存储结构 - 完全二叉树

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-08 at 10.47.06.png" alt="Screen Shot 2021-08-08 at 10.47.06" style="zoom:50%;" />



<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-08 at 10.47.23.png" alt="Screen Shot 2021-08-08 at 10.47.23" style="zoom:50%;" />



#### (2) 链式存储结构

##### 静态链表

> *物理上用结构数组存储，逻辑上用链表*

对于每棵树，首先在一行中给出一个非负整数*N* (≤10)，即该树的结点数（此时假设结点从0到*N*−1编号）；

随后*N*行，第*i*行对应编号第*i*个结点，给出该结点中存储的1个英文大写字母、其左孩子结点的编号、右孩子结点的编号。如果孩子结点为空，则在相应位置上给出“-”。

```c
/*Input Sample*/
8
A 1 2
B 3 4
C 5 -
D - -
E 6 -
G 7 -
F - -
H - -
```

```c
struct TreeNode {
    char data;
    int left;
    int right;
} T1[MAXNUM], T2[MAXNUM];
```

```c
int BuildTree(struct TreeNode* T) {
    int n,root,i;
    scanf("%d\n",&n);
    if (n == 0) return Null;
    int *check = (int *)malloc(sizeof(int)*n);
    char cl, cr;
    for (i=0;i<n;i++) {
        scanf("%c %c %c ",&T[i].data,&cl, &cr);
        if (isdigit(cl)) {
            T[i].left = cl - '0';
            check[cl - '0'] = 1;
        }
        else T[i].left = Null;
        if (isdigit(cr)) {
            T[i].right = cr - '0';
            check[cr - '0'] = 1;
        }
        else T[i].right = Null;
        }
    for (i=0;i<n;i++) {
        if (check[i] == 0) break;//没有被提及的结点即为根结点
    }
    root = i;
    free(check);
    return root;
    }
```



##### 链表

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-08 at 10.48.58.png" alt="Screen Shot 2021-08-08 at 10.48.58" style="zoom:50%;" />





### **3.2.3 二叉树的遍历(Traversal)**

> 前序、后序遍历 对应 图的深度优先搜索 对应 stack（递归）
>
> 层序遍历 对应 广度优先搜索 对应 queue
>
> 中序遍历是二叉树所特有的
>
> O(N)

#### 3.2.3.1 遍历问题的本质

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-09 at 10.11.53.png" alt="Screen Shot 2021-08-09 at 10.11.53" style="zoom:50%;" />

**树的遍历的本质上是将二维结构变成一个一维的线性序列**。而在解决这个问题的过程中，又有一基本问题就是需要使用一种方法**把该节点的右结点和左结点保存下来**，可以使用queue或者stack保存这些数据

| 遍历类型 | 实现方式 | 本质                       | 与图搜索对应 |
| -------- | -------- | -------------------------- | ------------ |
| 前序     | 递归     | Stack                      | DFS          |
| 中序     | 递归     | Stack                      | DFS          |
| 后序     | 递归     | Stack                      | DFS          |
| 层次     | 队列     | 父结点出列，左右子结点入列 | BFS          |



#### 3.2.3.2 递归实现

##### (1) PreOrder

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-08 at 11.18.32.png" alt="Screen Shot 2021-08-08 at 11.18.32" style="zoom:50%;" />



##### (2) InOrder

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-08 at 11.19.41.png" alt="Screen Shot 2021-08-08 at 11.19.41" style="zoom:50%;" />



##### (3) PostOrder

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-08 at 11.20.06.png" alt="Screen Shot 2021-08-08 at 11.20.06" style="zoom:50%;" />



##### (4) 三者联系

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-08 at 11.20.53.png" alt="Screen Shot 2021-08-08 at 11.20.53" style="zoom:50%;" />





#### 3.2.3.2 非递归实现

##### (1) 中序

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-09 at 09.50.40.png" alt="Screen Shot 2021-08-09 at 09.50.40" style="zoom:50%;" />



##### (2) 先序

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-09 at 09.51.10.png" alt="Screen Shot 2021-08-09 at 09.51.10" style="zoom:50%;" />



##### (3) 后序

先序的访问顺序是root, left, right 假设将先序左右对调，则顺序变成root, right, left，暂定称之为“反序”。

 后序遍历的访问顺序为left, right,root ，刚好是**“反序”结果的逆向输出**。于是方法如下：


 1、反序遍历二叉树，具体方法为：将先序遍历代码中的left 和right 对调即可。

​    数据存在栈S中。


 2、在先序遍历过程中，每次Push节点后紧接着print结点。

​    对应的，在反序遍历时，将print结点改为把当前结点 PUSH到堆栈Q中。


 3、反序遍历完成后，堆栈Q的压栈顺序即为反序遍历的输出结果。

   此时再将堆栈Q中的结果pop并print，即为“反序”结果的逆向，也就是后序遍历的结果。


 缺点是堆栈Q的深度等于数的结点数，空间占用较大。

代码如下：

```c
void PostOrderTraversal( BinTree BT )
{
  BinTree T BT;
  Stack S = CreatStack( MaxSize ); /*创建并初始化堆栈S*/
  Stack Q = CreatStack( MaxSize ); /*创建并初始化堆栈Q，用于输出反向*/
  while( T || !IsEmpty(S) ){
    while(T){ /*一直向右并将沿途结点压入堆栈*/
      Push(S,T);
      Push(Q,T);/*print根结点改成将遍历到的结点压栈，用于反向*/
      T = T->Right;
    }
    if(!IsEmpty(S)){
    T = Pop(S); /*结点弹出堆栈*/
    T = T->Left; /*转向左子树*/
    }
  }
  while( !IsEmpty(Q) ){
    T = Pop(Q);
    printf(“%5d”, T->Data); /*（访问）打印结点*/
  }
}
```



==way2.==

```c
void PostOrderTraversal(BinTree BT) {
    BinTree T = BT, PrePop = NULL; //PrePop记录上一个Pop出来的结点
    Stack S = CreatStack(MaxSize);
    while (T || !IsEmpty(S)) {
        while (T) {        //一直向左将结点压入堆栈
            Push(S, T);
            T = T->Left;
        }
        //将Pop的过程改为循环
        while (!IsEmpty(S)) { //后序遍历有两种情况可以Pop该结点
            T = Pop(S);
            if (T->Right == PrePop || T->Right == NULL) {  //该结点的右结点为空或者上一次Pop的是该结点的右结点
                printf("%05d", T->Data);
                PrePop = T;
            }
            else {  //若不满足以上两种情况 说明该节点右侧节点还未被Pop
                Push(S, T);  //则将该结点重新压回堆栈
                T = T->Right;  //然后指向该结点的右节点
                break; //退出Pop循环
            }
        }
    }
}
```



#### 3.2.3.3 层序遍历

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-09 at 10.12.47.png" alt="Screen Shot 2021-08-09 at 10.12.47" style="zoom:50%;" />



> Q：如果将层序遍历中的队列改为堆栈，是否也是一种树的遍历？可以应用这种方法改造出一种前序、中序、后序的非递归遍历吗？
>
> A：可以。**树的遍历的本质上是将二维结构变成一个一维的线性序列**，而在解决这个问题的过程中，又有一基本问题就是需要使用一种方法**把该节点的右结点和左结点保存下来**，随意可以使用队列或者堆栈的存储结构保存下来这些数据，所以将层序遍历中的队列改为堆栈也是一种树的遍历。并且在前面也讲过，==队列可以运用两个堆栈模拟==，反过来也可以用两个队列模拟一个堆栈。
>
> 可以运用层序遍历的方法改造出前序，后序遍历。==中序没办法？==
>
> **将层序遍历中的队列改为堆栈，然后将进栈的为该节点右子树，然后才是左子树，所得的遍历结果即为先序遍历结果。**
>
> 将层序遍历中的队列改为堆栈，得到的是后序的“反序”遍历结果。然后再额外使用一个堆栈S2保存“反序”结果，再pop出来就是反“反序”即后序遍历结果。



### **3.2.4 遍历的应用**

#### ==(1) 线索二叉树 Threaded BT==

> N nodes, 2N pointers, N-1 edges, N+1 NULL 浪费！

Rules for inorder threaded tree

- If **Tree->Left** is null, replace it with a pointer to the inorder **predecessor(中序前驱)** of Tree.
- If **Tree->Right** is null, replace it with a pointer to the inorder **successor(中序后继)** of Tree.
- ==There must not be any loose threads.  Therefore a threaded binary tree must have a **dummy head node**，最左边的叶结点指向哨兵结点(或NULL)==

```c
typedef struct ThreadedTreeNode *PtrToThreadedNode;
typedef PtrToThreadedNode ThreadedTree;
typedef struct ThreadedTreeNode 
{
	int LeftThread;        /* if it is TRUE, then Left */
	ThreadedTree Left;     /* is a thread, not a child ptr.*/
	ElementType	Element;
	int RightThread;       /* if it is TRUE, then Right */
	ThreadedTree Right;    /* is a thread, not a child ptr.*/
}
```

<img src="/Users/particle/Desktop/大二上/数据结构基础/学长笔记/Notes-for-Data-Structure-master/picture/4-4.png" alt="4-4" style="zoom:80%;" />



$n_2$结点的前驱后继算法（中序）

中序前驱：左子树的最右边的叶结点

中序后继：右子树的最左边的叶结点



#### (2) 中序+某种遍历序列确定二叉树

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-09 at 10.32.35.png" alt="Screen Shot 2021-08-09 at 10.32.35" style="zoom:50%;" />

没有中序则无法确定左右



<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-09 at 10.33.10.png" alt="Screen Shot 2021-08-09 at 10.33.10" style="zoom:50%;" />

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-09 at 10.33.34.png" alt="Screen Shot 2021-08-09 at 10.33.34" style="zoom:50%;" />

##### [Example]前序中序定后序

> 前中->后不需要建树

> 03-树3 Tree Traversals Again (25分)
> An inorder binary tree traversal can be implemented in a non-recursive way with a stack. For example, suppose that when a 6-node binary tree (with the keys numbered from 1 to 6) is traversed, the stack operations are: push(1); push(2); push(3); pop(); pop(); push(4); pop(); pop(); push(5); push(6); pop(); pop(). Then a unique binary tree (shown in Figure 1) can be generated from this sequence of operations. Your task is to give the postorder traversal sequence of this tree.
>
>
> Input Specification:
> Each input file contains one test case. For each case, the first line contains a positive integer N (≤30) which is the total number of nodes in a tree (and hence the nodes are numbered from 1 to N). Then 2N lines follow, each describes a stack operation in the format: “Push X” where X is the index of the node being pushed onto the stack; or “Pop” meaning to pop one node from the stack.
>
> Output Specification:
> For each test case, print the postorder traversal sequence of the corresponding tree in one line. A solution is guaranteed to exist. All the numbers must be separated by exactly one space, and there must be no extra space at the end of the line.
>
> Sample Input:
> 6
> Push 1
> Push 2
> Push 3
> Pop
> Pop
> Push 4
> Pop
> Pop
> Push 5
> Push 6
> Pop
> Pop
>
> Sample Output:
> 3 4 2 6 5 1

![Screen Shot 2021-08-11 at 16.23.10](/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-11 at 16.23.10.png)



```c
/*
Q: 已知二叉树的前序遍历(Push)和中序遍历(Pop)求二叉树的后序遍历
A: 类似于人脑“已知二叉树的先序和中序遍历结果如何还原二叉树“
    解决方案，递归地求解该问题。
*/
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define MAXNUM 30
int stack[MAXNUM];
int sp = -1;

int isStackFull(void);
int isStackEmpty(void);
void Push(int val);
int Pop(void);
void GetPostOrder(int *Pre, int *In, int *Post, int n);
int main() {
    int n;
    scanf("%d",&n);
    int *Pre = (int *)malloc(sizeof(int)*n);
    int *In = (int *)malloc(sizeof(int)*n);
    int *Post = (int *)malloc(sizeof(int)*n);
    int preindex = 0, inindex = 0;
    for (int i=0;i<2*n;i++) {
        char s[5];
        scanf("%s",s);
        if (strcmp(s,"Push") == 0) {
            int val;
            scanf("%d",&val);
            Push(val);
            Pre[preindex++] = val;
        }
        if (strcmp(s,"Pop") == 0) {
            In[inindex++] = Pop();
        }
    }
    GetPostOrder(Pre, In, Post, n);
    for (int i=0;i<n;i++) {
        printf("%d",Post[i]);
        if (i != n-1) printf(" ");
    }
    free(Pre);
    free(In);
    free(Post);
    return 0;
}

void GetPostOrder(int *Pre, int *In, int *Post, int n)
{
    if (n>0) {
        Post[n-1] = Pre[0];
        int i;
        for (i=0;i<n;i++) {
            if (In[i] == Pre[0]) break;
        }
        GetPostOrder(Pre+1, In, Post, i);
        GetPostOrder(Pre+i+1, In+i+1, Post+i, n-i-1);
    }
}
```

 [3-3*TreeTraversalsAgain.c](../../../../../Documents/C/DS/Mooc/3-3*TreeTraversalsAgain.c) 



##### ==[Example]给中序后序，建树==



##### ==[思考]中序+X->Y?==

中序+前序

- 后序
- 层序
- 其他（如z字）

中序+层序

- 前序/后序
- 其他（如z字）



#### (3) 输出二叉树叶结点

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-09 at 10.16.22.png" alt="Screen Shot 2021-08-09 at 10.16.22" style="zoom:50%;" />

 [3-2ListLeaves.c](../../../../../Documents/C/DS/Mooc/3-2ListLeaves.c) 

#### (4) 求二叉树的高度（递归）

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-09 at 10.21.04.png" alt="Screen Shot 2021-08-09 at 10.21.04" style="zoom:50%;" />

#### ==(5) 缩进打印二叉树==

> 前序遍历？

```c
static void  ListDir ( DirOrFile D, int Depth )
{
  if  ( D is a legitimate entry )   
  	{PrintName (D, Depth );
    if ( D is a directory )
      for (each child C of D )
        ListDir ( C, Depth + 1 );
}
 
/*Depth is an internal variable and must not be seen by the user of this routine.  One solution is to define another interface function as the following*/
void ListDirectory ( DirOrFile  D )
{
  ListDir( D, 0 );                 
}
```



#### (6) 二元运算表达式树的遍历

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-09 at 10.26.04.png" alt="Screen Shot 2021-08-09 at 10.26.04" style="zoom:50%;" />

> 关于中缀表达式：输出左子树前先输出`(`， 输出左子树完毕后输出`)`， 可避免不准

> ==给出一种表达式，可以唯一确定表达式树==



#### (7) 树的同构

<img src="/Users/particle/Desktop/大二上/数据结构基础/学长笔记/Notes-for-Data-Structure-master/picture/Screen Shot 2021-10-11 at 12.49.30.png" alt="Screen Shot 2021-10-11 at 12.49.30" style="zoom:50%;" />

**输入格式:**

输入给出2棵二叉树树的信息。对于每棵树，首先在一行中给出一个非负整数*N* (≤10)，即该树的结点数（此时假设结点从0到*N*−1编号）；随后*N*行，第*i*行对应编号第*i*个结点，给出该结点中存储的1个英文大写字母、其左孩子结点的编号、右孩子结点的编号。如果孩子结点为空，则在相应位置上给出“-”。给出的数据间用一个空格分隔。注意：题目保证每个结点中存储的字母是不同的。

**输出格式:**

如果两棵树是同构的，输出“Yes”，否则输出“No”。

**输入样例1（对应图1）：**

```in
8
A 1 2
B 3 4
C 5 -
D - -
E 6 -
G 7 -
F - -
H - -
8
G - 4
B 7 6
F - -
A 5 1
H - -
C 0 -
D - -
E 2 -
```

```c
/*
三个关键问题
1. 二叉树的表示： 静态链表，物理上用结构数组存储，逻辑上用链表
2. 建树及根节点的判别： 没有被指向的结点即为根结点
3. 树同构的比较： 递归的思想在树中非常非常重要！！！
*/

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#define Null -1
#define MAXNUM 10
struct TreeNode {
    char data;
    int left;
    int right;
} T1[MAXNUM], T2[MAXNUM];


int BuildTree(struct TreeNode*);
int Isomorphic(int R1, int R2);
int main() {
    int R1 = BuildTree(T1);
    int R2 = BuildTree(T2);
    // printf("R1, R2 = %d, %d\n",R1, R2);
    int isIsomorphic = Isomorphic(R1, R2);
    if (isIsomorphic) printf("Yes");
    else printf("No");
    return 0;
}
int BuildTree(struct TreeNode* T) {
    int n,root,i;
    scanf("%d\n",&n);
    if (n == 0) return Null;
    int *check = (int *)malloc(sizeof(int)*n);
    char cl, cr;
    for (i=0;i<n;i++) {
        scanf("%c %c %c ",&T[i].data,&cl, &cr);
        // printf("cl = %c\n",cl);
        if (isdigit(cl)) {
            T[i].left = cl - '0';
            check[cl - '0'] = 1;
        }
        else T[i].left = Null;
        if (isdigit(cr)) {
            T[i].right = cr - '0';
            check[cr - '0'] = 1;
        }
        else T[i].right = Null;
        }
    for (i=0;i<n;i++) {
        if (check[i] == 0) break;
    }
    root = i;
    free(check);
    return root;
    }

int Isomorphic(int R1, int R2) {
    if ((R1 == Null) && (R2 == Null))
    return 1;
    if ((R1 == Null) && (R2 != Null) ||
    R1 != Null && R2 == Null)
    return 0;
    if (T1[R1].data != T2[R2].data) return 0;
    if ((T1[R1].left == Null) && (T2[R2].left == Null))
        return Isomorphic(T1[R1].right, T2[R2].right);
    if ((T1[R1].left != Null) && (T2[R2].left != Null)
    && (T1[T1[R1].left].data == T2[T2[R2].left].data))
    return (Isomorphic(T1[R1].left, T2[R2].left) &&
            Isomorphic(T1[R1].right, T2[R2].right));
    else 
    return (Isomorphic(T1[R1].left, T2[R2].right) &&
            Isomorphic(T1[R1].right, T2[R2].left));
}

```

 [3-1S-isomorphicTree.c](../../../../../Documents/C/DS/Mooc/3-1S-isomorphicTree.c) 





#### ==(8) z字遍历==

