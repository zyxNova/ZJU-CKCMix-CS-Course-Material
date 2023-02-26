#!/bin/sh
# Program: dirsync
# Author: 熊子宇, Sno: 3200105278

# 遍历目标目录中的每一个文件(dst)，与原目录中同名文件(src)做比对
# 输入：$1 目标目录 $2 源目录
# 如果 dst是目录文件 且 src是目录文件，则递归调用本程序
# 如果 dst是目录文件 且 src不存在或者是普通文件，则删除dst
# 如果 dst是普通文件 且 src是普通文件，则比较二者的更新时间，判断src是否要更新
# 如果 dst是普通文件 且 src不存在或者是目录文件，则删除dst
function cmpSrc() {
    dstFile=$1'/*'
    for dst in $dstFile 
    do
        src="${dst/$1/$2}"     # 字符串头部替换，获得源目录中同名文件src
        if [ -d $dst -a -d $src ]; then
            cmpSrc $dst $src
        elif [[ -d $dst && (!(-e $src) || -f $src) ]]; then
            echo "delete $dst"
            rm -rf $dst     # 强制递归删除dst
        elif [ -f $dst -a -f $src ]; then
            if [ $dst -nt $src ]; then    # -nt表示newer than,即dst修改时间新于src
                echo "update $src"
                cp -pf $dst $src    # -p选项表示拷贝时保持文件属性不变，-f表示强制拷贝，忽略警告
            fi
        elif [[ -f $dst && (!(-e $src) || -d $src) ]]; then
            echo "delete $dst"
            rm -f $dst
        fi
    done
}

# 遍历源目录中的每一个文件(src)，与目标目录中同名文件(dst)做比对
# 输入：$1 源目录 $2 目标目录
# 如果 dst不存在，则备份src
# 如果 src是普通文件，则比较二者的更新时间，判断dst是否要更新
# 如果 src是目录文件，则递归调用本程序
# 注：在调用cmpSrc函数后，源目录和目标目录中不会出现同名但类型不一致的文件，因此只需要判断src的文件类型即可
function cmpDst() {
    srcDirectory=$1'/*'
    for src in $srcDirectory 
    do
        dst="${src/#$1/$2}"     # 字符串头部替换，获得目标目录中同名文件dst
        if [[ !(-e $dst) ]]; then
            echo "create $dst"
            cp -Rfp $src $dst 2>/dev/null   # -R选项表示递归地拷贝src到dst
        elif [ -f $src ]; then
            if [ $src -nt $dst ]; then
                echo "update $dst"
                cp -pf $src $dst
            fi
        elif [ -d $src ]; then
            cmpDst $src $dst
        fi
    done
}

# 检查输入参数个数为2，且第一个参数必须为目录文件类型
if [[ $# -ne 2 || !(-d $1) ]]; then
    echo "Usage: input source and destination directories "
    echo "        as arguments, to sync src to dst."
    exit 1
fi

if [[ !(-e $2) ]]; then   # 如果目标目录不存在，则直接拷贝源目录
    cp -Rfp $1 $2
    echo "Info: fisrt backup completed."
elif [[ !(-d $2) ]]; then    # 如果目标目录不是目录文件，则报错退出
    echo "Error: dst directory have to not exist or be a diretory file."
    echo "       Please reinput."
    exit 1
else 
    cmpSrc $2 $1
    cmpDst $1 $2
    echo "Info: sync completed."
fi
