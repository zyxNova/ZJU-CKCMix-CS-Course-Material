`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/10 22:32:07
// Design Name: 
// Module Name: RegFile
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


module RegFile(
//`VGA_DBG_RegFile_Outputs // Debug信号，由助教给出
 input clk, rst,
 input wen, // 写使能
 input [4:0] rs1, // 源寄存器1的编号
 input [4:0] rs2, // 源寄存器2的编号
 input [4:0] rd, // 目的寄存器的编号
 input [31:0] i_data, // 写入的数据
 output [31:0] rs1_val, // 源寄存器1的输出数据
 output [31:0] rs2_val // 源寄存器2输出的数据
    );
    reg [31:0] register [1:31];//不必考虑register[0]，因为其值恒为0
    integer i;
    assign rs1_val = (rs1 == 0) ? 0 : register[rs1];
    assign rs2_val = (rs2 == 0) ? 0 : register[rs2];
    always @(posedge clk or posedge rst) begin
        if (rst == 1) 
            for (i = 1; i < 32; i = i+1) 
                register[i] <= 0;
        else if ((wen == 1) && (rd != 0))
                register[rd] <= i_data;
    end
endmodule
