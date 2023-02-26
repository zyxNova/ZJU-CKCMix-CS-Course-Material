`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/02 14:19:04
// Design Name: 
// Module Name: SEXT1_32_tb
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


module SEXT1_32_tb;
reg S;
wire [31:0]So;

SEXT1_32 m0(.S(S), .So(So));

initial begin
    S = 1;
    end
endmodule
