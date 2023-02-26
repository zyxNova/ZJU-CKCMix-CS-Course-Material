# Patt-Ch9 I/O

[TOC]

## **9.1 Overview: Memory Organization**

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-21 22.18.48.png" alt="截屏2021-07-21 22.18.48" style="zoom:50%;" />

### 9.1.1 System Space

- Range: [x0000, x2FFF]
- Privileged
- Contents
  - Trap Vector Table, [x0000, x00FF]
  - Interrupt Vector Table, [x0100, x01FF]
  - System Service Routines
  - Exception Service Routines
  - Interrupt Service Routines
  - etc.



#### Trap Vector Table

A table of the starting address of System service routines

- Locations: [x0000, x00FF]

  <img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-21 09.21.40.png" alt="截屏2021-07-21 09.21.40" style="zoom:50%;" />

#### Interrupt Vector(INTV) Table

> See Page 675 A.3

 **exception(异常) service routines**

- amount to 128 entries

- Locations x0100 to x017F

- Contents: the starting addresses of routines which are called because they handle exceptional events, that is, events that prevent the program from executing normally.

  ​																		*e.g. RTI state 44, use RTI instruction but PSR[15]=1*

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-21 22.27.38.png" alt="截屏2021-07-21 22.27.38" style="zoom:50%;" />

**interrupt service routines**

- amount to 128 entries
- Locations x0180 to x01FF
- Contents: provide the starting addresses of routines that service events that are **external to the program** that is running
  -  requests from I/O devices
  -  *timer interrupt, machine check, power failure, and so on*



### 9.1.2 User Space

- Range: [x3000, xFDFF]
- Unprevileged

Attention: xFDFF is the last memory location of LC-3



### 9.1.3 Device Register Address

- Range: [xFE00, xFFFF]
- Privileged
- Contents
  - Not correpsond to memory locations at all
  - identify registers taking part in I/O functions
  - some special registers associated with the processor

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-20 19.47.05.png" alt="截屏2021-07-20 19.47.05" style="zoom:50%;" />

#### PSR

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-20 08.40.26.png" alt="截屏2021-07-20 08.40.26" style="zoom:50%;" />

- **Privilege**
  - PSR[15]=0 means ***supervisor privilege*** (kernal mode)
  - PSR[15]=1 means ***unprivileged*** (user mode)

> **Right(特权)** to do something
>
> such as execute a particular instruction or access a particular memory location. 



- **Priority**
  - Bits [10:8] specify the priority level (PL) of the program. 
  - The highest priority level is 7 (PL7), the lowest is 0(PL0)

> **Urgency(紧急度)** of a program to execute

​	*Attention: Privilege and Priority have **nothing to do** with each other*



- ***Why CC is set in PSR?***

  Due to the machanism of Interrupt-Driven I/O, when we come back from the interrupt routine, we want CC not changed.

  Popping PSR from Supervisor Stack can handle this issue.

#### KBSR

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-21 22.46.35.png" alt="截屏2021-07-21 22.46.35" style="zoom:50%;" />

- bit [15] contains the ready bit
  - When keyboard puts a char, R = 1
  - When processor gets the char, R = 0
- bit [14] contains the interrupt enable bit



#### KBDR

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-21 22.48.55.png" alt="截屏2021-07-21 22.48.55" style="zoom:40%;" />

- bits [7:0] are used for the data, and bits [15:8] contain x00

#### DSR

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-21 22.47.27.png" alt="截屏2021-07-21 22.47.27" style="zoom:50%;" />

- bit [15] contains the ready bit
  - When monitor has written a char (idle), R = 1
  - When monitor is writing(busy), R = 0
- Bit [14] contains the interrupt enable bit

#### DDR

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-21 22.49.44.png" alt="截屏2021-07-21 22.49.44" style="zoom:40%;" />

- bits [7:0] are used for data, and bits [15:8] contain x00

#### MCR



### 9.1.4 Supervisor Stack/User Stack

- Supervisor mode or User mode at any one time, so only one of the two stacks is active at any one time. 

- R6 is generally used as the stack pointer (SP) for the active stack. 

- **Saved_SSP** and **Saved_USP** are provided to save the SP not in use. 
  - for example, from Supervisor mode to User mode, the SP is stored in Saved_SSP, and the SP is loaded from Saved_USP.









## **9.2 Input/Output**

### 9.2.1 Three Basic Characteristics of I/O

#### (1) Memory-Mapped I/O vs. Special I/O Instructions

> 内存映射 vs. 特殊指令
>
> *Noting: Most computers nowadays use Memory-Mapped I/O rather than special instructions*

**Memory-Mapped I/O**

Input and output are handled by load/store (LD/ST, LDI/STI, LDR/STR) instructions using memory addresses from xFE00 to xFFFF to designate each device register. 

Above are the input and output device registers and internal processor registers that have been specified for the LC-3 thus far, along with their corresponding assigned addresses from the memory address space.

refer to [9.1.3 Device Register Address](1)



#### (2) Asynchronous vs. Synchronous

> 同步 vs. 异步
>
> Most interaction between a processor and I/O is asynchronous

**asynchronous**: I/O devices usually operate at speeds very different from that of a microprocessor, and not in lockstep.

**synchronization mechanism**: ready bit (KBSR[15] and DSR[15])

- In the case of the keyboard, we will need a one-bit status register to indicate if someone has or has not typed a character. 
  - Each time the typist types a character, the ready bit is set to 1. 
  - Each time the computer reads a character, it clears the ready bit.
  - When the computer detects that the ready bit is set, it could only have been caused by a **new** character being typed, so the computer would know to again read a character.
  - If not detected Ready Bit, we will input the same char many times==重复读==

- In the case of the monitor, we will need a one-bit status register to indicate whether or not the most recent character sent to the monitor has been displayed, and so the monitor can be given another character to display.
  - If not detected Ready Bit, we will ignore or lost some chars stored in DDR==丢输出==

==keyboard & monitor 有差异，原因在于processor和I/O设备读写速度的差异==

#### (3) Interrupt-Driven vs. Polling

> 中断 vs. 轮询
>
> the issue of who **controls** the interaction between processor and I/O devices
>
> Both are used in today's computers

**interrupt-driven I/O**: the **keyboard** controls the interaction.

**polling**(查询): the **processor** is in charge. The ready bit is polled by the processor, asking if any key has been struck.



**Time Efficiency of Interrupt-Driven I/O and Polling**

With interrupt-driven I/O, none of that testing and branching has to go on.

Interrupt-Driven I/O improve time efficiency



##### Polling Input

```assembly
START		LDI		R1, KBSR			; must use LDI, not LD
				BRzp	START
				LDI		R0, KBDR
				BRnzp NEXT_TASK
KBSR		.FILL	xFE00
KBDR		.FILL	xFE02
```

ready bit = 1 means it's OK to load a character to the register



> Difference between LD and LDI
>
> LD R1, A  A contains data
>
> LDI R1, A A contains an address. Go to the address to get data indirectly
>
> x3000 -> xFE00 must use LDI, because out of offset9



##### Polling Output

```assembly
START		LDI		R1, DSR				; must use LDI, not LD
				BRzp	START
				STI		R0, KBDR
				BRnzp NEXT_TASK
DSR			.FILL	xFE04
DDR			.FILL	xFE06
```

ready bit = 1 means it's OK to write a character to the screen



Drawback for polling: waste time



### 9.2.2 Memory-Mapped I/O Details

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-20 10.10.29.png" alt="截屏2021-07-20 10.10.29" style="zoom:50%;" />

#### (1) Data Path - Elements and Functions

- **Address Control Logic** controls the input or output operation

**3 Inputs**

- **MIO.EN** (Memory IO Enable) indicates whether a data movement from/to memory or I/O is to take place this clock cycle
  - MIO.EN = 0, ACL do nothing
  - MIO.EN = 1, ACL provides control signal depending on the other two inputs

- **R.W** indicates whether a load or a store is to take place
  - R/W depends on instruction opcode
  - Read(load, or input), transfer from memory or I/O device to MDR
    - KBDR, KBSR, DSR, MEM -> INMUX (selected by MAR)
  - Write(output), transfer from MDR to memory or I/O device
    - MDR -> KBSR, DDR, DSR, MEM

- **MAR** contains the address of the memory location or *the memory-mapped address of an I/O device register*



**5 Outputs**

- **MEM.EN**(Memory Enable) indicates whether memory can be accessed 
- **IN.MUX** select MEM, KBDR, KBSR, DSR depending on MAR
- **LD.KBSR**
- **LD.DSR**
- **LD.DDR**



#### (2) Truth Table for ACL

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-20 20.47.30.png" alt="截屏2021-07-20 20.47.30" style="zoom:50%;" />

> Noting:
>
> x represents either of the inputs is irrelevant to the output
>
> Every address in MAR has 4 statuses of input, depending on MIO.EN and R.W
>
> other represents memory locations







## **9.3 Interrupt Routines**

> Interrupt, but **as if nothing had happened.** 



### 9.3.1 Three Situations for Interruption

#### (1) Interrupt-Driven I/O

##### Want, Right, Higher Priority

- Want: Bit[15], ready bit

- Right: Bit[14], interrupt enable bit

- Higher Priority: Bit[10:8]

All of them depend on PSR

##### INT signal Generation

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-21 08.55.05.png" style="zoom:50%;" />



**priority encoder** is a combinational logic structure that selects the highest priority request from all those asserted. 

If the PL of that request is higher than the PL of the currently executing program, the INT signal is asserted.



##### When to test for INT

**Always** test at the start of FETCH phase, otherwise it's too complicated 

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-21 09.00.25.png" alt="截屏2021-07-21 09.00.25" style="zoom:50%;" />





#### (2) TRAP - System Call

Difference:

- Table, `x00` for Trap, `x01` for INTV
- Interrupt need `PSR[10:8] <- Priority`, Trap doesn't



#### (3) Exception

Example: use RTI in user mode



### 9.3.2 The Interrupt Process

#### (1) 4 Procedures  

*Not the precise sequence in state machine*

- Save the state of the interrupted program 
  - PUSH PSR to SS
  - PUSH PC to SS
- Load the state of the higher priority interrupting program
  - update PSR priority
  - PSR[15] <- 0
  - PC <- mem[Table'Vector] 
  - (switch between US and SS)

- Service
- Restore and return -- RTI
  - Check PSR[15] - normal or exception
  - POP PC from SS
  - POP PSR from SS
  - (switch between US and SS)



#### (2) Finite State Machine

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-21 10.39.43.png" alt="截屏2021-07-21 10.39.43" style="zoom:60%;" />



<img src="/Users/particle/Downloads/Md图床/ICS/Interrupt FSM.png" alt="Interrupt FSM" style="zoom:50%;" />



- **⚠️Review MS flipflop to figure out when the value updates - not change in the whole state, until the next!**

`A <- B`

the master latch changes during CLOCK bar, and the slave latch changes at the next start of CLOCK

That is to say, the value containing (e.g. PSR[15], or PC, MAR) doesn't change during the whole CLOCK cycle until the next state

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-21 10.30.16.png" alt="截屏2021-07-21 10.30.16" style="zoom:50%;" />



#### (3) Detailed Description

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-21 09.31.35.png" alt="截屏2021-07-21 09.31.35" style="zoom:50%;" />

#### (4) Return from the Interrupt - RTI

**RTI Instructions** 

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-20 11.09.43.png" alt="截屏2021-07-20 11.09.43" style="zoom:50%;" />

**RTI - Finite State Machine**

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-21 11.04.47.png" alt="截屏2021-07-21 11.04.47" style="zoom:60%;" />

*POP PC*: state 8, 36, 38

*POP PSR*: state 39, 40, 42

*If go back to user mode*: 59

*Exception(ACV, that is access privileged state in user mode)*: state 44

### 9.3.3 Nested Interruption

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-21 11.13.07.png" alt="截屏2021-07-21 11.13.07" style="zoom:50%;" />



<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-21 11.13.25.png" alt="截屏2021-07-21 11.13.25" style="zoom:50%;" />



## **9.4 Polling Revisited: Together with Interrupt**

### 9.4.1 The Problem

> Example:
>
> Polling Output as follows
>
> START LDI R1, DSR
>
> ​			BRnp START
>
> ​			STI  R0, DDR
>
> if we complete BR, and are to do STI. Suddenly the keyboard interrupt routine occurs, what will happen?

The keyboard interrupt occurs, the character typed is echoed, i.e., written to the DDR, and the keyboard interrupt service routine completes.

The interrupted loop body then takes over and **“knows” the monitor is ready,** so it executes the STI. ... except the monitor is not ready because it has not completed the write of the keyboard service routine! **The STI of the loop body writes, but since DDR is not ready, the write does not occur.** 

### 9.4.2 The Solution

**Simple but Silly Solution**

Disable all interrupts while polling was going on

**A Wise Solution**

An interrupt are only permitted to happen before LDI. It would have to wait for the three-instruction sequence LDI, BRzp, STI to execute, rather than for the entire polling process to complete.

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-21 14.07.51.png" alt="截屏2021-07-21 14.07.51" style="zoom:50%;" />





## **9.5 Operating System Service Routines (TRAP)**

> OSH, Operating System Help
>
> System Call = Service Call

### 9.5.1 Why use TRAP?

- Ignore detailed implement
- Security

### 9.5.2 TRAP Mechanism

**Several Elements**

- **Service Routines**

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-21 09.19.45.png" alt="截屏2021-07-21 09.19.45" style="zoom:50%;" />

- **The Trap Vector Table**: [x0000, x00FF], A table of the starting address of these service routines

- **TRAP instructions**
- **Linkage back** to the user program - RTI



### 9.5.3 TRAP Instruction

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-21 11.30.45.png" alt="截屏2021-07-21 11.30.45" style="zoom:70%;" />

**Finite State Machine**

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-21 11.31.48.png" alt="截屏2021-07-21 11.31.48" style="zoom:50%;" />

state 37 and 45: Go to Interrupt



### 9.5.4 Example: Trap x23, IN

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-21 11.28.12.png" alt="截屏2021-07-21 11.28.12" style="zoom:70%;" />

*More Examples see p333-339*







## ==**9.7 Exceptions**==

**Access Control Violation(ACV)**

若总线上的地址，也就是下一条指令的地址 (after MAR <- PC, PC <- PC + 1)  <x3000 或者 ≥xFE00，且 当前为 user mode，则set ACV



<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-21 10.22.43.png" style="zoom:50%;" />




