# Patt-Ch7 Assembly Language

[TOC]



## **7.1 From Machine Code to Assembly Language**

**Assembler** is a program that turns symbols into machine instructions.

**Assembly Language**

- Low-level language, ISA-specific
  - it is usually the case that **==each ISA has only one assembly language==**
- User-Friendly
  - mnemonics(助记符) for opcodes
  - **labels** for memory locations
- still provide detailed control over the instructions



## **7.2 LC-3 Assembly Language Syntax**

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-15 18.57.40.png" alt="截屏2021-07-15 18.57.40" style="zoom:50%;" />





<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-18 16.48.26.png" alt="截屏2021-07-18 16.48.26" style="zoom:70%;" />

```assembly
LDR 	R4, R2, #-5					; R4 <- mem[R2-5]
LD		R4, VALUE						; R4 <- mem[VALUE]
LDI 	R4, VALUE						; R4 <- mem[mem[VALUE]]
LEA 	R4, TARGET					; R4 <- the address of TARGET
ST		R4, HERE						; mem[HERE] <- R4
STI		R4, THERE						; mem[mem[THERE]] <- R4
STR 	R4, R2, #-5					; mem[R2-5] <- R4
```



### 7.2.1 Instructions

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-15 18.58.59.png" alt="截屏2021-07-15 18.58.59" style="zoom:50%;" />

#### 7.2.1.1 Opcodes & Operands

**Opcodes**

- *reserved words*
- Symbolic names

**Operands**

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-15 19.01.45.png" alt="截屏2021-07-15 19.01.45" style="zoom:50%;" />



#### 7.2.1.2 Labels

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-15 19.02.29.png" alt="截屏2021-07-15 19.02.29" style="zoom:50%;" />



**2 reasons for using Labels:**

- The location is the target of BR
- The location contains a value that is loaded or stored.



#### 7.2.1.3 Comments

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-15 19.03.55.png" alt="截屏2021-07-15 19.03.55" style="zoom:50%;" />





### 7.2.2 Pseudo-Ops (Assembler Directives)

> Pseudo-, /ˈsudoʊ/, 假的

```assembly
.ORIG x3000								; The start address of program

.END											; The end of program

.FILL	x0030								; allocate one word, initialize with value n

.BLKW	n(decimal)					; BLocK of Words, allocate n words of storage

.STRINGZ "ABC" 						; allocate n+1 addresses, initialize n words 
													; with Zero-EXT ASCII codes, and NULL terminated
												
.EXTERNAL									; send a message to LC-3 assembler that the 															
													; absence of the label is in another module.
													; Used for multi-file programming.
```

**Note **: .END does not stop the program **&** it does not even exist at the time of execution.



### 7.2.3 Good Programming Style*

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-15 19.15.26.png" alt="截屏2021-07-15 19.15.26" style="zoom:50%;" />



## **7.3 The Assembly Process**

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-15 19.24.28.png" alt="截屏2021-07-15 19.24.28" style="zoom:50%;" />



### 7.3.1 First Pass: Constructing the Symbol Table

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-15 19.24.59.png" alt="截屏2021-07-15 19.24.59" style="zoom:50%;" />

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-15 19.27.24.png" alt="截屏2021-07-15 19.27.24" style="zoom:50%;" />



### 7.3.2 Second Pass: Generating Machine Language

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-15 19.28.15.png" alt="截屏2021-07-15 19.28.15" style="zoom:50%;" />



## **7.4 Multiple Object Files (Recommend Reading)**

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-15 19.35.10.png" alt="截屏2021-07-15 19.35.10" style="zoom:50%;" />



<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-19 08.57.54.png" alt="截屏2021-07-19 08.57.54" style="zoom:50%;" />



<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-15 19.35.21.png" alt="截屏2021-07-15 19.35.21" style="zoom:50%;" />

