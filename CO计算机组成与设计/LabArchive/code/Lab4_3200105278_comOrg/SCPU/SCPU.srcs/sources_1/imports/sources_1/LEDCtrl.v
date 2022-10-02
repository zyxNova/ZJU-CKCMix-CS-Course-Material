`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/25 14:17:20
// Design Name: 
// Module Name: LEDCtrl
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
module LEDCtrl(
    input clk,
    input rst,
    input wen,
    input [31:0] i_data,
    output [31:0] o_data,
    output [7:0] o_led_ctrl
    );
    reg [31:0] data;
    always @(posedge clk or posedge rst) begin
        if (rst) data <= 32'h000000FF;
        else if (wen) data <= i_data; // lack of else 
    end
    assign o_data=data;
    assign o_led_ctrl=data[7:0];
    // initial begin data = 32'h000000FF; end
endmodule
