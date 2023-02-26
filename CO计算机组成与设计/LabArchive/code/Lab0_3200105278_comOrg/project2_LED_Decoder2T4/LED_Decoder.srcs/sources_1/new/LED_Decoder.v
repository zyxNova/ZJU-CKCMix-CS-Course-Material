`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/26 15:55:31
// Design Name: 
// Module Name: LED_Decoder
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


module LED_Decoder(
    input [1:0]sw,
    output [3:0]LED
    );
    De24_0 L_Ctrl (
  .i0(sw[0]),  // input wire i0
  .i1(sw[1]),  // input wire i1
  .o0(LED[0]),  // output wire o0
  .o1(LED[1]),  // output wire o1
  .o2(LED[2]),  // output wire o2
  .o3(LED[3])  // output wire o3
);
endmodule
