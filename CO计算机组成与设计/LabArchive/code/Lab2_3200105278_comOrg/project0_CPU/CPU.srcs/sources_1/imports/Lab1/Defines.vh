`define VGA_DBG_Core_Arguments \
    .dbg_pc(dbg_pc), \
    .dbg_inst(dbg_inst), \
    .dbg_rs1(dbg_rs1), \
    .dbg_rs1_val(dbg_rs1_val), \
    .dbg_rs2(dbg_rs2), \
    .dbg_rs2_val(dbg_rs2_val), \
    .dbg_rd(dbg_rd), \
    .dbg_reg_i_data(dbg_reg_i_data), \
    .dbg_reg_wen(dbg_reg_wen), \
    .dbg_is_imm(dbg_is_imm), \
    .dbg_is_auipc(dbg_is_auipc), \
    .dbg_is_lui(dbg_is_lui), \
    .dbg_imm(dbg_imm), \
    .dbg_a_val(dbg_a_val), \
    .dbg_b_val(dbg_b_val), \
    .dbg_alu_ctrl(dbg_alu_ctrl), \
    .dbg_cmp_ctrl(dbg_cmp_ctrl), \
    .dbg_alu_res(dbg_alu_res), \
    .dbg_cmp_res(dbg_cmp_res), \
    .dbg_is_branch(dbg_is_branch), \
    .dbg_is_jal(dbg_is_jal), \
    .dbg_is_jalr(dbg_is_jalr), \
    .dbg_do_branch(dbg_do_branch), \
    .dbg_pc_branch(dbg_pc_branch), \
    .dbg_mem_wen(dbg_mem_wen), \
    .dbg_mem_ren(dbg_mem_ren), \
    .dbg_dmem_o_data(dbg_dmem_o_data), \
    .dbg_dmem_i_data(dbg_dmem_i_data), \
    .dbg_dmem_addr(dbg_dmem_addr), \
    .dbg_x0(dbg_x0), \
    .dbg_ra(dbg_ra), \
    .dbg_sp(dbg_sp), \
    .dbg_gp(dbg_gp), \
    .dbg_tp(dbg_tp), \
    .dbg_t0(dbg_t0), \
    .dbg_t1(dbg_t1), \
    .dbg_t2(dbg_t2), \
    .dbg_s0(dbg_s0), \
    .dbg_s1(dbg_s1), \
    .dbg_a0(dbg_a0), \
    .dbg_a1(dbg_a1), \
    .dbg_a2(dbg_a2), \
    .dbg_a3(dbg_a3), \
    .dbg_a4(dbg_a4), \
    .dbg_a5(dbg_a5), \
    .dbg_a6(dbg_a6), \
    .dbg_a7(dbg_a7), \
    .dbg_s2(dbg_s2), \
    .dbg_s3(dbg_s3), \
    .dbg_s4(dbg_s4), \
    .dbg_s5(dbg_s5), \
    .dbg_s6(dbg_s6), \
    .dbg_s7(dbg_s7), \
    .dbg_s8(dbg_s8), \
    .dbg_s9(dbg_s9), \
    .dbg_s10(dbg_s10), \
    .dbg_s11(dbg_s11), \
    .dbg_t3(dbg_t3), \
    .dbg_t4(dbg_t4), \
    .dbg_t5(dbg_t5), \
    .dbg_t6(dbg_t6),


`define VGA_DBG_VgaDebugger_Arguments \
    .pc(dbg_pc), \
    .inst(dbg_inst), \
    .rs1(dbg_rs1), \
    .rs1_val(dbg_rs1_val), \
    .rs2(dbg_rs2), \
    .rs2_val(dbg_rs2_val), \
    .rd(dbg_rd), \
    .reg_i_data(dbg_reg_i_data), \
    .reg_wen(dbg_reg_wen), \
    .is_imm(dbg_is_imm), \
    .is_auipc(dbg_is_auipc), \
    .is_lui(dbg_is_lui), \
    .imm(dbg_imm), \
    .a_val(dbg_a_val), \
    .b_val(dbg_b_val), \
    .alu_ctrl(dbg_alu_ctrl), \
    .cmp_ctrl(dbg_cmp_ctrl), \
    .alu_res(dbg_alu_res), \
    .cmp_res(dbg_cmp_res), \
    .is_branch(dbg_is_branch), \
    .is_jal(dbg_is_jal), \
    .is_jalr(dbg_is_jalr), \
    .do_branch(dbg_do_branch), \
    .pc_branch(dbg_pc_branch), \
    .mem_wen(dbg_mem_wen), \
    .mem_ren(dbg_mem_ren), \
    .dmem_o_data(dbg_dmem_o_data), \
    .dmem_i_data(dbg_dmem_i_data), \
    .dmem_addr(dbg_dmem_addr), \
    .x0(dbg_x0), \
    .ra(dbg_ra), \
    .sp(dbg_sp), \
    .gp(dbg_gp), \
    .tp(dbg_tp), \
    .t0(dbg_t0), \
    .t1(dbg_t1), \
    .t2(dbg_t2), \
    .s0(dbg_s0), \
    .s1(dbg_s1), \
    .a0(dbg_a0), \
    .a1(dbg_a1), \
    .a2(dbg_a2), \
    .a3(dbg_a3), \
    .a4(dbg_a4), \
    .a5(dbg_a5), \
    .a6(dbg_a6), \
    .a7(dbg_a7), \
    .s2(dbg_s2), \
    .s3(dbg_s3), \
    .s4(dbg_s4), \
    .s5(dbg_s5), \
    .s6(dbg_s6), \
    .s7(dbg_s7), \
    .s8(dbg_s8), \
    .s9(dbg_s9), \
    .s10(dbg_s10), \
    .s11(dbg_s11), \
    .t3(dbg_t3), \
    .t4(dbg_t4), \
    .t5(dbg_t5), \
    .t6(dbg_t6),
    
    
`define VGA_DBG_Core_Declaration \
    wire [31:0] dbg_pc; \
    wire [31:0] dbg_inst; \
    wire [4:0] dbg_rs1; \
    wire [31:0] dbg_rs1_val; \
    wire [4:0] dbg_rs2; \
    wire [31:0] dbg_rs2_val; \
    wire [4:0] dbg_rd; \
    wire [31:0] dbg_reg_i_data; \
    wire dbg_reg_wen; \
    wire dbg_is_imm; \
    wire dbg_is_auipc; \
    wire dbg_is_lui; \
    wire [31:0] dbg_imm; \
    wire [31:0] dbg_a_val; \
    wire [31:0] dbg_b_val; \
    wire [3:0] dbg_alu_ctrl; \
    wire [2:0] dbg_cmp_ctrl; \
    wire [31:0] dbg_alu_res; \
    wire dbg_cmp_res; \
    wire dbg_is_branch; \
    wire dbg_is_jal; \
    wire dbg_is_jalr; \
    wire dbg_do_branch; \
    wire [31:0] dbg_pc_branch; \
    wire dbg_mem_wen; \
    wire dbg_mem_ren; \
    wire [31:0] dbg_dmem_o_data; \
    wire [31:0] dbg_dmem_i_data; \
    wire [31:0] dbg_dmem_addr;
    
    
    
`define VGA_DBG_RegFile_Declaration \
    wire [31:0] dbg_x0; \
    wire [31:0] dbg_ra; \
    wire [31:0] dbg_sp; \
    wire [31:0] dbg_gp; \
    wire [31:0] dbg_tp; \
    wire [31:0] dbg_t0; \
    wire [31:0] dbg_t1; \
    wire [31:0] dbg_t2; \
    wire [31:0] dbg_s0; \
    wire [31:0] dbg_s1; \
    wire [31:0] dbg_a0; \
    wire [31:0] dbg_a1; \
    wire [31:0] dbg_a2; \
    wire [31:0] dbg_a3; \
    wire [31:0] dbg_a4; \
    wire [31:0] dbg_a5; \
    wire [31:0] dbg_a6; \
    wire [31:0] dbg_a7; \
    wire [31:0] dbg_s2; \
    wire [31:0] dbg_s3; \
    wire [31:0] dbg_s4; \
    wire [31:0] dbg_s5; \
    wire [31:0] dbg_s6; \
    wire [31:0] dbg_s7; \
    wire [31:0] dbg_s8; \
    wire [31:0] dbg_s9; \
    wire [31:0] dbg_s10; \
    wire [31:0] dbg_s11; \
    wire [31:0] dbg_t3; \
    wire [31:0] dbg_t4; \
    wire [31:0] dbg_t5; \
    wire [31:0] dbg_t6;