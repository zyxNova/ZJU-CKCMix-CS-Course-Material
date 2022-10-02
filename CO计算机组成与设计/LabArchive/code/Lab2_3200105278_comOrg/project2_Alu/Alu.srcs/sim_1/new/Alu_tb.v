`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/10 21:40:07
// Design Name: 
// Module Name: Alu_tb
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
module Alu_tb;
    reg [31:0] a_val;
    reg [31:0] b_val;
    reg [3:0] ctrl;
    wire [31:0] result;
    
Alu testALU (
 .a_val(a_val), // a操作数
 .b_val(b_val), // b操作数
 .ctrl(ctrl), // ALU的Control信号
 .result(result) // ALU运算的结果
);
initial begin
    a_val = 32'hff0000ff;
    b_val = 32'd5;
    for (ctrl = 0; ctrl < 10; ctrl = ctrl + 1) begin
        #100;
    end
end
endmodule
