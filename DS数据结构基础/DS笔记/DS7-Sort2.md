[TOC]

## 2 改进比较排序算法

### Shellsort *希尔排序*

#### 排序思路

<img src="/Users/particle/Desktop/大二上/数据结构基础/学长笔记/Notes-for-Data-Structure-master/picture/image-20201214133747061.png" style="zoom:80%;" />

- 定义递增序列$1=h_1 < h_2 < \cdots < h_t$
- for $k = t, t - 1,\cdots, 1$，分别以$h_k$为间隔做插入排序(Insertion Sort)
- 当$k=1$插入排序结束后，排序完成



**Remark**

- $O(n^2)$下界的出现是由于每次交换相邻元素只能改变一个逆序对。那交换非相邻元素呢？所以在希尔排序中出现了gap（即递增序列），希望一次性改变多于一个逆序对。

- 而且，做第$k$次排序后，不会改变前$k-1$次排序的元素相对位置，即逆序对的数量在$t$次排序过程中是非增的。

- $h_1=1$保证最终结果的正确性（最后一轮就是插入排序本身）
- 希尔排序的算法复杂度主要取决于递增序列的取法，如果递增序列互质性增加，则交换不同元素的机会增大，效率越高
  - Shell’s Increment Sequence，$h_t=\lfloor N/2\rfloor,h_k=\lfloor h_{k+1}/2\rfloor$，$T(N) = \Theta( N^2 )$
  - Hibbard's Increment Sequence，$h_k=2^k-1$，$T(N)=\Theta( N^{3/2} )$
  - Sedgewick’s best sequence is $\{1, 5, 19, 41, 109, \cdots \}$ in which the terms are either of the form $9\times4^i – 9\times2^i + 1$ or 
    $4^i – 3\times2^i + 1$.  $T_{avg} ( N ) = O ( N^{7/6} )$ and $T_{worst}( N ) = O( N^{4/3} )$.



#### Shell’s Increment Sequence

$h_t=\lfloor N/2\rfloor,h_k=\lfloor h_{k+1}/2\rfloor$



```c
void ShellSort(int a[],int n)
{
    int i,j,incre,temp;
    for (incre = n/2;incre>0;incre/=2) {
      	/*insertion sort*/
        for (i=incre;i<n;i+=incre) {
            temp = a[i];
            for (j=i;j>=incre;j-=incre) {
                if (a[j-incre] > temp) a[j] = a[j-incre];
                else break;
            }
            a[j] = temp;
        }
    }
}
```

The worst-case running time of Shellsort, using Shell’s increments, is  $\Theta( N^2 )$.

<img src="/Users/particle/Library/Application Support/typora-user-images/Screen Shot 2021-12-13 at 08.34.37.png" alt="Screen Shot 2021-12-13 at 08.34.37" style="zoom:50%;" />

> 只有1-sort起作用，退化成插入排序
>
> 原因：Shell's Increments选择的gap有包含关系。如果这些gap是互质的，则算法效率会提升。



#### Hibbard's Increment Sequence

$$
h_k=2^k-1
$$

- $T_{avg} ( N ) = O ( N^{5/4} )$
- $T_{worst}( N ) = \Theta( N^{3/2} )$



#### Sedgewick’s best sequence

$\{1, 5, 19, 41, 109, \cdots \}$ in which the terms are either of the form $9\times4^i – 9\times2^i + 1$ or $4^i – 3\times2^i + 1$

- $T_{avg} ( N ) = O ( N^{7/6} )$
- $T_{worst}( N ) = O( N^{4/3} )$.



#### 算法性能分析

- in place,$S(n) = O(1)$
- Unstable

- Shellsort is a very simple algorithm, yet with an extremely complex analysis.  



#### 适用场景

- It is good for sorting up to moderately large input (tens of thousands，几万).



### Heapsort *堆排序*

#### 排序思路：与选择排序类比

> 选择排序：
>
> 每一轮找到最小值，放在数组第一个。共计做n轮。
>
> - 如果遍历找最小值，就是选择排序，$O(n^2)$
> - 如果用最小堆找最小值，$O(N \times logN)$
>   - 为了改进空间复杂度，用最大堆找最大值放在最后面

#### 代码实现

**Algorithm1**

```c
void Heapsort( int N ) 
{
    BuildHeap( H );
    for ( i = 0; i < N; i++ ) 
			TmpH[ i ] = DeleteMin( H );
    for ( i = 0; i < N; i++ ) 
			H[ i ] = TmpH[ i ];
}
```

- The space requirement is doubled,$S(n) = O(n)$

**Algorithm2**

```c
//Note: index of array starts with 0
//根结点为i,左儿子为2*i+1,右儿子为2*i+2
void PercDown(int a[],int p,int n)
{
    int temp = a[p];
    int child;
    for (;p*2+1<n;p = child) {
        child = p*2+1;
        if (child+1<n && a[child+1] > a[child]) child++;//建立Maxheap
        if (temp > a[child]) break;//错误原因：temp写成a[p]
        else a[p] = a[child];
    }
    a[p] = temp;
}

void HeapSort(int a[],int n) {
    int i;
    for (i=n/2-1;i>=0;i--) //注意第一个根结点是N/2-1
        PercDown(a,i,n);
    for (i=n-1;i>0;i--) {
        swap(&a[0],&a[i]);
        PercDown(a,0,i);
    }
}
```

> Note：Heapsort data从0开始编号。PercDown的索引要修改。



#### 时间和空间复杂度

$T(N) = O(NlogN)$

> 定理：The average number of comparisons used to heapsort a random permutation of N distinct items is $2N\log N-O(N\log\log N)$.

$S(N) = O(1)$, for algorithm 2



#### 与其他算法比较

**时间复杂度稳定为$O(NlogN)$**，而quicksort最坏为$O(N^2)$

Note : Although Heapsort gives **the best average time**（基于比较的排序的最优复杂度）, in practice it is **slower** than a version of Shellsort that uses Sedgewick’s increment sequence.



### Merge Sort *归并排序*

#### 排序思路

	1. 先将长度为N的无序序列分割平均分割为两段
	2. 然后分别对前半段进行归并排序、后半段进行归并排序
	3. 最后再将排序好的前半段和后半段归并

- 牺牲空间换取时间
- 分而治之-*Divide&Conquer*，核心思想就是**分解、求解、合并**

#### TopDown *自顶向下的递归*

```c
#include <stdio.h>
#include <stdlib.h>
#define SIZE 8

/*a是目标数组，b是临时数组*/
/*Version1*/
void merge(int a[], int begin, int mid, int end, int b[])
{
    /*mid是前一半的末尾，后一半的开始*/
    int i = begin, j = mid, k = begin;
    while (i < mid && j < end)
    {
        if (a[i] < a[j])
            b[k++] = a[i++];
        else
            b[k++] = a[j++];
    }
    while (i < mid)
        b[k++] = a[i++];
    while (j < end)
        b[k++] = a[j++];
    //merge完以后b要重新放回a里，否则白排了!!!
    for (int i = begin;i<end;i++) {
        a[i] = b[i];
    }

		/*可视化*/
    for (int i = 0; i < begin; i++)
        printf("    ");
    for (int i = begin; i < end; i++)
    {
        printf("%4d",b[i]);
    }
    for (int i = end; i < SIZE; i++)
        printf("    ");
    printf("\n");
}

/*begin is inclusive, end is exclusive*/
void mergeSort(int a[], int begin, int end, int b[])
{
    //base case
    if (end - begin < 2)
        return;
    int mid = (begin + end) / 2;
    mergeSort(a, begin, mid, b);
    mergeSort(a, mid, end, b);
    merge(a, begin, mid, end, b); //合二为一
}

int main()
{
    int a[SIZE], b[SIZE];
    srand(0); //seed == 0
    for (int i = 0; i < SIZE; i++)
    {
        a[i] = rand() % 150;
    }
    for (int i = 0; i < SIZE; i++)
    {
        printf("%4d", a[i]);
    }
    printf("\n");
    mergeSort(a, 0, SIZE, b);
    for (int i = 0; i < SIZE; i++)
    {
        printf("%4d", a[i]);
    }
}
```



#### BottomUp *自底向上的迭代*

- TopDown递进过程实际上是切割，没有做任何其他事情；因此可以考虑舍弃递进，直接合并

- 双重循环，外层循环控制合并次数(logN)，内层循环控制排序小单元的步长

```c
void Merge(int a[],int begin,int mid,int end) {
    int i = begin,j = mid,k = i;
    int *b = (int *)malloc(sizeof(int)*(end-begin));
    while (i<mid && j<end) {
        if (a[j] < a[i]) b[k++] = a[j++];
        else b[k++] = a[i++];
    }
    while (i<mid) b[k++] = a[i++];
    while (j<end) b[k++] = a[j++];

    for (int i=begin;i<end;i++) {
        a[i] = b[i];
    }
    for (int i = 0; i < begin; i++)
        printf("    ");
    for (int i = begin; i < end; i++)
    {
        printf("%4d",b[i]);
    }
    for (int i = end; i < MAXSIZE; i++)
        printf("    ");
    printf("\n");
}

void* MergeSort(parray *a)
{
    for (int width = 1;width < MAXSIZE;width *= 2) {
        for (int i=0;i<MAXSIZE;i = i + width*2) {
            Merge(a->pBase,i,i+width,min(i+width*2,MAXSIZE));//begin is inclusive, end is exclusive
        }
    }
}
```



#### 时间复杂度

- $O(NlogN)$ 
- 递进（分解）无循环，不消耗时间
- 合并的时候 共logN层,每一层循环遍历N次，共计N*logN

$$
T(1)=O(1)\\
T(N)=2T(\frac{N}{2})+O(N)\\
\frac{T(N)}{N}=\frac{T(\frac{N}{2})}{\frac{N}{2}}+1\\
\cdots\\
\frac{T(\frac{N}{2^{k-1}})}{\frac{N}{2^{k-1}}}=\frac{T(1)}{1}+1\\
T(N)=O(N+N\log N)
$$

#### 空间复杂度

- $O(N)$

#### 适用场景

- Mergesort requires linear extra memory, and copying an array is slow. It is hardly ever used for internal sorting, but is quite useful for external sorting.

- 与HeapSort比较，归并排序对Cache比较友好，因为移动的是相邻元素。而堆排序元素跨度较大

- 适宜并行计算

- 可以做成链表



### Quick Sort *快速排序*

#### 排序思路

- 取出基准数*pivot*，使pivot左边的数比它小，右边的数比它大
- 对左边和右边分别快速排序(递归过程)



#### 关键问题

##### 选取pivot

**A Wrong Way**

- Pivot = A[ 0 ]
- ==The worst case : A[ ] is presorted, quicksort will take $O(N^2)$ time to do nothing==

**A Safe Maneuver**

- Pivot = random select from A[ ]
- random number generation is **expensive**

**Median-of-Three Partitioning**

- Pivot = median(left, center, right)
- Eliminates the bad case for sorted input and actually reduces the running time by about 5%. 



##### 划分——找pivot位置

- 初始化：将pivot放在数组最右边，i = left, j = right -1

- 当$i$在$j$的左边时

  - 将$i$右移，遇到小于pivot的元素则继续右移，遇到大于pivot的元素则停止移动i

  - 将$j$左移，遇到大于pivot的元素则继续左移，遇到小于pivot的元素则停止移动j

  - **等于pivot的元素怎么办？也停止移动**

    考虑极端情况`1,1,1,...,1`

    ​	==如果遇到等于pivot的元素则停止移动。缺点：做了很多次无用的交换。优点：可以保证pivot的选取使得问题砍成相等的两半==

    ​	如果遇到等于pivot的元素跳过。缺点：会使得pivot的选取很极端，降低效率，不好

- 当$i$和$j$停止移动时，如果i<j，则交换两个元素；如果i>j，则排序已完成

- Swap(&a[i],&a[right-1]); 将pivot交换到i的位置



#### ==代码实现==

> ***Small Arrays***
>
> - Quicksort is slower than insertion sort for small $N(\leq 20)$.
> - Cutoff when $N$ gets small and use other efficient algorithms (such as insertion sort).

```c
void Quicksort( ElementType A[ ], int N ) 
{ 
	Qsort( A, 0, N-1 ); 
	/*A:the array*/
	/*0:Left index*/
	/*N–1:Right index*/
}
```

```c
/* Return median of Left, Center, and Right */ 
/* Order these and hide the pivot */ 
ElementType Median3( ElementType A[ ], int Left, int Right ) 
{
    int Center = ( Left+Right )/2; 
    if ( A[ Left ] > A[ Center ] ) 
        Swap( &A[ Left ], &A[ Center ] ); 
    if ( A[ Left ] > A[ Right ] ) 
        Swap( &A[ Left ], &A[ Right ] ); 
    if ( A[ Center ] > A[ Right ] ) 
        Swap( &A[ Center ], &A[ Right ] ); 
    /*Invariant: A[ Left ] <= A[ Center ] <= A[ Right ]*/ 
    Swap( &A[ Center ], &A[ Right-1 ] ); /*将pivot放到Right-1的位置*/
    /*only need to sort A[ Left+1 ] … A[ Right–2 ]*/
  	/*因为Left已经比pivot小，Right已经比pivot大*/
    return A[ Right-1 ];  /*Return pivot*/ 
}
```

```c
void Qsort( ElementType A[ ], int Left, int Right ) 
{
    int i, j; 
    ElementType Pivot; 
    if ( Left + Cutoff <= Right ) 
    {   /*if the sequence is not too short*/
        Pivot = Median3( A, Left, Right );  /*select pivot*/
        i = Left;     
        j = Right – 1;  /*为了配合下文++i,--j的index*/
      	/*If set i = Left+1 and j = Right-2, there will be an infinite loop if A[i] = A[j] = pivot.*/
      	while (1) {
	 					while ( A[ ++i ] < Pivot ) { }  
          /*scan from left,这里++i不能够放在{}里，会出bug*/
	 					while ( A[ --j ] > Pivot ) { }  /*scan from right*/
	 					if ( i < j ) Swap( &A[ i ], &A[ j ] );  /*adjust partition*/
	 					else break;  /*partition done*/
        } //注意这里括号位置！！
        /*如果N较小时不使用插入排序，光用quicksort会出问题
        	比如N=2,8,9。qsort结束后会变成9,8 */
      	Swap( &A[ i ], &A[ Right-1 ] ); /*restore pivot */ 
        Qsort( A, Left, i-1 );    /*recursively sort left part*/
        Qsort( A, i+1, Right );   /*recursively sort right part*/
    }  /*end if - the sequence is long*/
    else /*do an insertion sort on the short subarray*/ 
        InsertionSort( A+Left, Right-Left+1 );
}
```



#### 时间复杂度

> - Worst case:$O(N^2)$
> - Best case:$O(NlogN)$
> - Average case:$O(NlogN)$

$$
T(N)=T(i)+T(N-i-1)+cN
$$

$i$ is the number of the elements in $S_1$.



- **The Worst Case**
  $$
  T(N)=T(N-1)+cN
  $$

  $$
  T(N-1)=T(N-2)+c(N-1)
  $$

  $$
  \cdots
  $$

  $$
  T(2)=T(1)+2c
  $$

  $$
  T(N)=T(1)+c\sum^N_{i=2}i=O(N^2)
  $$

- **The Best Case**
  $$
  T(N)=2T(N/2)+cN \\
  T(N)=cN\log N+N=O(N\log N)
  $$

- ==**The Average Case**==

  - Assume the average value of $T( i )$ for any $i$ is $\frac{1}{N}\left[\sum^{N-1}_{j=0}T(j)\right]$
    $$
    T(N)=\frac{2}{N}\left[\sum^{N-1}_{j=0}T(j)\right]+cN
    $$

  $$
  NT(N)=2\left[\sum^{N-1}_{j=0}T(j)\right]+cN^2
  $$

  $$
  (N-1)T(N-1)=2\left[\sum^{N-2}_{j=0}T(j)\right]+c(N-1)^2
  $$

  $$
  NT(N)-(N-1)T(N-1)=2T(N-1)+2cN-c
  $$

  $$
  NT(N)=(N+1)T(N-1)+2cN
  $$

  $$
  \frac{T(N)}{N+1}=\frac{T(N-1)}{N}+\frac{2c}{N+1}
  $$

  $$
  \frac{T(N-1)}{N}=\frac{T(N-2)}{N-1}+\frac{2c}{N}
  $$

  $$
  \cdots
  $$

  $$
  \frac{T(2)}{3}=\frac{T(1)}{2}+\frac{2c}{3}
  $$

  $$
  \frac{T(N)}{N+1}=\frac{T(1)}{2}+2c\sum^{N+1}_{i=3}\frac{1}{i}
  $$

  $$
  T(N)=O(N\log N)
  $$



#### 空间复杂度

- $O(logN)$
- 如果每次pivot都处于中央位置，则$S(N) = O(logN)$

#### 算法性能

- the **fastest** known sorting algorithm in practice
- Unstable



#### 应用——QuickSelect,查找kth小元

```c
/*Places the kth sma11est element in the kth position*/
/*Because arrays start at 0, this will be index k-1*/
void Qselect(ElementType A[ ], int k, int Left, int Right)
{
	int i, j;
	ElementType Pivot;

    if (Left + Cutoff <= Right)
	{
		Pivot = Median3(A, Left, Right);
		i = Left; 
        j = Right-1;
		for( ; ; )
		{
			while(A[ ++i ] < Pivot){ }
			while(A[ --j ] > Pivot){ }
			if(i < j)
				Swap(&A[ i ], &A[ j ]);
			else
				break;
		}
		Swap(&A[ i ], &A[ Right-1 ]); /*Restore pivot*/

    if(k <= i)
			Qselect(A, k, Left, i-1);
		else if (k > i+1)
			Qselect(A, k, i+1, Right);
    /*每次只在两个划分中的一个找*/
	}
	else /*Done insertion sort on the subarray*/
		InsertionSort(A+Left, Right-Left+1);
}
```



#### 题目练习

<img src="/Users/particle/Desktop/DS/qsort1.png" style="zoom:50%;" />

> 递归总次数不会减少？

<img src="/Users/particle/Desktop/DS/qsort2.png" alt="qsort2" style="zoom:50%;" />

> run不知道是什么意思。
>
> 每一次调用qsort，都可以确定一个元素，即pivot的位置
>
> run两次可以确定3个pivot？





### ==Sorting Large Structures==

- Swapping large structures can be very much expensive.
- Add a pointer field to the structure and swap pointers instead – **indirect sorting**. Physically rearrange the structures at last if it is really necessary.
- ==Table Sort==

> 其实是构建了更简单的structure来代替复杂structure。
>
> 比如struct {key, index}
>
> 根据key来给index排序。
>
> 最后索引list[index]即可。



### 比较排序算法的时间复杂度下界——$\Omega(N\log N)$

Any algorithm that ==*sorts by comparisons only*== must have a worst case computing time of $\Omega(N\log N)$.

- When sorting $N$ distinct elements, there are $N!$ different possible results.
- Thus any ==**decision tree**== must have at least $N!$ leaves.
- If the height of the tree is $k$, then $N! \leq 2^{k-1}\rarr k\geq\log(N!)+1$ （$2^{k-1}$是高度为k的完美二叉树，最下面一层的叶结点的个数）
- Since $N!\geq (N/2)^{N/2}$ and $\log_2N!\geq(N/2)\log_2(N/2) = \Theta(N\log_2N )$
- Therefore $T(N)=k\geq c\cdot N\log_2 N$
