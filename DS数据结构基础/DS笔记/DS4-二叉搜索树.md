# DS4 二叉树的应用

[TOC]

## 4.1 二叉搜索树

> 思考：
>
> 树的遍历本质是二维变一维
>
> 而二叉搜索树可能是一维变二维？



### 4.1.1 定义

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-11 at 16.35.15.png" alt="Screen Shot 2021-08-11 at 16.35.15" style="zoom:50%;" />



### 4.1.2 操作

#### (1) Find, FindMin/Max

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-11 at 16.36.00.png" alt="Screen Shot 2021-08-11 at 16.36.00" style="zoom:50%;" />



<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-11 at 16.36.55.png" alt="Screen Shot 2021-08-11 at 16.36.55" style="zoom:50%;" />

> $T(N)=S(N)=O(d)$, d为树的高度
>
> 每一次递归都向下访问一层，新建一个函数栈空间

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-11 at 16.37.10.png" alt="Screen Shot 2021-08-11 at 16.37.10" style="zoom:50%;" />

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-11 at 16.38.16.png" alt="Screen Shot 2021-08-11 at 16.38.16" style="zoom:50%;" />



#### (2) Insert

> 插入的新元素都在树的最底层
>
> 要体会Insert和Find的相同和差异
>
> 相同：
>
> - Insert实质上是在找新结点的父结点
>
> 不同：
>
> - Insert有赋值语句，`T->right = Insert(X,T->right)`，Find没有
> - 当T为空时，Insert需要申请新的空间放结点
>
> Delete和Find
>
> - Delete首先要找到要删的结点
> - 找到之后再按$n_2$ $n_0/n_1$ 分开处理

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-11 at 16.47.47.png" alt="Screen Shot 2021-08-11 at 16.47.47" style="zoom:50%;" />



<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-11 at 16.48.09.png" alt="Screen Shot 2021-08-11 at 16.48.09" style="zoom:50%;" />



#### (3) Delete

（1）删除叶结点

（2）删除$n_1$：将父结点的指针指向被删除结点的孩子结点

（3）删除有两个孩子的结点：用右子树的最小值或者左子树的最大值替代被删除结点

```c
BinTree Delete(ElementType X,BinTree BST){
	if(!BST){
		printf("要删除的元素未找到");
	}else if(X<BST->Data){
		BST->Left=Delete(X,BST->Left);
	}else if(X>BST->Data){
		BST->Right=Delete(X,BST->Right);
	}else{
		if(BST->Left && BST->Right){	//被删除结点有两个孩子 
			Tmp=FindMin(BST->Right);
			BST->Data=Tmp->Data;
			**BST->Right**=Delete(BST->Data,BST->Right);
		}else{	//被删除结点有一个或者没有孩子
			Tmp=BST;
			if(!BST->Left){
				BST=BST->Right;
			}else if(!BST->Right){
				BST=BST->Left;
			}
			free(Tmp);
		} 
	}
	**return BST;**
}
```

> 细节：
>
> - 先找到要删除的结点
> - 注意上面**里面的代码



#### ==lazy deletion==

##### ==[Example] 给定查找序列，判别是否合理？==

> 讨论4.1 搜索树比较序列的判别
>
> 如果有人跟你说，在某棵搜索树上找63的过程是：先比较根39，然后比较根的右儿子101，接着比较101的左儿子25，再比较25的右儿子63，这样就找到了。
>
> 也就是说，他在搜索树查找时的比较序列是：39，101，25，63。问：这样的查找序列可能吗？你否能设计一个算法或者程序，判别给定的查找序列是否合理？



1. 算法思想1：合理序列所形成的二叉搜索树必定只有一条路径（不存在度为2的节点）。

2. 1. 用给定序列创建一个二叉搜索树。

   2. 判断树中是否存在有两个孩子的节点（即度为2的节点），如有，则序列不合理；否则认为序列合理。

      

3. 算法思想2：合理序列需满足对于任意一个数字An，如果后一个数An+1大于（或小于）An，则后续所有数都要大于（或小于）An，否则不合理。*区间套的嵌套性*

4. 1. 从头遍历整个序列，设初始min和max为极端小值和极端大值，按序对每一个数字进行如下判断：

   2. 1. 如果该值大于max或者小于min，则序列不合理。
      2. 否则，把该值与上一个数作比较，若该值大于上一个数，则表示后续所有数都要大于上一个数，即把**min更新为min和上一个数的较大值；否则，把max更新为max和上一个数的较小值。**

   3. 顺利遍历完整个序列，则说明该序列合理。



### Quizzes

For a binary search tree, in which order of traversal that we can obtain a non-decreasing sequence? 

> In-Order



## 4.2 平衡二叉树(AVL)

> 平衡二叉树是查找速度最快的二叉搜索树

### 4.2.1 AVL, BF, O(logN)

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-11 at 17.17.30.png" alt="Screen Shot 2021-08-11 at 17.17.30" style="zoom:50%;" />

```c
#define ElementType int;
typedef struct AVLNode *Position;
typedef Position AVLTree;
struct AVLNode{
	ElementType Data;
	AVLTree Left,Right;
	int Height;
};
```



<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-11 at 17.21.46.png" alt="Screen Shot 2021-08-11 at 17.21.46" style="zoom:50%;" />



<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-11 at 17.22.14.png" alt="Screen Shot 2021-08-11 at 17.22.14" style="zoom:50%;" />





### 4.2.2 四种调整方式

> RR, LL, RL, LR



#### (1) RR

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-14 at 19.00.12.png" alt="Screen Shot 2021-08-14 at 19.00.12" style="zoom:50%;" />



```c
//右单旋, RR
AVLTree SingleRightRotation(AVLTree A){
	//A必须有一个左结点B，A和B做右单旋，更新AB的树高，返回B 
	AVLTree B=A->Right;
	B->Left=A;
  A->Right = B->Left;
	A->Height=Max(GetTreeHeight(A->Left),GetTreeHeight(A->Right))+1;
	B->Height=Max(GetTreeHeight(B->Left),GetTreeHeight(B->Right))+1;
	return B;//平衡树的根结点更新成 B 
}

```



#### (2) LL

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-14 at 19.02.03.png" alt="Screen Shot 2021-08-14 at 19.02.03" style="zoom:50%;" />



```c
//左单旋, LL
AVLTree SingleLeftRotation(AVLTree A){
	//A必须有一个右结点B，A和B做左单旋，更新AB的树高，返回B 
	AVLTree B=A->Left;
	B->Right=A;
  //这里有问题！！B的右子树要挂到A左子树位置
  A->Left = B->Right;
	A->Height=Max(GetTreeHeight(A->Left),GetTreeHeight(A->Right))+1;
	B->Height=Max(GetTreeHeight(B->Left),GetTreeHeight(B->Right))+1;
	return B;//平衡树的根结点更新成 B 
}

```



#### (3) LR

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-14 at 19.04.32.png" alt="Screen Shot 2021-08-14 at 19.04.32" style="zoom:50%;" />



```c
//左右双旋, LR
AVLTree SingleLeftRightRotation(AVLTree A){
	/*	A必须有一个左子结点B，B必须有一个右子结点C
		A和B做右单旋，A和C做左单旋 
	*/ 
	A->Left=SingleRightRotation(A->Left);
	return SingleLeftRotation(A);
}

```



#### (4) RL

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-14 at 19.05.40.png" alt="Screen Shot 2021-08-14 at 19.05.40" style="zoom:50%;" />



```c
//右左双旋, RL
AVLTree SingleRightLeftRotation(AVLTree A){
	/*	A必须有一个右子结点B，B必须有一个左子结点C
		A和B做左单旋，A和C做右单旋 
	*/ 
	A->Right=SingleLeftRotation(A->Right);
	return SingleRightRotation(A);
}
```



<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-08-14 at 19.09.57.png" alt="Screen Shot 2021-08-14 at 19.09.57" style="zoom:50%;" />



### 4.2.3 插入

```c
/*
错误集锦：
1. 空树高-1，只有根节点树高0，树高为logN, N为结点数
2. LL旋转和RR旋转忘记调整子树位置
3. 段错误原因很奇怪
    不知道什么原因....
*/
#include <stdio.h>
#include <stdlib.h>

typedef struct AVLNode* Position;
typedef Position AVLTree;
struct AVLNode {
    int data;
    AVLTree left;
    AVLTree right;
    int height;
};
int Max(int a,int b);
int GetTreeHeight(AVLTree T);
AVLTree LL(AVLTree T);
AVLTree RR(AVLTree T);
AVLTree LR(AVLTree T);
AVLTree RL(AVLTree T);

AVLTree Insert(AVLTree AVL, int X);

int main() {
    int n;
    scanf("%d",&n);
    AVLTree Root = NULL;
    for (int i=0;i<n;i++) {
        int val;
        scanf("%d",&val);
        Root = Insert(Root, val);
    }
    printf("%d",Root->data);
    return 0;
}
int Max(int a,int b)
{
    return a > b ? a : b;
}
int GetTreeHeight(AVLTree T) 
{
    return T == NULL ? -1 : T->height;
}
AVLTree LL(AVLTree T) 
{
    AVLTree B = T->left;
    T->left = B->right;
    B->right = T;
    T->height = Max(GetTreeHeight(T->left), GetTreeHeight(T->right)) + 1;
    B->height = Max(GetTreeHeight(B->left), GetTreeHeight(B->right)) + 1;
    return B;
}

AVLTree RR(AVLTree T)
{
    AVLTree B = T->right;
    T->right = B->left;
    B->left = T;
    T->height = Max(GetTreeHeight(T->left), GetTreeHeight(T->right)) + 1;
    B->height = Max(GetTreeHeight(B->left), GetTreeHeight(B->right)) + 1;
    return B;
}
AVLTree LR(AVLTree T)
{
    T->left = RR(T->left);  
    return LL(T);
}
AVLTree RL(AVLTree T)
{
    T->right = LL(T->right);
    return RR(T);
}

AVLTree Insert(AVLTree AVL, int X) 
{
    if (!AVL) {
        AVL = (AVLTree)malloc(sizeof(struct AVLNode));
        AVL->data = X;
        AVL->right = NULL;
        AVL->left = NULL;
        AVL->height = 0;
    }
    else if (X < AVL->data) {
        AVL->left = Insert(AVL->left, X);
        if (GetTreeHeight(AVL->left) - GetTreeHeight(AVL->right) == 2) {
            if (X < AVL->left->data) AVL = LL(AVL);
            else /*if (X > AVL->left->data)*/ AVL = LR(AVL);
        }
    }
    else if (X > AVL->data)
    {
        AVL->right = Insert(AVL->right, X);
        if (GetTreeHeight(AVL->right) - GetTreeHeight(AVL->left) == 2) {
            if (X < AVL->right->data) AVL = RL(AVL);
            else /*if (X > AVL->right->data)*/ AVL = RR(AVL);
        }
    }
    AVL->height = Max(GetTreeHeight(AVL->left), GetTreeHeight(AVL->right)) + 1;
    return AVL;
}
```



