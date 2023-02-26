# Program: 2-2makefile
# Author: 熊子宇, Sno: 3200105278

# 定义所需的makefile变量
SRC = main.c input.c compute.c
OBJS := $(SRC:.c=.o) # 目标文件为 main.o input.o compute.o
CC = gcc # 使用gcc编译器
# power目标依赖于main.o input.o compute.o
# 命令为 gcc main.o input.o compute.o -o power -lm, 其中$@自动化变量表示目标文件
power: $(OBJS)  
	$(CC) $(OBJS) -o $@ $(CFLAGS) 

# 利用makefile的自动推导功能
# input.o: input.c input.h 可以被省略
# compute.o: compute.c compute.h 可以被省略
# main.o: main.c main.h input.h compute.h 同名.c,.h文件可以被省略
main.o: input.h compute.h

# 伪目标文件，用于清除*.o和power
.PHONY: clean
clean:
	rm -f *.o power