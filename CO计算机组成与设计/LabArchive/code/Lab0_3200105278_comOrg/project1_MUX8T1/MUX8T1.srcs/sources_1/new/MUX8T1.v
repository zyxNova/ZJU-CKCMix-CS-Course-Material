`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/24 14:16:31
// Design Name: 
// Module Name: MUX8T1
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


module MUX8T1(
    input [0:7]i,
    input [0:2]s,
    output o
    );
    reg o;
    always @(s or i)
        begin: START
            case (s)
                0: o = i[0];
                1: o = i[1];
                2: o = i[2];
                3: o = i[3];
                4: o = i[4];
                5: o = i[5];
                6: o = i[6];
                7: o = i[7];
            endcase
        end
endmodule
