`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/12 20:17:30
// Design Name: 
// Module Name: Comparator_tb
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


module Comparator_tb;
reg [31:0] a_val;
reg [31:0] b_val;
reg [2:0] ctrl;
wire result;

Comparator test_Cmp(
 .a_val(a_val), // 输入值 a_val
 .b_val(b_val), // 输入值 b_bal
 .ctrl(ctrl), // 比较器的控制信号
 .result(result) // 结果（1bit的布尔值）
);

initial begin
    a_val = 32'hf0000032;
    b_val = 32'd78;
    for (ctrl = 0; ctrl < 6; ctrl = ctrl + 1) begin
        #100;
    end
    a_val = 32'd52;
    b_val = 32'd78;
    for (ctrl = 0; ctrl < 6; ctrl = ctrl + 1) begin
        #100;
    end
    a_val = 32'd78;
    b_val = 32'd78;
    for (ctrl = 0; ctrl < 6; ctrl = ctrl + 1) begin
        #100;
    end
end
endmodule
