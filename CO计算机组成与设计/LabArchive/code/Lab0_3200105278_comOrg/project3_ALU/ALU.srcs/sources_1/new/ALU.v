`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/02 12:48:05
// Design Name: 
// Module Name: ALU
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

//My Addc can implement subtraction, thus including sext1_32 and xor.
//Srl32 is different from Lab1.2 PPT.
module ALU(
    input [31:0]A,
    input [31:0]B,
    input [2:0]ALU_operation,
    output [31:0]res,
    output zero
    );
    wire [31:0]I0;
    wire [31:0]I1;
    wire [31:0]I2;
    wire [31:0]I3;
    wire [31:0]I4;
    wire [31:0]I5;
    wire [31:0]I6;
    wire [31:0]I7;
    wire C0;
    wire [31:0]SEXT_C0;
    wire [31:0]temp_B;
    wire [32:0]S;
    
    AND32_0 and32 (
  .A(A),      // input wire [31 : 0] A
  .B(B),      // input wire [31 : 0] B
  .res(I0)  // output wire [31 : 0] res
);
    OR32_0 or32 (
  .A(A),      // input wire [31 : 0] A
  .B(B),      // input wire [31 : 0] B
  .res(I1)  // output wire [31 : 0] res
);
    XOR32_0 xor32 (
  .A(A),      // input wire [31 : 0] A
  .B(B),      // input wire [31 : 0] B
  .res(I3)  // output wire [31 : 0] res
  );
    NOR32_0 nor32 (
  .A(A),      // input wire [31 : 0] A
  .B(B),      // input wire [31 : 0] B
  .res(I4)  // output wire [31 : 0] res
);
    SRL32_0 srl32 (
  .A(A),      // input wire [31 : 0] A
  .B(B),      // input wire [31 : 0] B
  .res(I5)  // output wire [31 : 0] res
);
    assign C0 = ALU_operation[2];
    SEXT1_32_0 extC0 (
  .S(C0),    // input wire S
  .So(SEXT_C0)  // output wire [31 : 0] So
);

    XOR32_0 getB (
  .A(SEXT_C0),      // input wire [31 : 0] A
  .B(B),      // input wire [31 : 0] B
  .res(temp_B)  // output wire [31 : 0] res
);
  
  
  ADC32_0 adc32 (
  .A(A),    // input wire [31 : 0] A
  .B(temp_B),    // input wire [31 : 0] B
  .C0(C0),  // input wire C0
  .S(S)    // output wire [32 : 0] S
);

    assign I2 = S[31:0];
    assign I6 = S[31:0];
    assign I7 = {30'b0, S[32]};
    
    M8132_0 M8132 (
  .I0(I0),    // input wire [31 : 0] I0
  .I1(I1),    // input wire [31 : 0] I1
  .I2(I2),    // input wire [31 : 0] I2
  .I3(I3),    // input wire [31 : 0] I3
  .I4(I4),    // input wire [31 : 0] I4
  .I5(I5),    // input wire [31 : 0] I5
  .I6(I6),    // input wire [31 : 0] I6
  .I7(I7),    // input wire [31 : 0] I7
  .sel(ALU_operation),  // input wire [2 : 0] sel
  .o(res)      // output wire [31 : 0] o
);

    OR_BIT_32_0 get_zero (
  .A(res),  // input wire [31 : 0] A
  .o(zero)  // output wire o
);


endmodule
