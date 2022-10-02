`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/17 22:29:00
// Design Name: 
// Module Name: Div_tb
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


module Div_tb();
    reg clk;
    reg rst;
    reg[15:0] dividend;
    reg[15:0] divisor;
    reg start;
    wire[15:0] quotient;
    wire[15:0] remainder;
    wire finish;
    wire divide_zero;
    
    initial begin
    clk = 0;
    rst = 1;
    dividend = 0;
    divisor   = 0;
    start        = 0;
    #100
    rst = 0;
    start = 1;
    dividend = 16'd2;
    divisor   = 16'd3;
    #350
    start = 0;
    #350
    start = 1;
    dividend = -16'd10;
    divisor   = 16'd8;
    #350
    start = 0;
    #350
    start = 1;
    dividend = 16'd9;
    divisor   = -16'd9;
    #350
    start = 0;
    #350
    start = 1;
    dividend = -16'd50;
    divisor   = -16'd6;
    #350
    start = 0;
    #350
    start = 1;
    dividend = 16'd0;
    divisor   = 16'd60;
    #350
    start = 0;
    #350
    start = 1;
    dividend = 16'd9;
    divisor   = 16'd0;
    #350
    start = 0;
    #350
    start = 1;
    dividend = 16'd0;
    divisor   = 16'd0;
    #350
    start = 0;
    #350
    start = 1;
    dividend = 16'hFF00;
    divisor   = 16'h8001;
    #350
    start = 0;
    #350
    start = 1;
    dividend = 16'h7FFF;
    divisor   = 16'h7FF0;
    #350
    start = 0;
    #4000 $finish();
    end
    
    always #5 clk = ~clk;
    
    div32 div32_u(
    clk,rst,start,dividend,divisor,finish,quotient,remainder,divide_zero
    );
endmodule
