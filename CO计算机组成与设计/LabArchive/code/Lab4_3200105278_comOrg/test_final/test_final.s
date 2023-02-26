# -------------------------------------------------------
# File:         test_scpu1.s
# Maintainer:   ziyue
# Date:         2021-02-24 13:33
# Purpose:      test some basic instructions of cpu core.
# -------------------------------------------------------
    add    a0, zero, zero
    add    a0, zero, zero
    add    a0, zero, zero

test_csrr:
    addi    a0, zero, 0x138
    csrrw   zero, mtvec, a0 # set mtvec = 异常处理程序的首地址
    addi    a0, zero, 8     
    slli    a1, a0, 4
    or      a0, a0, a1
    slli    a1, a1, 4
    or      a0, a0, a1
    addi    a0, a0, 0x55
    csrrw   zero, mie, a0   # set mie[11,7,6,4,3,2] = 1
    addi    s0, zero, 255   
    csrrsi  s0, mstatus, 8  # set mstatus.mie = 1, s0重置为0
    

# test I type
    addi    a0, zero, 7     # a0 = 0x0000_0007
    slti    a1, a0, 9       # a1 = 0x0000_0001
    sltiu   a2, a0, 8       # a2 = 0x0000_0001  
    xori    a3, a0, 8       # a3 = 0x0000_000F  
    ori     a4, a0, 6       # a4 = 0x0000_0007  
    andi    a5, a0, 6       # a5 = 0x0000_0006  
    slli    a6, a0, 2       # a6 = 0x0000_001C  
    srli    a7, a0, 2       # a7 = 0x0000_0001  
    srai    a7, a0, 0       # a7 = 0x0000_0007  

# test R type
    add     s1, a0, a0      # s1 = 0x0000_000E  
    sub     s2, a6, a0      # s2 = 0x0000_0015  
    sll     s3, a6, a3      # s3 = 0x000E_0000  
    slt     s4, a0, s3      # s4 = 0x0000_0001  
    xor     s5, a0, a3      # s5 = 0x0000_0008 
    srl     s6, a0, a2      # s6 = 0x0000_0003  
    or      s7, a0, a4      # s7 = 0x0000_0007  
    and     s8, a0, a2      # s8 = 0x0000_0001  

# test LW and SW
    lw      s0, 0(zero)     # s0 = 0x1234_5678  
    slli    s0, s0, 1       # s0 = 0x2468_acf0  
    sw      s0, 4(zero)     # (* no GPRs modified *) 
    lw      a0, 4(zero)     # a0 = 0x2468_acf0  
    
    bne     a0, a1, bne_target  
    beq     zero, zero, end     
    

# test JUMP and BRANCH
bne_target:
    addi    a3, zero, 0     # a3 = 0x0  
    lw      s1, 0(zero)     # s1 = 0x1234_5678  
    beq     a0, s1, end     
    addi    s1, a0, 2       # a0 = 0x2468_acf2  
    bge     a2, zero, bge_target    
    beq     zero, zero, end         

bge_target:
    addi    a3, a3, 1       # a3 = 0x1  
    sub     a1, zero, a0    # a1 = 0xdb97_5310  
    bltu    a0, a1, bltu_target     
    beq     zero, zero, end         

bltu_target:
    addi    a3, a3, 1       # a3 = 0x2  
    blt     a0, a1, blt_target      
    beq     zero, zero, end         

blt_target:
    addi    a3, a3, 1               
   
end:
    addi    zero, zero, 0             
    # beq     zero, zero, end         

# test LED
    lw      t0, 8(x0)           # t0 = FE00000 
    lw      t1, 0(t0)           # t1 = LED_data 
    addi    t1, t1, 2           # t1 = t1 + 2
    sw      t1, 0(t0)           # t1 -> LED 
    lw      t2, 0(t0)

# test JAL, LUI, JALR and AUIPC
    jal     x1, test_jal
    add     x1, x0, x0
    beq     x1, x0, EXIT
test_jal:
    lui     t3, 0x12345
    auipc   t4, 0x32001
    jalr    x0, x1, 0
EXIT:

test_ecall:
    addi    a0, zero, 0
    addi    a0, a0, 1
    addi    a0, a0, 1
    ecall
    addi    a0, zero, 0
test_illegal_inst:  
    addi    a0, zero, 0 # 修改成0x000000ff,成为非法指令
    addi    a0, zero, 0 # 缓冲
test_pc_misalign:
    beq     zero, zero, test_lw_misalign    # 修改成0x00000163, pc不与4对齐
test_lw_misalign:
    addi    t0, zero, 3
    lw      t1, 0(t0)
test_sw_misalign:
    addi    t0, zero, 3
    sw      a0, 0(t0)
    
# 无限循环保护下方特权程序不被访问
loop:   
    addi    s0, zero, 15
    addi    s0, s0, 15
    jal     zero, loop

# 所有异常/中断程序的起始地址
trap_m: 
    csrrs   a0, mcause, zero    # a0 = mcause
    slt     a1, a0, zero        # 解析是异常还是中断，a1 = 1为中断，a1 = 0为异常
    bne     a1, x0, handle_int
    # exception
    add     t0, zero, zero
    beq     a0, t0, handle_pc_misalign
    # mepc = mepc + 4
    csrrs   t0, mepc, zero
    addi    t0, t0, 4
    csrrw   zero, mepc, t0
    addi    t0, zero, 11
    beq     a0, t0, handle_ecall
    addi    t0, zero, 2
    beq     a0, t0, handle_illop
    addi    t0, zero, 4
    beq     a0, t0, handle_lw_misalign
    addi    t0, zero, 6
    beq     a0, t0, handle_sw_misalign
handle_pc_misalign:
    csrrs   t5, mtval, zero
    andi    t3, t5, 3
    addi    t4, zero, 1
    bne     t3, t4, check2
    addi    t5, t5, 3
    jal     x0, correctPC
check2:
    addi    t4, t4, 1
    bne     t3, t4, check3
    addi    t5, t5, 2
    jal     x0, correctPC
check3:
    addi    t5, t5, 1
correctPC:
    csrrw   zero, mepc, t5
    jal     x0, out_int
handle_int:
    addi    a0, zero, 0
    addi    a1, zero, 14
timLoop:
    addi    a0, a0, 1
    blt     a0, a1, timLoop
handle_lw_misalign:
handle_sw_misalign:
handle_illop:
handle_ecall:
out_int:
    mret