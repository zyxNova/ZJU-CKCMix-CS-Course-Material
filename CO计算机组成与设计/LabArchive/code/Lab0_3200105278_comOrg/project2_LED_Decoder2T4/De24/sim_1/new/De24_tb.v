`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/24 17:05:13
// Design Name: 
// Module Name: De24_tb
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


module De24_tb;
    reg [1:0]i;
    wire [3:0]o;
    De24 decoder(.i0(i[0]),.i1(i[1]),.o0(o[0]),.o1(o[1]),.o2(o[2]),.o3(o[3]));
    initial begin
    i = 0;
    #100;
    i = 1;
    #100;
    i = 2;
    #100;
    i = 3;
    #100;
    end
endmodule
