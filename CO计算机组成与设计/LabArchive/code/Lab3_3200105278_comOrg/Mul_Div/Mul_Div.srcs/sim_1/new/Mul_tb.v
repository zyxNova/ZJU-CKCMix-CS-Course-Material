`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/17 21:10:50
// Design Name: 
// Module Name: Mul_tb
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


module tb();
    reg clk;
    reg rst;
    reg[15:0] multiplicand;
    reg[15:0] multiplier;
    reg start;
    wire[31:0] product;
    wire finish;
    initial begin
    clk = 0;
    rst = 1;
    multiplicand = 0;
    multiplier   = 0;
    start        = 0;
    #100
    rst = 0;
    start = 1;
    multiplicand = 16'd2;
    multiplier   = 16'd3;
    #350
    start = 0;
    #350
    start = 1;
    multiplicand = -16'd10;
    multiplier   = 16'd8;
    #350
    start = 0;
    #350
    start = 1;
    multiplicand = 16'd9;
    multiplier   = -16'd9;
    #350
    start = 0;
    #350
    start = 1;
    multiplicand = -16'd50;
    multiplier   = -16'd6;
    #350
    start = 0;
    #350
    start = 1;
    multiplicand = 16'd0;
    multiplier   = 16'd60;
    #350
    start = 0;
    #350
    start = 1;
    multiplicand = 16'd9;
    multiplier   = 16'd0;
    #350
    start = 0;
    #350
    start = 1;
    multiplicand = 16'd0;
    multiplier   = 16'd0;
    #350
    start = 0;
    #350
    start = 1;
    multiplicand = 16'hFF00;
    multiplier   = 16'h8001;
    #350
    start = 0;
    #350
    start = 1;
    multiplicand = 16'h7FFF;
    multiplier   = 16'h7FFF;
    #350
    start = 0;
    #4000 $finish();
    end
    
    always #5 clk = ~clk;
    
    mul32 mul32_u(
    clk,rst,multiplicand,multiplier,start,product,finish
    );
endmodule
