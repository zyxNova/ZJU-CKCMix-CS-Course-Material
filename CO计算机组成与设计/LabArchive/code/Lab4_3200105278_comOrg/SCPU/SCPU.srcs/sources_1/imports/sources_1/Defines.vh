/*
 * Description:
 *   Some macro definations, contains
 *   1. opcode used in decoder
 *   2. some control signals outputed by decoder
 *   3. CSR related
 *   4. some other definations
 *   This file is included by almost all other files about CPU
 */


// doc says 'nop' is 'addi zero, zero, 0'
`define NOP_INST 32'h00000013

// opcode[6:2]
// 因为所有指令opcode[1:0]都是2'b11，故省略
`define OPCODE_ALURR     5'b01100 //R: ALU R-R
`define OPCODE_ALURI     5'b00100 //I: ALU R-I
`define OPCODE_LOAD      5'b00000 //I: LOAD
`define OPCODE_JALR      5'b11001 //I: JALR
`define OPCODE_STORE     5'b01000 //S: STORE
`define OPCODE_BRANCH    5'b11000 //B: BRANCH
`define OPCODE_JAL       5'b11011 //UJ: JAL
`define OPCODE_LUI       5'b01101 //U: LUI
`define OPCODE_AUIPC     5'b00101 //U: AUIPC
`define OPCODE_SYSTEM    5'b11100 //I: SYSTEM

//这些可能暂时用不到
`define OPCODE_FMADD     5'b10000
`define OPCODE_LOAD_FP   5'b00001
`define OPCODE_STORE_FP  5'b01001
`define OPCODE_FMSUB     5'b10001
`define OPCODE_FNMSUB    5'b10010
`define OPCODE_MISC_MEM  5'b00011
`define OPCODE_AMO       5'b01011
`define OPCODE_NMADD     5'b10011
`define OPCODE_OP_FP     5'b10100
`define OPCODE_OP_IMM_32 5'b00110
`define OPCODE_OP_32     5'b01110

// OP - funct3, 作用于 ALU RR 和 ALU RI
`define OP_ADD  3'b000 // inst[30] ? SUB : ADD
`define OP_SLL  3'b001
`define OP_SLT  3'b010
`define OP_SLTU 3'b011
`define OP_XOR  3'b100
`define OP_SRL  3'b101 // inst[30] ? SRA : SRL
`define OP_OR   3'b110
`define OP_AND  3'b111

//immType[2:0]
`define IMM12_I_S 3'b000 //I type imm12 signed
`define IMM12_I_U 3'b001 //I type imm12 unsigned
`define IMM12_S   3'b010 //S type imm12
`define IMM12_SB  3'b011 //SB type imm12
`define IMM20_UJ  3'b100 //UJ type imm20
`define IMM20_U   3'b101 //U type imm20

// BRANCH - funct3
`define BRANCH_EQ  3'b000
`define BRANCH_NE  3'b001
`define BRANCH_LT  3'b100
`define BRANCH_GE  3'b101
`define BRANCH_LTU 3'b110
`define BRANCH_GEU 3'b111

// SYSTEM - funct3
`define SYSTEM_E      3'b000 // ecall & ebreak
`define SYSTEM_RET    3'b000 // mret
`define SYSTEM_CSRRW  3'b001
`define SYSTEM_CSRRS  3'b010
`define SYSTEM_CSRRC  3'b011
`define SYSTEM_CSRRWI 3'b101
`define SYSTEM_CSRRSI 3'b110
`define SYSTEM_CSRRCI 3'b111

// alu_ctrl
`define ALU_CTRL_BITS 4
`define ALU_ADD  `ALU_CTRL_BITS'd0
`define ALU_SUB  `ALU_CTRL_BITS'd1
`define ALU_SLL  `ALU_CTRL_BITS'd2
`define ALU_SLT  `ALU_CTRL_BITS'd3
`define ALU_SLTU `ALU_CTRL_BITS'd4
`define ALU_XOR  `ALU_CTRL_BITS'd5
`define ALU_SRL  `ALU_CTRL_BITS'd6
`define ALU_SRA  `ALU_CTRL_BITS'd7
`define ALU_OR   `ALU_CTRL_BITS'd8
`define ALU_AND  `ALU_CTRL_BITS'd9

// cmp_ctrl
`define CMP_CTRL_BITS 3
`define CMP_EQ  `CMP_CTRL_BITS'd0
`define CMP_NE  `CMP_CTRL_BITS'd1
`define CMP_LT  `CMP_CTRL_BITS'd2
`define CMP_LTU `CMP_CTRL_BITS'd3
`define CMP_GE  `CMP_CTRL_BITS'd4
`define CMP_GEU `CMP_CTRL_BITS'd5

// csr_ctrl
`define CSR_CTRL_BITS 2
`define CSR_CTRL_W `CSR_CTRL_BITS'd0
`define CSR_CTRL_S `CSR_CTRL_BITS'd1
`define CSR_CTRL_C `CSR_CTRL_BITS'd2

// csr index
`define	CSR_MSTATUS       12'h300
`define CSR_MIE           12'h304
`define CSR_MIP           12'h344
`define CSR_MEPC          12'h341
`define CSR_MCAUSE        12'h342
`define CSR_MTVAL         12'h343
`define CSR_MTVEC         12'h305

// interrupt cause
`define CSR_CAUSE_M_SOFT_INT              32'h8000_0003 // 这个可以忽略
`define CSR_CAUSE_M_TIMER_INT             32'h8000_0007
`define CSR_CAUSE_M_EXTERNAL_INT          32'h8000_000b
// exception cause
`define CSR_CAUSE_INST_ADDR_MISALIGN      32'h0000_0000
`define CSR_CAUSE_ILLEGAL_INST            32'h0000_0002
`define CSR_CAUSE_LOAD_ADDR_MISALIGN      32'h0000_0004
`define CSR_CAUSE_STORE_ADDR_MISALIGN     32'h0000_0006
`define CSR_CAUSE_ECALL_FROM_M            32'h0000_000B
`define CSR_CAUSE_INST_PAGE_FAULT         32'h0000_000C
`define CSR_CAUSE_LOAD_PAGE_FAULT         32'h0000_000D
`define CSR_CAUSE_STORE_PAGE_FAULT        32'h0000_000F

// csr write mask
`define CSR_MSTATUS_WRITE_MASK 32'h0000_0088
`define CSR_MIE_WRITE_MASK     32'h0000_0888
`define CSR_MIP_WRITE_MASK     32'h0000_0888
`define CSR_MEPC_WRITE_MASK    32'hffff_fffc
`define CSR_MCAUSE_WRITE_MASK  32'hffff_ffff
`define CSR_MTVAL_WRITE_MASK   32'hffff_ffff
`define CSR_MTVEC_WRITE_MASK   32'hffff_fffc

// mstatus
`define STATUS_CTRL_BITS 1
`define STATUS_ENTER `CSR_CTRL_BITS'd0
`define STATUS_RET `CSR_CTRL_BITS'd1

// generated code

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
    .csr_wen(dbg_csr_wen), \
    .csr_ind(dbg_csr_ind), \
    .csr_ctrl(dbg_csr_ctrl), \
    .csr_r_data(dbg_csr_r_data), \
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
    .t6(dbg_t6), \
    .mstatus_o(dbg_mstatus_o), \
    .mcause_o(dbg_mcause_o), \
    .mepc_o(dbg_mepc_o), \
    .mtval_o(dbg_mtval_o), \
    .mtvec_o(dbg_mtvec_o), \
    .mie_o(dbg_mie_o), \
    .mip_o(dbg_mip_o),


`define VGA_DBG_CoreOthers_Ports \
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
    .dbg_dmem_addr(dbg_dmem_addr),



`define VGA_DBG_CoreOthers_Outputs \
    output wire [31:0] dbg_pc, \
    output wire [31:0] dbg_inst, \
    output wire [4:0] dbg_rs1, \
    output wire [31:0] dbg_rs1_val, \
    output wire [4:0] dbg_rs2, \
    output wire [31:0] dbg_rs2_val, \
    output wire [4:0] dbg_rd, \
    output wire [31:0] dbg_reg_i_data, \
    output wire dbg_reg_wen, \
    output wire dbg_is_imm, \
    output wire dbg_is_auipc, \
    output wire dbg_is_lui, \
    output wire [31:0] dbg_imm, \
    output wire [31:0] dbg_a_val, \
    output wire [31:0] dbg_b_val, \
    output wire [3:0] dbg_alu_ctrl, \
    output wire [2:0] dbg_cmp_ctrl, \
    output wire [31:0] dbg_alu_res, \
    output wire dbg_cmp_res, \
    output wire dbg_is_branch, \
    output wire dbg_is_jal, \
    output wire dbg_is_jalr, \
    output wire dbg_do_branch, \
    output wire [31:0] dbg_pc_branch, \
    output wire dbg_mem_wen, \
    output wire dbg_mem_ren, \
    output wire [31:0] dbg_dmem_o_data, \
    output wire [31:0] dbg_dmem_i_data, \
    output wire [31:0] dbg_dmem_addr, \


`define VGA_DBG_Core_Outputs \
    output wire [31:0] dbg_pc, \
    output wire [31:0] dbg_inst, \
    output wire [4:0] dbg_rs1, \
    output wire [31:0] dbg_rs1_val, \
    output wire [4:0] dbg_rs2, \
    output wire [31:0] dbg_rs2_val, \
    output wire [4:0] dbg_rd, \
    output wire [31:0] dbg_reg_i_data, \
    output wire dbg_reg_wen, \
    output wire dbg_is_imm, \
    output wire dbg_is_auipc, \
    output wire dbg_is_lui, \
    output wire [31:0] dbg_imm, \
    output wire [31:0] dbg_a_val, \
    output wire [31:0] dbg_b_val, \
    output wire [3:0] dbg_alu_ctrl, \
    output wire [2:0] dbg_cmp_ctrl, \
    output wire [31:0] dbg_alu_res, \
    output wire dbg_cmp_res, \
    output wire dbg_is_branch, \
    output wire dbg_is_jal, \
    output wire dbg_is_jalr, \
    output wire dbg_do_branch, \
    output wire [31:0] dbg_pc_branch, \
    output wire dbg_mem_wen, \
    output wire dbg_mem_ren, \
    output wire [31:0] dbg_dmem_o_data, \
    output wire [31:0] dbg_dmem_i_data, \
    output wire [31:0] dbg_dmem_addr, \
    output wire dbg_csr_wen, \
    output wire [11:0] dbg_csr_ind, \
    output wire [1:0] dbg_csr_ctrl, \
    output wire [31:0] dbg_csr_r_data, \
    output wire [31:0] dbg_x0, \
    output wire [31:0] dbg_ra, \
    output wire [31:0] dbg_sp, \
    output wire [31:0] dbg_gp, \
    output wire [31:0] dbg_tp, \
    output wire [31:0] dbg_t0, \
    output wire [31:0] dbg_t1, \
    output wire [31:0] dbg_t2, \
    output wire [31:0] dbg_s0, \
    output wire [31:0] dbg_s1, \
    output wire [31:0] dbg_a0, \
    output wire [31:0] dbg_a1, \
    output wire [31:0] dbg_a2, \
    output wire [31:0] dbg_a3, \
    output wire [31:0] dbg_a4, \
    output wire [31:0] dbg_a5, \
    output wire [31:0] dbg_a6, \
    output wire [31:0] dbg_a7, \
    output wire [31:0] dbg_s2, \
    output wire [31:0] dbg_s3, \
    output wire [31:0] dbg_s4, \
    output wire [31:0] dbg_s5, \
    output wire [31:0] dbg_s6, \
    output wire [31:0] dbg_s7, \
    output wire [31:0] dbg_s8, \
    output wire [31:0] dbg_s9, \
    output wire [31:0] dbg_s10, \
    output wire [31:0] dbg_s11, \
    output wire [31:0] dbg_t3, \
    output wire [31:0] dbg_t4, \
    output wire [31:0] dbg_t5, \
    output wire [31:0] dbg_t6, \
    output wire [31:0] dbg_mstatus_o, \
    output wire [31:0] dbg_mcause_o, \
    output wire [31:0] dbg_mepc_o, \
    output wire [31:0] dbg_mtval_o, \
    output wire [31:0] dbg_mtvec_o, \
    output wire [31:0] dbg_mie_o, \
    output wire [31:0] dbg_mip_o,

`define VGA_DBG_Core_Assignments \
    assign dbg_pc = pc; \
    assign dbg_inst = inst; \
    assign dbg_rs1 = rs1; \
    assign dbg_rs1_val = rs1_val; \
    assign dbg_rs2 = rs2; \
    assign dbg_rs2_val = rs2_val; \
    assign dbg_rd = rd; \
    assign dbg_reg_i_data = reg_i_data; \
    assign dbg_reg_wen = reg_wen; \
    assign dbg_is_imm = is_imm; \
    assign dbg_is_auipc = is_auipc; \
    assign dbg_is_lui = is_lui; \
    assign dbg_imm = imm; \
    assign dbg_a_val = a_val; \
    assign dbg_b_val = b_val; \
    assign dbg_alu_ctrl = alu_ctrl; \
    assign dbg_cmp_ctrl = cmp_ctrl; \
    assign dbg_alu_res = alu_res; \
    assign dbg_cmp_res = cmp_res; \
    assign dbg_is_branch = is_branch; \
    assign dbg_is_jal = is_jal; \
    assign dbg_is_jalr = is_jalr; \
    assign dbg_do_branch = do_branch; \
    assign dbg_pc_branch = pc_branch; \
    assign dbg_mem_wen = dmem_wen; \
    assign dbg_mem_ren = dmem_ren; \
    assign dbg_dmem_o_data = dmem_o_data; \
    assign dbg_dmem_i_data = dmem_i_data; \
    assign dbg_dmem_addr = dmem_addr; \
    assign dbg_csr_wen = csr_wen; \
    assign dbg_csr_ind = csr_ind; \
    assign dbg_csr_ctrl = csr_ctrl; \
    assign dbg_csr_r_data = csr_r_data;

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
    wire [31:0] dbg_dmem_addr; \
    wire dbg_csr_wen; \
    wire [11:0] dbg_csr_ind; \
    wire [1:0] dbg_csr_ctrl; \
    wire [31:0] dbg_csr_r_data;

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
    .dbg_csr_wen(dbg_csr_wen), \
    .dbg_csr_ind(dbg_csr_ind), \
    .dbg_csr_ctrl(dbg_csr_ctrl), \
    .dbg_csr_r_data(dbg_csr_r_data), \
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
    .dbg_t6(dbg_t6), \
    .dbg_mstatus_o(dbg_mstatus_o), \
    .dbg_mcause_o(dbg_mcause_o), \
    .dbg_mepc_o(dbg_mepc_o), \
    .dbg_mtval_o(dbg_mtval_o), \
    .dbg_mtvec_o(dbg_mtvec_o), \
    .dbg_mie_o(dbg_mie_o), \
    .dbg_mip_o(dbg_mip_o),

`define VGA_DBG_Csr_Outputs \
    output wire [31:0] dbg_mstatus_o, \
    output wire [31:0] dbg_mcause_o, \
    output wire [31:0] dbg_mepc_o, \
    output wire [31:0] dbg_mtval_o, \
    output wire [31:0] dbg_mtvec_o, \
    output wire [31:0] dbg_mie_o, \
    output wire [31:0] dbg_mip_o,

`define VGA_DBG_Csr_Assignments \
    assign dbg_mstatus_o = mstatus_o; \
    assign dbg_mcause_o = mcause_o; \
    assign dbg_mepc_o = mepc_o; \
    assign dbg_mtval_o = mtval_o; \
    assign dbg_mtvec_o = mtvec_o; \
    assign dbg_mie_o = mie_o; \
    assign dbg_mip_o = mip_o;

`define VGA_DBG_Csr_Declaration \
    wire [31:0] dbg_mstatus_o; \
    wire [31:0] dbg_mcause_o; \
    wire [31:0] dbg_mepc_o; \
    wire [31:0] dbg_mtval_o; \
    wire [31:0] dbg_mtvec_o; \
    wire [31:0] dbg_mie_o; \
    wire [31:0] dbg_mip_o;

`define VGA_DBG_Csr_Arguments \
    .dbg_mstatus_o(dbg_mstatus_o), \
    .dbg_mcause_o(dbg_mcause_o), \
    .dbg_mepc_o(dbg_mepc_o), \
    .dbg_mtval_o(dbg_mtval_o), \
    .dbg_mtvec_o(dbg_mtvec_o), \
    .dbg_mie_o(dbg_mie_o), \
    .dbg_mip_o(dbg_mip_o),

`define VGA_DBG_RegFile_Outputs \
    output wire [31:0] dbg_x0, \
    output wire [31:0] dbg_ra, \
    output wire [31:0] dbg_sp, \
    output wire [31:0] dbg_gp, \
    output wire [31:0] dbg_tp, \
    output wire [31:0] dbg_t0, \
    output wire [31:0] dbg_t1, \
    output wire [31:0] dbg_t2, \
    output wire [31:0] dbg_s0, \
    output wire [31:0] dbg_s1, \
    output wire [31:0] dbg_a0, \
    output wire [31:0] dbg_a1, \
    output wire [31:0] dbg_a2, \
    output wire [31:0] dbg_a3, \
    output wire [31:0] dbg_a4, \
    output wire [31:0] dbg_a5, \
    output wire [31:0] dbg_a6, \
    output wire [31:0] dbg_a7, \
    output wire [31:0] dbg_s2, \
    output wire [31:0] dbg_s3, \
    output wire [31:0] dbg_s4, \
    output wire [31:0] dbg_s5, \
    output wire [31:0] dbg_s6, \
    output wire [31:0] dbg_s7, \
    output wire [31:0] dbg_s8, \
    output wire [31:0] dbg_s9, \
    output wire [31:0] dbg_s10, \
    output wire [31:0] dbg_s11, \
    output wire [31:0] dbg_t3, \
    output wire [31:0] dbg_t4, \
    output wire [31:0] dbg_t5, \
    output wire [31:0] dbg_t6,

`define VGA_DBG_RegFile_Assignments \
    assign dbg_x0 = regs[0]; \
    assign dbg_ra = regs[1]; \
    assign dbg_sp = regs[2]; \
    assign dbg_gp = regs[3]; \
    assign dbg_tp = regs[4]; \
    assign dbg_t0 = regs[5]; \
    assign dbg_t1 = regs[6]; \
    assign dbg_t2 = regs[7]; \
    assign dbg_s0 = regs[8]; \
    assign dbg_s1 = regs[9]; \
    assign dbg_a0 = regs[10]; \
    assign dbg_a1 = regs[11]; \
    assign dbg_a2 = regs[12]; \
    assign dbg_a3 = regs[13]; \
    assign dbg_a4 = regs[14]; \
    assign dbg_a5 = regs[15]; \
    assign dbg_a6 = regs[16]; \
    assign dbg_a7 = regs[17]; \
    assign dbg_s2 = regs[18]; \
    assign dbg_s3 = regs[19]; \
    assign dbg_s4 = regs[20]; \
    assign dbg_s5 = regs[21]; \
    assign dbg_s6 = regs[22]; \
    assign dbg_s7 = regs[23]; \
    assign dbg_s8 = regs[24]; \
    assign dbg_s9 = regs[25]; \
    assign dbg_s10 = regs[26]; \
    assign dbg_s11 = regs[27]; \
    assign dbg_t3 = regs[28]; \
    assign dbg_t4 = regs[29]; \
    assign dbg_t5 = regs[30]; \
    assign dbg_t6 = regs[31];

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

`define VGA_DBG_RegFile_Arguments \
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