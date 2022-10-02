`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/25 14:08:51
// Design Name: 
// Module Name: Mem
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


module Mem(
//for IMem
  input [31:0]i_addr,
  output [31:0]i_data,
 //for DMem
  input clk,
  input d_wen,
  input d_ren,
  input [31:0]d_addr,
  input [31:0]d_i_data,
  output [31:0]d_o_data
    );
    IMem i_mem(
        .addr(i_addr),
        .data(i_data)
    );

    DMem d_mem(
        .clk(clk),
        .wen(d_wen),
        .ren(d_ren),
        .addr(d_addr),
        .i_data(d_i_data),
        .o_data(d_o_data)
    );
endmodule
