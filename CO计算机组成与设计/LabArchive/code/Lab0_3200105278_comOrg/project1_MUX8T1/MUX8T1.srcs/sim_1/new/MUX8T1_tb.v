`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/24 14:30:11
// Design Name: 
// Module Name: MUX8T1_tb
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


module MUX8T1_tb;
    reg [0:7] i;
    reg [0:3] s;
    wire o;
    
    MUX8T1 MUX8T1_1(.i(i), .s(s), .o(o));
    
    initial begin 
       i = 8'b10101010;
       for (s = 0; s < 8; s = s+1)
            #100;
    end

endmodule
