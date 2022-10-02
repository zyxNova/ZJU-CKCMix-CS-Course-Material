`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/26 20:02:07
// Design Name: 
// Module Name: ADC32_TB
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


module ADC32_TB;
    reg [31:0]A;
    reg [31:0]B;
    reg C0;
    wire [32:0]S;
    ADC32 m0(.A(A), .B(B), 
            .C0(C0), .S(S));
    initial begin
        A = 32'hffffffff;
        B = 32'h00000001;
        C0 = 1;
        #100;
        C0 = 0;
        #100;
        A = 0;
        B = 1;
        #100;
    end
endmodule
