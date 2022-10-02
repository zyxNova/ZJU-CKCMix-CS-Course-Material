# Lab5-Recursion



测试样例设计思路

1. 矩阵

- [x] 0x0

```assembly
                .ORIG       x4000
                .FILL #0
                .FILL #0
                .END
```



- [x] 一行，一列 3

```assembly
                .ORIG       x4000
                .FILL #1
                .FILL #20
                .FILL #130 
                .FILl #91
                .fill #15 
                .fill #72 
                .fill #161 
                .fill #41 
                .fill #10 
                .fill #137
                .fill #198 
                .fill #41
                .fill #94
                .fill #180
                .fill #126
                .fill #196
                .fill #10
                .fill #188
                .fill #159
                .fill #5
                .fill #184
                .fill #14
                .END
```



M x N = 50 4

```assembly
                .ORIG       x4000
.fill #1
.fill #50

.fill #79
.fill #99
.fill #35
.fill #38
.fill #43
.fill #64
.fill #49
.fill #62
.fill #41
.fill #85
.fill #94
.fill #96
.fill #47
.fill #1
.fill #52
.fill #90
.fill #54
.fill #20
.fill #55
.fill #84
.fill #55
.fill #47
.fill #84
.fill #72
.fill #29
.fill #99
.fill #95
.fill #93
.fill #30
.fill #61
.fill #56
.fill #64
.fill #46
.fill #62
.fill #53
.fill #34
.fill #88
.fill #5
.fill #52
.fill #2
.fill #51
.fill #72
.fill #0
.fill #12
.fill #93
.fill #43
.fill #75
.fill #51
.fill #100
.fill #78
                .END
```



2. 数据

sample

```assembly
.ORIG x4000
.FILL #3 ;N 
.FILL #4 ;M
.FILL #89 
.FILL #88 
.FILL #86 
.FILL #83 
.FILL #79 
.FILL #73 
.FILL #90 
.FILL #80 
.FILL #60 
.FILL #69 
.FILL #73 
.FILL #77 
.END
```



- [x] 完全偏序关系 9

```assembly
.ORIG       x4000
.fill #3
.fill #7

.fill #0
.fill #1
.fill #2
.fill #3
.fill #4
.fill #5
.fill #6
.fill #7
.fill #8
.fill #9
.fill #10
.fill #11
.fill #12
.fill #13
.fill #14
.fill #15
.fill #16
.fill #17
.fill #18
.fill #19
.fill #20
.fill #21
.fill #22
.fill #23
.fill #24
.fill #25
.fill #26
.fill #27
.fill #28
.fill #29
.fill #30
.fill #31
.fill #32
.fill #33
.fill #34
.fill #35
.fill #36
.fill #37
.fill #38
.fill #39
.fill #40
.fill #41
.fill #42
.fill #43
.fill #44
.fill #45
.fill #46
.fill #47
.fill #48
.fill #49
                .END
```



- [x] 常数
- [ ] 遍历

no mem 15s

```assembly
                .ORIG       x4000
.fill #7
.fill #7

.fill #87
.fill #86
.fill #85
.fill #84
.fill #83
.fill #82
.fill #81
.fill #89
.fill #67
.fill #66
.fill #65
.fill #64
.fill #63
.fill #80
.fill #90
.fill #68
.fill #55
.fill #54
.fill #53
.fill #62
.fill #79
.fill #91
.fill #69
.fill #56
.fill #51
.fill #52
.fill #61
.fill #78
.fill #92
.fill #70
.fill #57
.fill #58
.fill #59
.fill #60
.fill #77
.fill #93
.fill #71
.fill #72
.fill #73
.fill #74
.fill #75
.fill #76
.fill #94
.fill #95
.fill #96
.fill #97
.fill #98
.fill #99
.fill #100
.fill #49
                .END
```

- [ ] S形走位

6x6 mem 49s

```assembly
.ORIG       x4000
.fill #6
.fill #6

.fill #1
.fill #2
.fill #3
.fill #4
.fill #5
.fill #6
.fill #12
.fill #11
.fill #10
.fill #9
.fill #8
.fill #7
.fill #13
.fill #14
.fill #15
.fill #16
.fill #17
.fill #18
.fill #24
.fill #23
.fill #22
.fill #21
.fill #20
.fill #19
.fill #25
.fill #26
.fill #27
.fill #28
.fill #29
.fill #30
.fill #36
.fill #35
.fill #34
.fill #33
.fill #32
.fill #31
.fill #71
.fill #72
.fill #73
.fill #74
.fill #75
.fill #76
.fill #94
.fill #95
.fill #96
.fill #97
.fill #98
.fill #99
.fill #100
.fill #49
                .END
```



```assembly
.ORIG       x4000
.fill #7
.fill #7

.fill #1
.fill #2
.fill #3
.fill #4
.fill #5
.fill #6
.fill #7
.fill #14
.fill #13
.fill #12
.fill #11
.fill #10
.fill #9
.fill #8
.fill #15
.fill #16
.fill #17
.fill #18
.fill #19
.fill #20
.fill #21
.fill #28
.fill #27
.fill #26
.fill #25
.fill #24
.fill #23
.fill #22
.fill #29
.fill #30
.fill #31
.fill #32
.fill #33
.fill #34
.fill #35
.fill #42
.fill #41
.fill #40
.fill #39
.fill #38
.fill #37
.fill #36
.fill #43
.fill #44
.fill #45
.fill #46
.fill #47
.fill #48
.fill #49
.fill #49
                .END
```



```assembly
.orig x4000
                .fill #6
                .fill #6
                .fill #49
                .fill #48
                .fill #47
                .fill #46
                .fill #45
                .fill #44
                .fill #38
                .fill #39
                .fill #40
                .fill #41
                .fill #42
                .fill #43
                .fill #37
                .fill #36
                .fill #35
                .fill #34
                .fill #33
                .fill #32
                .fill #26
                .fill #27
                .fill #28
                .fill #29
                .fill #30
                .fill #31
                .fill #25
                .fill #24
                .fill #23
                .fill #22
                .fill #21
                .fill #20
                .fill #14
                .fill #15
                .fill #16
                .fill #17
                .fill #18
                .fill #19
                .end
```



```assembly
.ORIG       x4000
.fill #7
.fill #7

.fill #49
.fill #48
.fill #47
.fill #46
.fill #45
.fill #44
.fill #43
.fill #36
.fill #37
.fill #38
.fill #39
.fill #40
.fill #41
.fill #42
.fill #35
.fill #34
.fill #33
.fill #32
.fill #31
.fill #30
.fill #29
.fill #22
.fill #23
.fill #24
.fill #25
.fill #26
.fill #27
.fill #28
.fill #21
.fill #20
.fill #19
.fill #18
.fill #17
.fill #16
.fill #15
.fill #8
.fill #9
.fill #10
.fill #11
.fill #12
.fill #13
.fill #14
.fill #7
.fill #6
.fill #5
.fill #4
.fill #3
.fill #2
.fill #1
.fill #49
                .END
```

