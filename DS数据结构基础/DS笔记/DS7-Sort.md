# DS-Sort

[TOC]

## 0 几个排序算法的性能衡量指标

### Time Complexity

> 以最后结果升序为例

| 算法名称 | $T_{best}$     | $T_{avg}$      | $T_{worst}$ | $S$       |
| -------- | -------------- | -------------- | ----------- | --------- |
| 选择排序 | $O(N^2)$       | $O(N^2)$       | $O(N^2)$    | $O(1)$    |
| 冒泡排序 | $O(N^2)$       | $O(N^2)$       | $O(N^2)$    | $O(1)$    |
| 插入排序 | $O(N)$, ascend | $O(N^2)$       |             | $O(1)$    |
| 堆排序   |                | $O(NlogN)$     |             | $O(1)$    |
| 希尔排序 |                | 取决于递增序列 |             | $O(1)$    |
| 归并排序 |                | $O(NlogN)$     |             | $O(N)$    |
| 快速排序 |                | $O(NlogN)$     |             | $O(logN)$ |

### Space Complexity

*In-place*, $S(N) = O(1)$ ：选择、冒泡、插入、希尔、堆

辅助空间，$S(N) = O(N)$：归并排序

递归，$S(N) = O(logN)$：快速排序

### ==Stable/Unstable==

> Stable指的是键值（用于比较排序的数值）相同（但是对应data可能不同）的两个元素，在排序前和排序后的相对位置不变。
>
> 比如排序前为 A1 ... A2, A1和A2的键值相同，排序后为 ... A1 A2 ... 则称为stable。
>
> 如果排序后可能出现... A2 A1 ... 则成为unstable

- 稳定的排序算法：冒泡排序、插入排序、归并排序、基数排序
- 不稳定的排序算法：选择排序、希尔排序、堆排序、快速排序



## 1 基于相邻元素比较的简单排序算法

### Select *选择排序*

#### 排序思路（递归）

- 找到最大值，放在最后
- `sort(a,len-1)`

#### 代码实现

**递归**

- Version1

```c
void select(int a[], int len) {
	if (len > 0) {
    int loc = findmax(a,len);
    //swap(a[loc],a[len-1]);
    int t = a[loc];
    a[loc] = a[len-1];
    a[len-1] = t;
    select(a,len-1);
  }
}

int findmax(int a[],int len) {
  int max = 0;
  for (int i=1;i<len;i++) {
    if (a[i] > a[max]) max = i;
  }
  return max;
}
```

- Version2

```c
void select(int a[], int len) {
  if (len > 0) {
    int max = 0;
    for (int i=1;i<len;i++) {
      if (a[i]>a[max]) max = i;
    }
    int t = a[max];
    a[max] = a[len-1];
    a[len-1] = t;
    select(a,len-1);
  }
} 
```

> 线性递归, 伪递归
>



**迭代**

- Version3 *较为常见的双重循环写法*

```c
void select(int a[],int len) {
  for (int i=0;i<len-1;i++) {
    int min = i;
    for (int j=i+1;j<len;j++) {
      if (a[j]<a[min]) min = j;
    }
    int t = a[i];
    a[i] = a[min];
    a[min] = t;
  }
}
```

#### 时间复杂度

$O(n^2)$,双重循环

#### 改进思路

- 每次同时找最大值和最小值；
- 找最大值和次大值；
- 找最大、次大、最小、次小
  - 但是仍然是O(n^2)



### Bubble Sort *冒泡排序*

#### 排序思路

- 每一次遍历中，两两比较相邻的两项，将较大的后移
- 冒泡：最大项像气泡一样浮到数组尾部

#### 代码实现

- 基本版本

```c
void bubble(int a[],int len) {
  for (int i=0;i<len;i++) {
    for (int j=i;j<len-1;j++) {
      if (a[j] > a[j+1]) {
        int t = a[j];
        a[j] = a[j+1];
        a[j+1] = t;
      }
    }
  }
}
```

- 改进版本

Bubble sort一般在第n次遍历之前已经结束

```c
void BubbleSort(int a[],int n)
{
    int i,j,flag;
    for (i=0;i<n;i++) {
        flag = 0;
        for (j=n-1;j>i;j--) {
            if (a[j] < a[j-1]) {
                swap(&a[j],&a[j-1]);
                flag = 1;
            }
        }
        if (!flag) break;
    }
}
```



#### 时间复杂度

 $O(N^2)$，和选择排序相似



### Insertion Sort *插入排序*

#### 排序思路

有n个元素的数列，先使前n-1个元素有序，再将第n个元素插入其中



#### 代码实现

- 递归算法

```c
//1 3 5 7 9 4
void InsertSort(int a[],int n) {
  if (n>0) InsertSort(a,n-1);//将前n-1个元素排好
  int x = a[n-1],j = n-2;
  while (j>=0 && a[j]>x) {
    a[j+1] = a[j];
    j--;
  }
  a[j+1] = x;//插入第n个元素到有序位置
}
```

> 线性递归,真递归
>
> ​		注意到递进过程只是将n个元素分成单个元素
>
> ​		实际上可以不管递进，直接写回归——迭代
>

- 迭代算法

```c
void InsertionSort(int a[],int n)
{
    int i,j,temp;
    for (i=1;i<n;i++) {
        temp = a[i];
        for (j=i-1;j>=0;j--) {
            if (temp < a[j]) a[j+1] = a[j];
            else break;
        }
        a[j+1] = temp;
    }
}
```



#### 时间复杂度

- The average case: 共排序$N$轮，每轮比较次数为$O(N)$，所以为$O(N^2)$

- The worst case : Input A[ ] is in reverse order,$T(N)=O(N^2)$
- The best case : Input A[ ] is in sorted order,$T(N) = O(N)$

#### 适用场景

- 将一个新的数据放到原有有序的数列中——$O(N)$

- 动态缓慢地加入新的数据



### 简单比较排序的时间复杂度下界——$\Omega(N^2)$

#### [Definition] Inversion,逆序对

An *inversion* in an array of numbers is any ordered pair$(i,j)$ having the property that $i<j$ but $A[i]>A[j]$

#### **逆序对的平均数量**

The average number of inversions in an array of $N$ distinct numbers is $C(n,2)/2 = N(N-1)/4$

- Swapping two adjacent elements that are out of place removes **exactly one** inversion.
- $T(N,I)=O(I+N)$ where $I$ is the number of inversions in the original array.

#### 比较次数=逆序对总数

[Theorem] Any algorithm that sorts by exchanging adjacent elements requires $\Omega(N^2)$ time on average









