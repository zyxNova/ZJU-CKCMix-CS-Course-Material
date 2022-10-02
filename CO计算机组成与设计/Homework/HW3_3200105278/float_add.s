# 说明：
# 测试时，应当分别注释其他两种输入情况。
# 假定输入本身是规格化的IEE754单精度浮点数
# 题目要求将结果放在a0中。我额外设置a1作为overflow信号。若a1 = 0则表明计算正常，若a1 = 1则表明发生上溢出
# 由于使用t0~t6足以完成所有功能，所以没有使用stack。
# 没有进行舍入操作。
    lui     a0, 0x40900
    lui     a1, 0xC0900
    # input a0 = 4.5, a1 = -4.5, expected result : a0 = 0

    lui     a0, 0xC0A00
    lui     a1, 0xC0900
    # input a0 = -5.0, a1 = -4.5, expected result : a0 = 0xC1180000

    lui     a0, 0x7F7FF      
    lui     a1, 0x7F7F0     
    # expected result : a1 = 1, indicating overflow

fp_add:
    # input in a0, a1 (认为输入的a0和a1都是规格化的，也即不考虑exp = 0的情况）
    # output in a0
    # first pruning A = 0, B = 0 or A = -B
    beq     a1, zero, EXIT
    beq     a0, zero, ASSIGN1   # if a0 = 0, a0 = a1
    lui     t4, 0x80000
    or      t0, a0, t4
    or      t1, a1, t4      
    beq     t0, t1, ASSIGN2   # if a0 = -a1, a0 = 0
    # t0 <- 补码表示的expA, t1 <- 补码表示的expB
    # t2 <- 补码表示的fracA, t3 <- 补码表示的fracB
    # t4 <- bit mask 0x007FFFFF, 由lui和addi得到
    lui     t4, 0x007FF         
    lui     t5, 1               # t5 = 0x00001_000
    addi    t5, t5, -1          # t5 = 0x00000_FFF
    add     t4, t4, t5          # t4 = 0x007FF_FFF
    and     t2, a0, t4          # t2 = fracA
    and     t3, a1, t4          # t3 = frabB
    # t4 = 0x00800000, 补充小数点前的1 
    lui     t4, 0x00800         # t4 = 0x00800_000
    add     t2, t2, t4          # t2 = 1fracA
    add     t3, t3, t4          # t3 = 1fracB
    bge     a0, zero CHECKA1    
    sub     t2, zero, t2        # if A < 0, 小数部分取补码
CHECKA1:
    bge     a1, zero GETEXP
    sub     t3, zero, t3        # if B < 0, 小数部分取补码
GETEXP:
    # t4 = bit mask 0111_1111_1000_0_0_0_0_0 = 0x7F80_0000
    lui     t4, 0x7F800         # t4 = 0x7F80_0000
    and     t0, a0, t4          
    and     t1, a1, t4           
    srli    t0, t0, 23          # t0 = expA, reg[7:0]
    srli    t1, t1, 23          # t1 = expB, reg[7:0]
    sub     t5, t1, t0          # t5 = expB - expA
    blt     t5, zero BSRL
    sra     t2, t2, t5          # t2 = fracA >>> (expB - expA)
    beq     zero, zero, GETCEXP
BSRL:
    sub     t5, zero, t5        # t5 = -t5
    sra     t3, t3, t5          # t3 = fracB >>> (expA - expB)
    add     t1, t0, zero
GETCEXP:
    addi    t1, t1, -127        # t1 = 结果的实际阶码, 范围是[-126, 127]
# now t1 = result exp, t2 = 1fracA, t3 = 1fracB
# 均为补码表示，而且放在reg的低位
    add     t5, t2, t3          # t5 = fracA + fracB
# 以下是规格化
# 如果t5[25:24] == 2'b10 或 2'b01 则右归
    lui     t4, 12888           # t4 = bitmask 0x0300_0000
    and     t6, t5, t4          # t6 = t5[25:24]
    srli    t6, t6, 24
    addi    t6, t6, -1
    beq     t6, zero RNORM      # t6 == 2'b01
    addi    t6, t6, -1
    beq     t6, zero RNORM      # t6 == 2'b10
    jal     x0, CONTINUE
RNORM:
    srai    t5, t5, 1
    addi    t1, t1, 1
    jal     x0, OUTLOOP
CONTINUE:
# 如果t5[25:23] == 3'b000, 左归，直至 00.0XXX -> 00.1XX
    lui     t4, 14336           # t4 = bitmask 0x0380_0000
    addi    t0, zero, 7
LOOP0:
    and     t6, t5, t4          # t6 = t5[25:23]
    srli    t6, t6, 23
    beq     t6, zero, DOLEFT    # if t6 != 3'b000, then jump out of loop
    bne     t6, t0, OUTLOOP
DOLEFT:
    slli    t5, t5, 1
    addi    t1, t1, -1
    jal     LOOP0
OUTLOOP:
# now t1 = resExp, 检测上下溢出
# 计算完成后 t1 取值应该在[-126, 127]之间。如果t1 == -127,则为下溢出，结果置0；如果t1 == 128,则为上溢出，错误
# 先判断上溢出
    addi    t0, zero, 128
    bge     t1, t0, OVERFLOW
    addi    t0, zero, -126
    bge     t1, t0, GETRES
    jal     x0, ASSIGN2
OVERFLOW:
    addi    a1, zero ,1         # a1 = 1 表明是overflow
    jal     x0, EXIT
GETRES:
# t1 = exp, reg[7:0], 补码表示，未加127
# t5 = frac, reg[23:0], 补码表示
# a0 放计算结果
    slt     a0, t5, zero
    slli    a0, a0, 31          # a0[31], sign bit
    bge     t1, zero, ADD127
    sub     t1, zero, t1
ADD127:
# [30:23]
    addi    t1, t1, 127
    slli    t1, t1, 23
    add     a0, a0, t1
    bge     t5, zero, ADDFRAC
    sub     t5, zero, t5
ADDFRAC:
    lui     t4, 2048
    sub     t5, t5, t4            
    add     a0, a0, t5
    add     a1, zero, zero
    jal     x0, EXIT
    
ASSIGN1:
    add     a0, zero, a1        
    beq     zero, zero, EXIT
ASSIGN2:
    add     a0, zero, zero
    beq     zero, zero, EXIT
EXIT: