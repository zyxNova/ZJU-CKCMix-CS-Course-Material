`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/02 13:43:36
// Design Name: 
// Module Name: ALU_tb
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


module ALU_tb;
reg [31:0]A;
reg [31:0]B;
reg [2:0]ALU_operation;
wire [31:0]res;
wire zero;

ALU m0 (.A(A),
        .B(B),
        .ALU_operation(ALU_operation),
        .res(res),
        .zero(zero)
        );

initial begin
    A = 32'hA5A5A5A5;
    B = 32'h5A5A5A5A;
    ALU_operation = 3'b111;
    #100;
    ALU_operation = 3'b110;
    #100;
    ALU_operation = 3'b101;
    #100;
    ALU_operation = 3'b100;
    #100;
    ALU_operation = 3'b011;
    #100;
    ALU_operation = 3'b010;
    #100;
    ALU_operation = 3'b001;
    #100;
    ALU_operation = 3'b000;
    #100;
    A = 32'h01234567;
    B = 32'h76543210;
    ALU_operation = 3'b111;
    end
endmodule
