# Patt-Ch3 Digital Logic Structures

[TOC]

## **3.1 Transistor: Building Block of Computers**

**Switch Level** of Transistor Behaviour

### 3.1.1 N-type MOS Transistor

> MOS = Metal Oxide Semiconductor

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-12 09.09.00.png" alt="截屏2021-07-12 09.09.00" style="zoom:50%;" />

### 3.1.2 P-type MOS Transistor

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-12 09.10.39.png" alt="截屏2021-07-12 09.10.39" style="zoom:50%;" />





**CMOS Circuit**

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-12 09.19.11.png" alt="截屏2021-07-12 09.19.11" style="zoom:50%;" />



## **3.2 Logical Gates**

### 3.2.1 NOT Gate

> a.k.a. Inverter,INV,逆相器

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-12 09.16.25.png" alt="截屏2021-07-12 09.16.25" style="zoom:50%;" />

### 3.2.2 NOR and OR Gates

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-12 09.28.18.png" alt="截屏2021-07-12 09.28.18" style="zoom:50%;" />



<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-12 09.36.22.png" alt="截屏2021-07-12 09.36.22" style="zoom:50%;" />

### 3.2.3 NAND and AND Gates

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-12 09.40.15.png" alt="截屏2021-07-12 09.40.15" style="zoom:50%;" />



<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-12 09.40.27.png" style="zoom:50%;" />

### 3.2.4 DeMorgan's Law

 use AND & NOT Gate ->OR Gate

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-12 09.42.21.png" style="zoom:50%;" />

### *3.2.5 Why We Can't Connect P-Type to Ground?*

*See Page 64-65*

### 3.2.6 Summary in Gate Level

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-12 09.42.08.png" style="zoom:50%;" />

**XOR Gate**



<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-12 09.43.21.png" style="zoom:50%;" />





## **3.3 Combinational Logic Circuits**

- output depends **only** on the **current** inputs
- **no information can be stored** internally in a combinational logic circuit.



### 3.3.1 Decoder

> 译码器

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-12 09.44.23.png" style="zoom:50%;" />

- Use of Decoder:
  - convert memory/register address to a control line that selects that location
  - convert an opcode to one of n control lines

- Drawback of Decoder:
  - 不能处理过多线路



### 3.3.2 Multiplexer

> a.k.a. MUX,多路选择器

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-12 16.07.11.png" alt="截屏2021-07-12 16.07.11" style="zoom:50%;" />

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-12 09.54.15.png" style="zoom:50%;" />

- Use of MUX:
  - select which input to use for function
  - select which computed value to pass to next stage (or to place on bus)



### 3.3.3 A One-Bit Adder

> a.k.a A Full Adder

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-12 10.15.01.png" style="zoom:50%;" />

- *a half adder*
  - Depends on only two inputs, A and B, ignore C(carry in)
  - XOR





<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-12 10.15.15.png" style="zoom:50%;" />



- Ripple-carry adder(行波进位加法器)
  - The sum becomes valid as the carry ripples its way from the low bit to the high bit.
- *More efficient: Lookahead carry adder(超前进位链加法器)*



- Supplement: Subtracter

<img src="../Homework/Homework2/3.30c.jpeg" alt="3.30c" style="zoom:50%;" />



### 3.3.4 The Programmable Logic Array(PLA)

- **AND Array**: For *n*-input logic functions, we need a PLA with 2*^n^* *n*-input AND gates.
- **OR Output**: The number of OR gates corresponds to the number of **output columns in the truth table.** 
- **Programmble Connections**: The implementation algorithm is simply to connect the output of an AND gate to the input of an OR gate if the corresponding row of the truth table produces an output 1 for that output column.

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-12 10.20.23.png" style="zoom:50%;" />



### 3.3.5 Logical Completeness

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-12 10.32.53.png" style="zoom:50%;" />

Note: **NAND Gate,NOR Gate** are *logically complete* as well. That is to say, use only NAND or NOR gates can construct AND,OR,NOT Gate.

**NAND Gate**

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-12 16.28.08.png" style="zoom:50%;" />



## **3.4 Basic Storage Elements**

### 3.4.1 R-S Latch

> 锁存器
>
> R-reset(to 0), S-set(to 1)



<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-12 10.37.13.png" style="zoom:50%;" />



- **The Quiescent State**
  - “quiescent” state -- holds its previous value
  - If both R and S are 1, out could be either 0 or 1

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-12 10.40.10.png" style="zoom:50%;" />

- **Set(to 1)**
  - change S to 0

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-12 10.42.22.png" style="zoom:50%;" />

- **Reset(to 0)**

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-12 16.39.55.png" style="zoom:50%;" />



***Note: NOR Gate can also construct R-S Latch***



### 3.4.2 Gated D-Latch

> Gated-WE(*write enable*) performs as a gate
>
> D-data
>
> use D and WE to control when a new value is written to the latch,and avoid the situation where both R and S equal to 0.

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-12 16.47.48.png" style="zoom:50%;" />

Use of the Gated D-Latch: store a single data bit



### 3.4.3 Register

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-12 16.51.38.png" style="zoom:50%;" />



- We usually need flip-flops, rather than latches, because it is usually important to be able to both read the contents of a register throughout a clock cycle and also store a new value in the register at the end of that same clock cycle. 

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-13 15.30.31.png" alt="截屏2021-07-13 15.30.31" style="zoom:50%;" />



## **3.5 Memory**

### 3.5.1 Address,Address Space,Addressability

- ***Address***: the **unique identifier** associated with each memory **location**

- ***Address Space***: the number of locations

  - Example: 2GB memory refers to a memory that consists of approximately 2 *x* 10^9^ locations. Precisely, 2 x 2^30^ = 2^31^ locations.

  - kilo 2^10^, mega 2^20^, giga 2^30^

- ***Addressability***: the number of bits stored in each memory location
  - Most memories are **byte-addressable**. The reason is historical; most computers got their start processing data, and one character stroke on the keyboard corresponds to one 8-bit ASCII code. If the memory is byte-addressable, then each ASCII character occupies one location in memory. Uniquely identifying each byte of memory allows individual bytes of stored information to be changed easily.
  - Many computers that have been designed specifically to perform large scientific calculations are **64-bit addressable.** 

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-12 16.52.35.png" style="zoom:50%;" />



### 3.5.2 A 2^2^-by-3-Bit Memory

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-12 11.03.25.png" style="zoom:67%;" />



## **3.6 Sequential Logic Circuits**

> 时序逻辑电路*,depends on history,or sequence*

- **both** process information (i.e., make decisions) **and** store information
- base their decisions not only on the input values **now present**, but also (and this is very important) on **what has happened before**
- *Sequential logic circuits* are used to implement *finite state machines*

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-12 17.06.31.png" style="zoom:50%;" />



### 3.6.1 Example: Combinational vs. Sequential

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-12 11.16.52.png" style="zoom:50%;" />



### 3.6.2 State

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-12 11.23.48.png" style="zoom:67%;" />

- Important concepts: snapshot, situation right now
- Examples: Lock, Tic-Tac-Toe Game, Basketball scoreboard, Old drink machine, e.t.c.
  - All above are **Asychronous** Finite Machine



### 3.6.3 The Finite State Machine and State Diagram

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-12 17.09.58.png" style="zoom:67%;" />

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-12 17.10.14.png" style="zoom:67%;" />

### 3.6.4 The Synchronous Finite State Machine

> 2GHz, 2 biilion clock cycle/second

- state transition take place at **identical fixed units of time(i.e. clock cycle)**

- 连续的状态->足够多的有限状态（足够快的转变,以至于人识别不了）

### 3.6.5 The Clock

- **Clock circuit** triggers transition from one state to the next
- At the **start** of each clock cycle, **transtition happens**, depending on **the current state and the external inputs**

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-13 08.41.25.png" alt="截屏2021-07-13 08.41.25" style="zoom:50%;" />

### 3.6.6 Significant Example: Danger Sign

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-13 08.46.36.png" alt="截屏2021-07-13 08.46.36" style="zoom:50%;" />

#### 3.6.6.1 Overview of Sequential Circuit

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-13 09.11.22.png" alt="截屏2021-07-13 09.11.22" style="zoom:50%;" />

#### 3.6.6.2 State Diagram and Truth Table

**State Diagram**

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-13 09.13.14.png" alt="截屏2021-07-13 09.13.14" style="zoom:50%;" />



- **State Variables:** 00, 01, 10, 11, to identify states
- ==*Moore Mode*==

**Truth Table**

 3 inputs(SW, S1, S0), 5 outputs(1&2, 3&4, 5, S1', S0')

| SW   | S1   | S0   |      | 1&2  | 3&4  | 5    | S1'  | S0'  |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| 0    | X    | X    |      | 0    | 0    | 0    | 0    | 0    |
| 1    | 0    | 0    |      | 0    | 0    | 0    | 0    | 1    |
| 1    | 0    | 1    |      | 1    | 0    | 0    | 1    | 0    |
| 1    | 1    | 0    |      | 1    | 1    | 0    | 1    | 1    |
| 1    | 1    | 1    |      | 1    | 1    | 1    | 0    | 0    |



#### 3.6.6.3 Combinational Logic Circuit

*Very Similar to **PLA**!*

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-13 09.40.01.png" alt="截屏2021-07-13 09.40.01" style="zoom:50%;" />

#### 3.6.6.4 Master-slave Flipflop

**What's Wrong with the Gated D-Latch?**

- 不能缓冲
- As soon as *WE(i.e. Clock)* = 1,state will change immediately and frequently

**Master-slave Flipflop(主从触发器)**

- just like a *buffer*

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-13 09.45.34.png" alt="截屏2021-07-13 09.45.34" style="zoom:50%;" />

**CLOCK = 1,** next state -/-> **master ---> slave** 

​	*that's why at the **start** of the clock cycle,the state transition happens*

**CLOCK = 0, next state ---> master** -/-> slave

> prop delay, propagation delay



## **3.7 Preview of LC-3 Data Path**

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-13 09.51.30.png" alt="截屏2021-07-13 09.51.30" style="zoom:50%;" />

Note the arrows include a cross-hatch with a number next to it.

The number represents the number of wires, corresponding to **the number of bits being** transmitted.

