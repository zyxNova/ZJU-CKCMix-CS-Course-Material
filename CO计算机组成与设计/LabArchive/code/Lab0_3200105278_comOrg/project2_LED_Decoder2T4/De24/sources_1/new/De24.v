`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/24 17:00:51
// Design Name: 
// Module Name: De24
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


module De24(
    input i0,i1,
    output o0,o1,o2,o3
    );
    assign o0 = ~i0 & ~i1;
    assign o1 = i0 & ~i1;
    assign o2 = ~i0 & i1;
    assign o3 = i0 & i1;
    
endmodule
