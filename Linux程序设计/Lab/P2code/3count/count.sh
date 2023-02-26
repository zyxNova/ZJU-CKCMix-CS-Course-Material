#!/bin/sh
# Program: 2-3count_files
# Author: 熊子宇, Sno: 3200105278

# 检验输入参数个数为1，而且参数为目录
if [ $# -ne 1 ]; then
        echo "Please input a directory name as argument"
        exit 1  # 输入参数数目不为1，报错退出脚本
fi

if [ -d $1 ]; then    # 输入参数为目录，则进入脚本
        # ls选项说明： -l 长列表， -A 显示所有文件及子目录，但不列出 “.” (当前目录) 及 “..” (父目录)
        # -R 递归地列出子目录中的文件， -F 在列出的文件名称后加一符号;例如可执行文件则加 “*”, 目录则加 “/”
        _file="temp.txt"    # 创建临时文件备用，以便重定向统计普通文件字符数
        ls -lAR $1 2>/dev/null | grep -s '^-' > $_file   # 传入参数目录中普通文件即以-开头的行，重定向至_file文件中，方便后续统计行数和字符数
        dfile=$(ls -lAR $1 | grep -cs '^d')    # 统计传入参数目录中子目录的个数，即以d开头的行数，grep -c参数为统计行数
        xfile=$(ls -lARF $1 | grep -cs '*$')   # 统计传入参数目录中可执行文件的个数，即以*结尾的行数
        bytes=0     # 字符数计数器清0
        
        while read -r line  # 从_file中读取每一行
        do 
            set -- $(echo "$line")  # 将第五列赋值给$5
            bytes=$(($bytes+$5))    # 计数器累加
        done < $_file   

        echo "# ordinary files           $(($(cat $_file | wc -l)-1))"  # 使用wc -l统计_file的行数。-1是因为temp.txt也是普通文件
        echo "# directory files          $dfile"
        echo "# executable files         $xfile"
        echo "# chars in ordinary files  $bytes"
        rm -f $_file    # 删除临时文件
    else
        echo "Please input a directory name as argument."    # 输入的参数不是目录
        exit 1
fi