`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/26 20:46:44
// Design Name: 
// Module Name: SRL32_TB
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


module SRL32_TB;
reg [31:0]A;
reg [31:0]B;
wire [31:0]res;
SRL32 m0(.A(A), .B(B), .res(res));

initial begin
    A = 32'hf0f0f0f0;
    B = 32'h00000001;
    end
endmodule
