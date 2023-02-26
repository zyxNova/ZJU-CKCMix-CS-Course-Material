/*
 * Description:
 *   Some macro definations, contains
 *   1. opcode used in decoder
 *   2. some control signals outputed by decoder
 *   3. CSR related
 *   4. some other definations
 *   This file is included by almost all other files about CPU
 */
`define DEBUG

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

// generated code

`define VGA_DBG_VgaDebugger_Arguments \
    .pc(dbg_pc), \
    .inst(dbg_inst), \
    .IfId_pc(dbg_IfId_pc), \
    .IfId_inst(dbg_IfId_inst), \
    .IfId_valid(dbg_IfId_valid), \
    .IdEx_pc(dbg_IdEx_pc), \
    .IdEx_inst(dbg_IdEx_inst), \
    .IdEx_valid(dbg_IdEx_valid), \
    .IdEx_rd(dbg_IdEx_rd), \
    .IdEx_rs1(dbg_IdEx_rs1), \
    .IdEx_rs2(dbg_IdEx_rs2), \
    .IdEx_rs1_val(dbg_IdEx_rs1_val), \
    .IdEx_rs2_val(dbg_IdEx_rs2_val), \
    .IdEx_reg_wen(dbg_IdEx_reg_wen), \
    .IdEx_is_imm(dbg_IdEx_is_imm), \
    .IdEx_imm(dbg_IdEx_imm), \
    .IdEx_mem_wen(dbg_IdEx_mem_wen), \
    .IdEx_mem_ren(dbg_IdEx_mem_ren), \
    .IdEx_is_branch(dbg_IdEx_is_branch), \
    .IdEx_is_jal(dbg_IdEx_is_jal), \
    .IdEx_is_jalr(dbg_IdEx_is_jalr), \
    .IdEx_is_auipc(dbg_IdEx_is_auipc), \
    .IdEx_is_lui(dbg_IdEx_is_lui), \
    .IdEx_alu_ctrl(dbg_IdEx_alu_ctrl), \
    .IdEx_cmp_ctrl(dbg_IdEx_cmp_ctrl), \
    .ExMa_pc(dbg_ExMa_pc), \
    .ExMa_inst(dbg_ExMa_inst), \
    .ExMa_valid(dbg_ExMa_valid), \
    .ExMa_rd(dbg_ExMa_rd), \
    .ExMa_reg_wen(dbg_ExMa_reg_wen), \
    .ExMa_mem_w_data(dbg_ExMa_mem_w_data), \
    .ExMa_alu_res(dbg_ExMa_alu_res), \
    .ExMa_mem_wen(dbg_ExMa_mem_wen), \
    .ExMa_mem_ren(dbg_ExMa_mem_ren), \
    .ExMa_is_jal(dbg_ExMa_is_jal), \
    .ExMa_is_jalr(dbg_ExMa_is_jalr), \
    .MaWb_pc(dbg_MaWb_pc), \
    .MaWb_inst(dbg_MaWb_inst), \
    .MaWb_valid(dbg_MaWb_valid), \
    .MaWb_rd(dbg_MaWb_rd), \
    .MaWb_reg_wen(dbg_MaWb_reg_wen), \
    .MaWb_reg_w_data(dbg_MaWb_reg_w_data), \
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


`define VGA_DBG_Core_Outputs \
    output wire [31:0] dbg_pc, \
    output wire [31:0] dbg_inst, \
    output wire [31:0] dbg_IfId_pc, \
    output wire [31:0] dbg_IfId_inst, \
    output wire dbg_IfId_valid, \
    output wire [31:0] dbg_IdEx_pc, \
    output wire [31:0] dbg_IdEx_inst, \
    output wire dbg_IdEx_valid, \
    output wire [4:0] dbg_IdEx_rd, \
    output wire [4:0] dbg_IdEx_rs1, \
    output wire [4:0] dbg_IdEx_rs2, \
    output wire [31:0] dbg_IdEx_rs1_val, \
    output wire [31:0] dbg_IdEx_rs2_val, \
    output wire dbg_IdEx_reg_wen, \
    output wire dbg_IdEx_is_imm, \
    output wire [31:0] dbg_IdEx_imm, \
    output wire dbg_IdEx_mem_wen, \
    output wire dbg_IdEx_mem_ren, \
    output wire dbg_IdEx_is_branch, \
    output wire dbg_IdEx_is_jal, \
    output wire dbg_IdEx_is_jalr, \
    output wire dbg_IdEx_is_auipc, \
    output wire dbg_IdEx_is_lui, \
    output wire [3:0] dbg_IdEx_alu_ctrl, \
    output wire [2:0] dbg_IdEx_cmp_ctrl, \
    output wire [31:0] dbg_ExMa_pc, \
    output wire [31:0] dbg_ExMa_inst, \
    output wire dbg_ExMa_valid, \
    output wire [4:0] dbg_ExMa_rd, \
    output wire dbg_ExMa_reg_wen, \
    output wire [31:0] dbg_ExMa_mem_w_data, \
    output wire [31:0] dbg_ExMa_alu_res, \
    output wire dbg_ExMa_mem_wen, \
    output wire dbg_ExMa_mem_ren, \
    output wire dbg_ExMa_is_jal, \
    output wire dbg_ExMa_is_jalr, \
    output wire [31:0] dbg_MaWb_pc, \
    output wire [31:0] dbg_MaWb_inst, \
    output wire dbg_MaWb_valid, \
    output wire [4:0] dbg_MaWb_rd, \
    output wire dbg_MaWb_reg_wen, \
    output wire [31:0] dbg_MaWb_reg_w_data, \
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


`define VGA_DBG_Core_Assignments \
    assign dbg_pc = pc; \
    assign dbg_inst = inst; \
    assign dbg_IfId_pc = IfId_pc; \
    assign dbg_IfId_inst = IfId_inst; \
    assign dbg_IfId_valid = IfId_valid; \
    assign dbg_IdEx_pc = IdEx_pc; \
    assign dbg_IdEx_inst = IdEx_inst; \
    assign dbg_IdEx_valid = IdEx_valid; \
    assign dbg_IdEx_rd = IdEx_rd; \
    assign dbg_IdEx_rs1 = IdEx_rs1; \
    assign dbg_IdEx_rs2 = IdEx_rs2; \
    assign dbg_IdEx_rs1_val = IdEx_rs1_val; \
    assign dbg_IdEx_rs2_val = IdEx_rs2_val; \
    assign dbg_IdEx_reg_wen = IdEx_reg_wen; \
    assign dbg_IdEx_is_imm = IdEx_is_imm; \
    assign dbg_IdEx_imm = IdEx_imm; \
    assign dbg_IdEx_mem_wen = IdEx_mem_wen; \
    assign dbg_IdEx_mem_ren = IdEx_mem_ren; \
    assign dbg_IdEx_is_branch = IdEx_is_branch; \
    assign dbg_IdEx_is_jal = IdEx_is_jal; \
    assign dbg_IdEx_is_jalr = IdEx_is_jalr; \
    assign dbg_IdEx_is_auipc = IdEx_is_auipc; \
    assign dbg_IdEx_is_lui = IdEx_is_lui; \
    assign dbg_IdEx_alu_ctrl = IdEx_alu_ctrl; \
    assign dbg_IdEx_cmp_ctrl = IdEx_cmp_ctrl; \
    assign dbg_ExMa_pc = ExMa_pc; \
    assign dbg_ExMa_inst = ExMa_inst; \
    assign dbg_ExMa_valid = ExMa_valid; \
    assign dbg_ExMa_rd = ExMa_rd; \
    assign dbg_ExMa_reg_wen = ExMa_reg_wen; \
    assign dbg_ExMa_mem_w_data = ExMa_mem_w_data; \
    assign dbg_ExMa_alu_res = ExMa_alu_res; \
    assign dbg_ExMa_mem_wen = ExMa_mem_wen; \
    assign dbg_ExMa_mem_ren = ExMa_mem_ren; \
    assign dbg_ExMa_is_jal = ExMa_is_jal; \
    assign dbg_ExMa_is_jalr = ExMa_is_jalr; \
    assign dbg_MaWb_pc = MaWb_pc; \
    assign dbg_MaWb_inst = MaWb_inst; \
    assign dbg_MaWb_valid = MaWb_valid; \
    assign dbg_MaWb_rd = MaWb_rd; \
    assign dbg_MaWb_reg_wen = MaWb_reg_wen; \
    assign dbg_MaWb_reg_w_data = MaWb_reg_w_data;

`define VGA_DBG_Core_Declaration \
    wire [31:0] dbg_pc; \
    wire [31:0] dbg_inst; \
    wire [31:0] dbg_IfId_pc; \
    wire [31:0] dbg_IfId_inst; \
    wire dbg_IfId_valid; \
    wire [31:0] dbg_IdEx_pc; \
    wire [31:0] dbg_IdEx_inst; \
    wire dbg_IdEx_valid; \
    wire [4:0] dbg_IdEx_rd; \
    wire [4:0] dbg_IdEx_rs1; \
    wire [4:0] dbg_IdEx_rs2; \
    wire [31:0] dbg_IdEx_rs1_val; \
    wire [31:0] dbg_IdEx_rs2_val; \
    wire dbg_IdEx_reg_wen; \
    wire dbg_IdEx_is_imm; \
    wire [31:0] dbg_IdEx_imm; \
    wire dbg_IdEx_mem_wen; \
    wire dbg_IdEx_mem_ren; \
    wire dbg_IdEx_is_branch; \
    wire dbg_IdEx_is_jal; \
    wire dbg_IdEx_is_jalr; \
    wire dbg_IdEx_is_auipc; \
    wire dbg_IdEx_is_lui; \
    wire [3:0] dbg_IdEx_alu_ctrl; \
    wire [2:0] dbg_IdEx_cmp_ctrl; \
    wire [31:0] dbg_ExMa_pc; \
    wire [31:0] dbg_ExMa_inst; \
    wire dbg_ExMa_valid; \
    wire [4:0] dbg_ExMa_rd; \
    wire dbg_ExMa_reg_wen; \
    wire [31:0] dbg_ExMa_mem_w_data; \
    wire [31:0] dbg_ExMa_alu_res; \
    wire dbg_ExMa_mem_wen; \
    wire dbg_ExMa_mem_ren; \
    wire dbg_ExMa_is_jal; \
    wire dbg_ExMa_is_jalr; \
    wire [31:0] dbg_MaWb_pc; \
    wire [31:0] dbg_MaWb_inst; \
    wire dbg_MaWb_valid; \
    wire [4:0] dbg_MaWb_rd; \
    wire dbg_MaWb_reg_wen; \
    wire [31:0] dbg_MaWb_reg_w_data;

`define VGA_DBG_Core_Arguments \
    .dbg_pc(dbg_pc), \
    .dbg_inst(dbg_inst), \
    .dbg_IfId_pc(dbg_IfId_pc), \
    .dbg_IfId_inst(dbg_IfId_inst), \
    .dbg_IfId_valid(dbg_IfId_valid), \
    .dbg_IdEx_pc(dbg_IdEx_pc), \
    .dbg_IdEx_inst(dbg_IdEx_inst), \
    .dbg_IdEx_valid(dbg_IdEx_valid), \
    .dbg_IdEx_rd(dbg_IdEx_rd), \
    .dbg_IdEx_rs1(dbg_IdEx_rs1), \
    .dbg_IdEx_rs2(dbg_IdEx_rs2), \
    .dbg_IdEx_rs1_val(dbg_IdEx_rs1_val), \
    .dbg_IdEx_rs2_val(dbg_IdEx_rs2_val), \
    .dbg_IdEx_reg_wen(dbg_IdEx_reg_wen), \
    .dbg_IdEx_is_imm(dbg_IdEx_is_imm), \
    .dbg_IdEx_imm(dbg_IdEx_imm), \
    .dbg_IdEx_mem_wen(dbg_IdEx_mem_wen), \
    .dbg_IdEx_mem_ren(dbg_IdEx_mem_ren), \
    .dbg_IdEx_is_branch(dbg_IdEx_is_branch), \
    .dbg_IdEx_is_jal(dbg_IdEx_is_jal), \
    .dbg_IdEx_is_jalr(dbg_IdEx_is_jalr), \
    .dbg_IdEx_is_auipc(dbg_IdEx_is_auipc), \
    .dbg_IdEx_is_lui(dbg_IdEx_is_lui), \
    .dbg_IdEx_alu_ctrl(dbg_IdEx_alu_ctrl), \
    .dbg_IdEx_cmp_ctrl(dbg_IdEx_cmp_ctrl), \
    .dbg_ExMa_pc(dbg_ExMa_pc), \
    .dbg_ExMa_inst(dbg_ExMa_inst), \
    .dbg_ExMa_valid(dbg_ExMa_valid), \
    .dbg_ExMa_rd(dbg_ExMa_rd), \
    .dbg_ExMa_reg_wen(dbg_ExMa_reg_wen), \
    .dbg_ExMa_mem_w_data(dbg_ExMa_mem_w_data), \
    .dbg_ExMa_alu_res(dbg_ExMa_alu_res), \
    .dbg_ExMa_mem_wen(dbg_ExMa_mem_wen), \
    .dbg_ExMa_mem_ren(dbg_ExMa_mem_ren), \
    .dbg_ExMa_is_jal(dbg_ExMa_is_jal), \
    .dbg_ExMa_is_jalr(dbg_ExMa_is_jalr), \
    .dbg_MaWb_pc(dbg_MaWb_pc), \
    .dbg_MaWb_inst(dbg_MaWb_inst), \
    .dbg_MaWb_valid(dbg_MaWb_valid), \
    .dbg_MaWb_rd(dbg_MaWb_rd), \
    .dbg_MaWb_reg_wen(dbg_MaWb_reg_wen), \
    .dbg_MaWb_reg_w_data(dbg_MaWb_reg_w_data), \
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