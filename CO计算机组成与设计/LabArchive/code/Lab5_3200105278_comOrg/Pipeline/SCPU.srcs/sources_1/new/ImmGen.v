`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/11 14:42:49
// Design Name: 
// Module Name: ImmGen
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

module ImmGen(
    input [31:0] inst,
    input [2:0] immType,
    output reg [31:0] imm
    );
    always @* begin
        case (immType)
            `IMM12_I_S: imm = {{20{inst[31]}}, inst[31:20]};
            `IMM12_I_U: imm = {20'h00000, inst[31:20]};
            `IMM12_S: imm = {{20{inst[31]}}, inst[31:25], inst[11:7]};
            `IMM12_SB: imm = {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0};
            `IMM20_UJ: imm = {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0};
            `IMM20_U: imm = {inst[31:12], 12'b0};
        endcase
    end
endmodule
