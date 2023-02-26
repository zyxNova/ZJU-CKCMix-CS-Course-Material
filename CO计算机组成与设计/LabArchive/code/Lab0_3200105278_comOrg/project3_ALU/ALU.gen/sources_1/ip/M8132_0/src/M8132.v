`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/26 19:31:02
// Design Name: 
// Module Name: M8132
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


module M8132(
    input [31:0] I0, 
    input [31:0] I1, 
    input [31:0] I2,
    input [31:0] I3,
    input [31:0] I4,
    input [31:0] I5,
    input [31:0] I6,
    input [31:0] I7,
    input [2:0]sel, 
    output reg [31:0] o
    );
    always @(I0 or I1 or I2 or I3 or I4 or I5 or I6 or I7 or sel) begin
        case (sel)
            0: o = I0;
            1: o = I1;
            2: o = I2;
            3: o = I3;
            4: o = I4;
            5: o = I5;
            6: o = I6;
            7: o = I7;
        endcase
    end
endmodule
