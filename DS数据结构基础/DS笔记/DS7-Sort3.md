[TOC]

## 3 其他排序算法

> 不是基于比较的排序算法，突破了$\Omega (NlogN)$的下界限制
>
> 桶排序：$O(N+M)$, N为元素个数，M为桶数，一般而言N>>M
>
> 基数排序：$O(P(N+M))$, P为基数的个数（数字有多少位），N为元素个数，M为桶数



### Bucket Sort *桶排序*

#### 排序思路

元素的key在有限范围内取值。元素个数>>取值范围。

类似于鸽洞原理，把鸽洞作为链表表头，把元素往各个洞里链。

![image-20201221203533117](/Users/particle/Desktop/大二上/数据结构基础/学长笔记/Notes-for-Data-Structure-master/picture/image-20201221203533117.png)

```pseudocode
Algorithm
{
    initialize count[ ];
    while(read in a student’s record)
        insert to list count[stdnt.grade];
    for(int i = 0; i < M; i++) 
	{
        if(count[i]) output list count[i];
    }
}
```

$$
T(N,M)=O(M+N)
$$

> 当M>>N时，比较划算。
>



### Radix Sort *基数排序*

#### LSD(Least Significant Digit) Sort

> 先按个位装桶，再按十位装桶，再按百位...
>
> 当排到十位的时候，十位和个位是已排好序的；当排到百位的时候，百、十、个位是已排好序的……

![image-20201221203826847](/Users/particle/Desktop/大二上/数据结构基础/学长笔记/Notes-for-Data-Structure-master/picture/image-20201221203826847.png)

![image-20201221203950519](/Users/particle/Desktop/大二上/数据结构基础/学长笔记/Notes-for-Data-Structure-master/picture/image-20201221203950519.png)

$T=O(P(N+B))$ where $P$ is the number of passes, $N$ is the number of elements to sort, and $B$ is the number of buckets.



#### MSD(Most Significant Digit) Sort

> 先排最高位，再排低位。得到字典序。

<img src="/Users/particle/Desktop/大二上/数据结构基础/学长笔记/Notes-for-Data-Structure-master/picture/image-20210102211456822.png" alt="image-20210102211456822" style="zoom: 75%;" />

<img src="/Users/particle/Desktop/大二上/数据结构基础/学长笔记/Notes-for-Data-Structure-master/picture/image-20210102211604977.png" alt="image-20210102211604977" style="zoom: 75%;" />

<img src="/Users/particle/Desktop/大二上/数据结构基础/学长笔记/Notes-for-Data-Structure-master/picture/image-20210102211647809.png" alt="image-20210102211647809" style="zoom:75%;" />