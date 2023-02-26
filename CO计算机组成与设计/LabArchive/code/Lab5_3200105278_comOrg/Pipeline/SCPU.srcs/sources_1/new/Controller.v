`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/11 11:08:17
// Design Name: 
// Module Name: Controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`include "Defines.vh"
module Controller(
    input [31:0] inst,
    output reg [3:0] alu_ctrl,
    output reg_wen,
    output is_imm,
    output mem_wen,
    output mem_ren,
    output reg [2:0] immType,
    output is_branch,
    output is_jal,
    output is_lui,
    output is_jalr,
    output is_auipc,
    output reg [2:0] cmp_ctrl,
    output is_aluRR,
    output is_aluRI
    );
    wire [4:0] opcode;
    wire [2:0] funct3;
    // wire is_aluRR;
    // wire is_aluRI;
    wire is_load;
    wire is_store;

    assign opcode = inst[6:2];
    assign is_aluRR = (opcode == `OPCODE_ALURR) ? 1 : 0;
    assign is_aluRI = (opcode == `OPCODE_ALURI) ? 1 : 0;
    assign is_load = (opcode == `OPCODE_LOAD) ? 1 : 0;
    assign is_store = (opcode == `OPCODE_STORE) ? 1 : 0;
    assign is_branch = (opcode == `OPCODE_BRANCH) ? 1 : 0;
    assign is_jal = (opcode == `OPCODE_JAL) ? 1 : 0;
    assign is_jalr = (opcode == `OPCODE_JALR) ? 1 : 0;
    assign is_lui = (opcode == `OPCODE_LUI) ? 1 : 0;
    assign is_auipc = (opcode == `OPCODE_AUIPC) ? 1 : 0;

    assign funct3 = inst[14:12];
    always @* begin
        if (is_aluRR || is_aluRI) begin
            case (funct3)
                `OP_ADD: alu_ctrl = (is_aluRR & inst[30]) ? `ALU_SUB : `ALU_ADD;
                `OP_SLL: alu_ctrl = `ALU_SLL;
                `OP_SLT: alu_ctrl = `ALU_SLT;
                `OP_SLTU: alu_ctrl = `ALU_SLTU;
                `OP_XOR: alu_ctrl = `ALU_XOR;
                `OP_SRL: alu_ctrl = inst[30] ? `ALU_SRA : `ALU_SRL;
                `OP_OR: alu_ctrl = `ALU_OR;
                `OP_AND: alu_ctrl = `ALU_AND;
            endcase
        end
        else alu_ctrl = `ALU_ADD; //convenient for other offset operations

        if (is_aluRI) begin
            if (alu_ctrl == `ALU_SLTU) immType = `IMM12_I_U;
            else immType = `IMM12_I_S;
        end
        else if (is_load | is_jalr) immType = `IMM12_I_S;
        else if (is_store) immType = `IMM12_S;
        else if (is_branch) immType = `IMM12_SB;
        else if (is_jal) immType = `IMM20_UJ;
        else if (is_lui | is_auipc) immType = `IMM20_U;

        case (funct3) 
            `BRANCH_EQ: cmp_ctrl = `CMP_EQ;
            `BRANCH_NE: cmp_ctrl = `CMP_NE;
            `BRANCH_LT: cmp_ctrl = `CMP_LT;
            `BRANCH_GE: cmp_ctrl = `CMP_GE;
            `BRANCH_LTU: cmp_ctrl = `CMP_LTU;
            `BRANCH_GEU: cmp_ctrl = `CMP_GEU;
        endcase
    end

    assign reg_wen = is_aluRR | is_aluRI | is_load | is_jal | is_lui | is_jalr | is_auipc;
    assign is_imm = is_aluRI | is_load | is_store | is_jalr;
    assign mem_ren = is_load;
    assign mem_wen = is_store;
endmodule
