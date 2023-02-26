# -------------------------------------------------------
# File:         test_piped.s
# Maintainer:   ziyue
# Date:         2021-05-11 12:42
# Purpose:      test some basic instructions of cpu core.
# -------------------------------------------------------
    lw      gp, 8(x0)           # gp = FE000000 
# I type
# 充满流水线，每一拍流出一个值
# 没有stall
    addi    a0, zero, -1        # a0 = 0xFFFF_FFFF
    slti    a1, zero, -2        # a1 = 0x0000_0000
    sltiu   a2, zero, -1        # a2 = 0x0000_0001
    xori    a3, a0, 0xFF        # a3 = 0xFFFF_FF00
    ori     a4, a1, 0xFF        # a4 = 0x0000_00FF
    andi    a5, a0, 0x1         # a5 = 0x0000_0001
    slli    a6, a0, 4           # a6 = 0xFFFF_FFF0
# 负数的算术右移和逻辑右移
    srli    a7, a0, 4           # a7 = 0x0FFF_FFFF
    srai    s2, a3, 1           # s2 = 0xFFFF_FF80
    # nop
    # nop
    addi    s2, s2, 1           # s2 = 0xFFFF_FFB1
    sw      a0, 0(gp)           # LED = 8'b1111_1111
    sw      a1, 0(gp)           # LED = 8'b0000_0000
    sw      a2, 0(gp)           # LED = 8'b0000_0001
    sw      a3, 0(gp)           # LED = 8'b0000_0000
    sw      a4, 0(gp)           # LED = 8'b1111_1111
    sw      a5, 0(gp)           # LED = 8'b0000_0001
    sw      a6, 0(gp)           # LED = 8'b1111_0000
    sw      a7, 0(gp)           # LED = 8'b1111_1111
    sw      s2, 0(gp)           # LED = 8'b1000_0001

# R Type
# test alu + sw stall 2
# test alu + other + sw，stall 1
# test alu + alu, stall 2
# test alu + other + alu, stall 1
    add     t0, a0, a2          # t0 = 0
    # nop
    # nop
    sw      t0, 0(gp)           # LED = 8'b0000_0000, alu + sw, stall 2 (insert nop, nop)
    sub     t1, a1, a2          # t1 = 0xFFFF_FFFF
    sll     t2, a2, a2          # t2 = 0x0000_0002
    slt     t3, a7, s2          # t3 = 0
    # nop
    sw      t2, 0(gp)           # LED = 8'b0001_0000, alu + other + sw, stall 1 (insert nop)
    sltu    t4, a7, s2          # t4 = 1
    srl     t5, a4, a2          # t5 = 0x0000_007F
    sra     t6, a0, a2          # t6 = 0xFFFF_FFFF
    # nop
    # nop
    and     s2, t6, t2          # s2 = 0x0000_0002 , alu + alu, stall 2
    sw      t0, 0(gp)           # LED = 8'b0000_0000
    sw      t1, 0(gp)           # LED = 8'b1111_1111
    sw      t2, 0(gp)           # LED = 8'b0000_0010
    sw      t3, 0(gp)           # LED = 8'b0000_0000
    sw      t4, 0(gp)           # LED = 8'b0000_0001
    sw      t5, 0(gp)           # LED = 8'b0111_1111
    sw      t6, 0(gp)           # LED = 8'b1111_1111
    sw      s2, 0(gp)           # LED = 8'b0000_0010


# test LW and SW
    lw      s0, 0(zero)     # s0 = 0x1234_5678
    # nop
    # nop
    slli    s0, s0, 1       # s0 = 0x2468_acf0
    # nop
    # nop
    sw      s0, 4(zero)     # (* no GPRs modified *)
    lw      a0, 4(zero)     # a0 = 0x2468_acf0
    addi    t0, zero, 1     
    # nop
    sw      a0, 0(gp)       # LED = 8'b1111_0000
    
    bne     a0, a1, bne_target
    # nop
    # nop
    # nop
    beq     zero, zero, end_b
    

# BRANCH

bne_target:
    addi    a3, zero, 0     # a3 = 0x0
    lw      s1, 0(zero)     # s1 = 0x1234_5678
    beq     a0, s1, end_b   # 不跳转，继续执行LED
    sw      a3, 0(gp)       # LED = 8'b0000_0000
    bge     s1, zero, bge_target # 跳转至bge_target
    # nop
    # nop
    # nop
    beq     zero, zero, end_b   # 不执行

bge_target:
    addi    a3, a3, 1       # a3 = 0x1
    sub     a1, zero, a0    # a1 = 0xdb97_5310
    # nop
    sw      a3, 0(gp)       # LED = 8'b0000_0001
    bltu    a0, a1, bltu_target     # 跳转至bltu_target
    # nop
    # nop
    # nop
    beq     zero, zero, end_b   # 不执行

bltu_target:
    addi    a3, a3, 1       # a3 = 0x2
    # nop
    # nop
    sw      a3, 0(gp)       # LED = 8'b0000_0010
    blt     a0, a1, blt_target      # 不跳转，继续执行beq
    # nop
    # nop
    # nop
    beq     zero, zero, end_b       # 无条件跳转至end_b
    # nop
    # nop
    # nop

blt_target:
    addi    a3, a3, 1       # 不执行
   
end_b:
    addi	t6, zero, 1     # t6 = 1
	lui		t5, 0xbabe      # t5 = 0x0babe000
    auipc   t4, 0xbabe      # t4 = 0x0babe100

end:   
    # nop
    # nop
    # nop 
    jal		x1, func        # 无条件跳转至func
    # nop
    # nop
    # nop
    sw      zero, 0(gp)     # LED = 8'b0000_0000
    jal		zero, end
    # 跳转
    
func:
    # nop
    # nop
    # nop
	sw      t6, 0(gp)       # LED = 8'b0000_0001
    jalr	zero, x1, 0     # 无条件跳转 sw zero, 0(gp)