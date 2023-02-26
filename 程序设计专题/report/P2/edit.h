#ifndef _EDIT_
#define _EDIT_

#include <stdio.h>

#define BLOCK 80
#define INSERT -1
#define COVER 1
#define BACKSPACE 2
#define MDELETE 3
#define TEXTSIZE 48
#define WINWID 1200
#define WINHEI 50

/*
全局变量，
包括model用的字符串s,sp,size,
view用的光标caret,
功能键指示state,
输入模式mode
*/
char s[BLOCK];
char *sp = s;
int size = BLOCK;
int caret = 0;
int state,mode = INSERT;


void string_inflate();//动态数组增长
void view();//clearall,显示字符串和光标
void sub();//DELETE和BACKSPACE
void add(int c);//INSERT和COVER
void keyprobe(int key,int event);//功能键
void charput(char key);//输入字符


#endif