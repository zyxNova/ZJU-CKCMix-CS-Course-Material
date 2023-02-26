`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/10 14:30:27
// Design Name: 
// Module Name: Alu
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
`define ALU_ADD  4'd0
`define ALU_SUB  4'd1
`define ALU_SLL  4'd2
`define ALU_SLT  4'd3
`define ALU_SLTU 4'd4
`define ALU_XOR  4'd5
`define ALU_SRL  4'd6
`define ALU_SRA  4'd7
`define ALU_OR   4'd8
`define ALU_AND  4'd9

module Alu(
 input [31:0] a_val, // a操作数
 input [31:0] b_val, // b操作数
 input [3:0] ctrl, // ALU的Control信号
 output reg [31:0] result // ALU运算的结果
);
    wire [31:0]add_res;
    wire [31:0]sub_res;
    wire [31:0]sll_res;
    wire [31:0]slt_res;
    wire [31:0]sltu_res;
    wire [31:0]xor_res;
    wire [31:0]srl_res;
    wire [31:0]sra_res;
    wire [31:0]or_res;
    wire [31:0]and_res;
    
    assign add_res = a_val + b_val;
    assign sub_res = a_val - b_val;
    assign sll_res = a_val << b_val[4:0];
    assign slt_res = (sub_res[31] == 1) ? 1 : 0;
    wire [32:0]temp_add;
    assign temp_add = a_val - b_val + 33'h100000000;
    assign sltu_res = (temp_add[32] == 0) ? 1 : 0;//注意这个判断方法
    assign xor_res = a_val ^ b_val;
    assign srl_res = a_val >> b_val[4:0];
    assign sra_res = $signed(a_val) >>> b_val[4:0];//本来想用SEXT位扩展，语法错误
    assign or_res = a_val | b_val;//应该是按位或|，而不是逻辑或||
    assign and_res = a_val & b_val;//应该是按位与&,而不是逻辑与&&
    
    always @* begin
        case (ctrl)
            `ALU_ADD: result = add_res;
            `ALU_SUB: result = sub_res;
            `ALU_SLL: result = sll_res;
            `ALU_SLT: result = slt_res;
            `ALU_SLTU: result = sltu_res;
            `ALU_XOR: result = xor_res;
            `ALU_SRL: result = srl_res;
            `ALU_SRA: result = sra_res;
            `ALU_OR: result = or_res;
            `ALU_AND: result = and_res;
        endcase
    end
endmodule
