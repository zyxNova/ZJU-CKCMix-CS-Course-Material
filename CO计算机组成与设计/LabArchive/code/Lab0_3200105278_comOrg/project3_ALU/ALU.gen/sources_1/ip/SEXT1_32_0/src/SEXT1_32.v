`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/26 19:56:54
// Design Name: 
// Module Name: SEXT1_32
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


module SEXT1_32(
    input S,
    output [31:0]So
    );
    /*
    for (i=0;i<32;i=i+1) begin
        assign So[i] = S;
        end
        */
    assign So = {32{S}};
endmodule
