#!/bin/sh
# Program: check palidrome
# Author: 熊子宇, Sno: 3200105278

# 检查输入参数：单个参数
if [ $# -ne 1 ]; then
        echo "Usage: input a string to check whether it is palidrome."
        exit 1
fi

copy=$1     # 拷贝参数，作为初始字符串
len=${#copy}     # 输入字符串的长度
str=
#定义str变量为空

# 删除非字母，即所有字符都应该为[a-zA-Z]
for ((i=0; i<len; i++)) do
    char=${copy:i:1}    # 获取字符串中第i位字符
    if [[ $char == [a-zA-z] ]]; then    # 若当前字符为a-zA-z
        str=$str$char   # 在原有的str变量后追加char
    fi
done

len=${#str}     # 删除非字母后的字符串长度
if [ $len -eq 0 ]; then     # 如果删除非字母后字符串为空，则需要重新输入合法字符串
    echo "Error: After deletion, the string is empty. Please reinput a legal string."
    exit 1
fi

# 判断字符串是否为回文
for ((i=0; i<len/2; i++)) do
    start=${str:i:1}    # str[i]
    end=${str:len-1-i:1}    # str[len-i-1]
    if [ $start != $end ]; then     # 如果str[i] != str[len-i-1]，则该字符串不是回文
        echo "$str is NOT a palidrome."
        exit 0
    fi
done

echo "$str is a palidrome."     # 通过循环，则说明字符串为回文