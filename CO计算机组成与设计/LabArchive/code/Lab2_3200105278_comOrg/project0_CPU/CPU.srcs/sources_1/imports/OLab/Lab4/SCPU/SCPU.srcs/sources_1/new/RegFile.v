`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/17 22:01:32
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
`include "Defines.vh"

module RegFile(
`VGA_DBG_RegFile_Outputs // Debug�źţ������̸���
 input clk, rst,
 input wen, // дʹ��
 input [4:0] rs1, // Դ�Ĵ���1�ı��
 input [4:0] rs2, // Դ�Ĵ���2�ı��
 input [4:0] rd, // Ŀ�ļĴ����ı��
 input [31:0] i_data, // д�������
 output [31:0] rs1_val, // Դ�Ĵ���1���������
 output [31:0] rs2_val // Դ�Ĵ���2���������
    );
    reg [31:0] register [0:31];//���ؿ���register[0]����Ϊ��ֵ��Ϊ0
    `VGA_DBG_RegFile_Assignments
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