# 假定输入本身是规格化的IEE754单精度浮点数
# 题目要求将结果放在a0中。我额外设置a1作为overflow信号。若a1 = 0则表明计算正常，若a1 = 1则表明发生上溢出
# 由于使用t0~t6足以完成所有功能，所以没有使用stack。
# 没有舍入操作，所以结果可能不精确。
    lui     a0, 0x40900
    lui     a1, 0xC0900

fp_mul:
# input in a0, a1, put result in a0 ret
# first pruning A = 0, B = 0
    beq     a1, zero, ASSIGN1
    beq     a0, zero, EXIT
    # t0 = expA, t1 = expB，不减127
    # t0 放result exp
    lui     t4, 0x7F800
    and     t0, a0, t4          
    and     t1, a1, t4           
    srli    t0, t0, 23          # t0 = expA, reg[7:0]
    srli    t1, t1, 23          # t1 = expB, reg[7:0]
    add     t0, t0, t1
    addi    t0, t0, -127
    slti    t3, t0, 255
    beq     t3, zero, OVERFLOW
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
    # t2作为Mcand, t3作为Mer
    # 24位*24位，结果是48位，用{t1(低24位), t5(低24位)}拼接成product寄存器
    # t3 >> 1
    add     t1, zero, zero
    add     t5, zero, zero
    # t4作为计数器
    add     t4, zero, zero
LOOP:
    andi    t6, t3, 1
    beq     t6, zero, SHIFT
    add     t1, t1, t2          # Mcand + Product[47:24] -> Product[47:24]
SHIFT:
    srli    t3, t3, 1
    srli    t5, t5, 1
    andi    t6, t1, 1
    slli    t6, t6, 23          # t5 >> 1, t1[0]移进 t5[23], t1 >> 1
    add     t5, t5, t6
    srli    t1, t1, 1
    addi    t4, t4, 1
    addi    t6, zero, 24
    beq     t4, t6, OUT
    jal     x0, LOOP
OUT:
    # a0[31], sign bit
    slt     t2, a0, zero
    slt     t3, a1, zero
    xor     a0, t2, t3          # 异或为1,则a0,a1异号，结果是负数
    slli    a0, a0, 31
    # t0放的exp
    slli    t0, t0, 23
    add     a0, a0, t0
    # 取t1的低22位和t5的[23]位作为frac
    # 没有rounding，因此可能会存在误差
    lui     t4, 0x00300
    lui     t6, 1
    addi    t6, t6, -1
    add     t4, t4, t6
    and     t1, t1, t4
    slli    t1, t1, 1
    add     a0, a0, t1
    lui     t4, 0x00400
    and     t5, t5, t4
    srli    t5, t5, 22
    add     a1, t5, t5
    add     a1, zero, zero
    jal     x0, EXIT

OVERFLOW:
    addi    a1, zero, 1
    jal     x0, EXIT

ASSIGN1:
    add     a0, zero, zero     
    beq     zero, zero, EXIT
EXIT: