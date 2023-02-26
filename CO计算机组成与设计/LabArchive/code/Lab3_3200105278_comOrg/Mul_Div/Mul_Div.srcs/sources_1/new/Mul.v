`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/17 15:09:52
// Design Name: 
// Module Name: Mul
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
module mul32(
  input clk,
  input rst,
  input [15:0] A,
  input [15:0] B,
  input start,
  output reg [31:0] product,
  output reg finish
    );
    wire signMcand;
    wire signMer;
    wire sign;
    assign signMcand = A[15];
    assign signMer = B[15];
    assign sign = signMcand ^ signMer;
    reg [15:0] multiplicand;
    reg [15:0] multiplier;
    integer i;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            product = 0;
            finish = 0;
        end
        else if (start == 0 && finish == 0) begin//计算开始而且计算未完成，少了finish条件循环计算
                multiplicand = signMcand ? ~A+1 : A;
                multiplier = signMer ? ~B+1 : B;//处理负数
                
                product = {0,multiplier};//忘记把高位清0，导致错误
                for (i = 0; i < 16; i = i+1) begin
                    if (product[0]) begin
                        product[31:16] = product[31:16] + multiplicand[15:0];
                    end
                    product = product >> 1;
                end
                product = sign ? ~product+1 : product;
                finish = 1;
        end
        else if (start) begin finish = 0; end
    end    
endmodule