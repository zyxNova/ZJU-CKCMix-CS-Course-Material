# Patt-Ch4 The Von Neumann Model

[TOC]

## **4.0 Central Ideas**

The central idea in the von Neumann model of computer processing is that:

-  **the program and data** are both stored as sequences of bits in the computer’s memory
- the program is executed **one instruction at a time** under the **direction of the control unit.**



## **4.1 Basic Components**

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-13 15.39.01.png" alt="截屏2021-07-13 15.39.01" style="zoom:50%;" />

​																						*Overview of Von Neumann Model*



### 4.1.1 Memory

> both computer programs and data are contained in memory

- **2 Characteristics of Memory**

  - Address
  - Content(Data)

- **2 Registers**

  - **MAR:** Memory Address Register
  - **MDR:** Memory Data Register

  <img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-13 10.03.49.png" alt="截屏2021-07-13 10.03.49" style="zoom:50%;" />

- **2 Operations**

  - LOAD: read
  - STORE: write

  <img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-13 10.01.03.png" alt="截屏2021-07-13 10.01.03" style="zoom:50%;" />



### 4.1.2 Processing Unit

**Functional Units**

- could have many functional units.Some of them special-purpose
  - e.g. multiply, square root, etc.
- **ALU** (*Arithmetic and Logic Unit*) is the simplest function unit
  - e.g. ADD,SUBSTRACT(*Arithmetic*), AND,OR,NOT(*Logic*)
  - LC-3's ALU performs ADD,AND,NOT



**Word and Word Length**

- ***instruction***: the smallest piece of work for computer to carry out
- ***word length(size)***: the **fixed size**(bits) of the data elements processed by **ALU** in one instruction
  - In short(maybe not correct), **the number of bits of one instruction**
  - usually also **width of registers**
- ***word***: the data elements to be processed
- each ISA has its own word length, depending on the intended use of the computer
  - most microprocessors today in PC,even in cell phones, have a word length of 64 bits
  - the word length for LC-3 is 16 bits, LC-3 is *word accessible*



**Registers**

- small, temporary storage
- store operands and results of functional units
  - the purpose is to save time for accessing memory,which is TOO SLOW compared to ALU computations
- Current microprocessors typically contain 32 registers, each consisting of 32 or 64 bits, depending on the architecture.
  - LC-3 has eight registers (R0, …, R7), each 16 bits. 8 registers need 3bits to identify

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-13 15.59.02.png" alt="截屏2021-07-13 15.59.02" style="zoom:50%;" />





### 4.1.3 Input and Output

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-13 10.34.28.png" alt="截屏2021-07-13 10.34.28" style="zoom:50%;" />



### 4.1.4 Control Unit

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-13 10.35.30.png" alt="截屏2021-07-13 10.35.30" style="zoom:50%;" />

> PC(*Program Counter*) = IP(*Instruction Pointer*)



## **4.2 LC-3: Example von Neumann Machine**

**Memory**

- MAR for addressing individual locations, MDR for holding the contents of a memory location
- MAR contains 16 bits, since LC-3 address space is 2^16^
- MDR contains 16 bits, since addressability is 16 bits(*a word for LC-3*)

**I/O**

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-13 16.18.56.png" alt="截屏2021-07-13 16.18.56" style="zoom:50%;" />

**Processing Unit**

- ALU: ADD,AND,NOT
- 8 registers(R0,...,R7)
- word length: 16 bits

**Control Unit**

- Finite State Machine: the most important structure, which directs all activities

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-18 15.40.06.png" alt="截屏2021-07-18 15.40.06" style="zoom:70%;" />

- CLK: specifies how long each clock cycle lasts
- IP
- PC



## **4.3 Intruction Processing**

### 4.3.1 The Instruction

#### 4.3.1.1 Some Concepts about Instruction

**Fundamental Unit**

The instruction is the fundamental unit of work.

**Specify 2 things**

- **opcode**: operation to be performed
- **operands**: data/locations to be used for operation



**Storage Form**

- encoded as **a sequence of bits**
- often have a fixed word length, such as 16 or 32 bits
- Control Unit interprets instructions, and generate control signals to carry out operations
- Operations is either executed completely, or not at all



**3 Basic Kinds**

- **Operate** instructions: operate on data
  - Arithmetic: ADD,SUBSTRACT
  - Logic: AND,OR,NOT
- **Data Movement**: move information, processing unit <-> memory or I/O
  - LD: load
  - ST: store
- **Control** instructions: alter the sequence
  - normally the next instruction executed is the instruction contained in the next memory location
  - TRAP: halt
  - BR: condition



**LC-3 Instruction**

- 16 bits(one word)
- Bits[15:12] opcode
- Bits[11:0] figure out where the operations are



#### 4.3.1.2 Example: LC-3 ADD Instruction

<img src="file:///Users/particle/Library/Application%20Support/typora-user-images/%E6%88%AA%E5%B1%8F2021-07-13%2010.17.29.png?lastModify=1626143515" style="zoom:50%;" />

[15:12] ADD *opcode*

[11:9] the destination register  

[8:6] one of the two operands

[5] format

[4:0] either a immediate or the other register



#### 4.3.1.3 Example: LC-3 LD Instruction

> LD, stands for load

- ***Addressing Mode***: formulas used for calculating the address of the memory location to be read
- **PC + offset** is a particular addressing mode
  - sign-extending the 2’s complement integer contained in bits [8:0] to 16 bits
  - adding it to the current contents of PC *(Noting:PC has been already +1)*

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-13 16.47.36.png" alt="截屏2021-07-13 16.47.36" style="zoom:50%;" />

*add 198 to the contents of the PC to form the address of a memory location*

*load the contents of that memory location into R2.*



### 4.3.2 The Instruction Cycle

- ***Instruction Cycle***: The entire sequence of steps needed to process an instruction
- consists of **six sequential *phases***, each phase requiring zero or more steps (clock cycle).
- zero means not all instructions require all six phases.
  - ADD: FETCH -> DECODE -> FETCH OPERANDS -> EXECUTE, excluding EVALUATE ADRESS and STORE RESULT
  - LD: don't need EXECUTE

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-13 10.41.12.png" alt="截屏2021-07-13 10.41.12" style="zoom:50%;" />

#### 4.3.2.1 FETCH*

> machine cycle = clock cycle



<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-13 16.59.14.png" alt="截屏2021-07-13 16.59.14" style="zoom:50%;" />



#### 4.3.2.2 DECODE*

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-13 17.01.54.png" alt="截屏2021-07-13 17.01.54" style="zoom:50%;" />



#### 4.3.2.3 EVALUATE ADDRESS

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-13 11.05.48.png" alt="截屏2021-07-13 11.05.48" style="zoom:50%;" />

- Not all instructions access memory to load or store data.
- For example, the ADD and AND instructions in the LC-3 obtain their source operands from **registers** or from the **instruction itself** and store the result of the ADD or AND instruction in a register.



#### 4.3.2.4 FETCH OPERANDS

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-13 11.06.12.png" alt="截屏2021-07-13 11.06.12" style="zoom:50%;" />



#### 4.3.2.5 EXECUTE

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-13 11.06.32.png" alt="截屏2021-07-13 11.06.32" style="zoom:50%;" />

#### 4.3.2.6 STORE RESULT

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-13 11.06.57.png" alt="截屏2021-07-13 11.06.57" style="zoom:50%;" />



- In the case of the ADD instruction, in many computers this action is performed during the EXECUTE phase. 
- That is, in many computers, including the LC-3, an ADD instruction can fetch its source operands, perform the ADD in the ALU, and store the result in the destination register **all in a single clock cycle.**
- A separate STORE RESULT phase **is not needed**.



## **4.4 First Program: Multiplication**

<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-13 11.22.14.png" alt="截屏2021-07-13 11.22.14" style="zoom:50%;" />



<img src="/Users/particle/Library/Application Support/typora-user-images/截屏2021-07-13 11.40.26.png" alt="截屏2021-07-13 11.40.26" style="zoom:50%;" />





