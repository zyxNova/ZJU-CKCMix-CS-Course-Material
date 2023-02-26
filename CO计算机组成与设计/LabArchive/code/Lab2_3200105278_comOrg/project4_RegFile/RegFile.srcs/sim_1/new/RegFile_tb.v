`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/10 22:44:13
// Design Name: 
// Module Name: RegFile_tb
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


module RegFile_tb;
reg clk;
reg rst;
reg wen; // дʹ��
reg[4:0] rs1; // Դ�Ĵ���1�ı��
reg[4:0] rs2; // Դ�Ĵ���2�ı��
reg[4:0] rd; // Ŀ�ļĴ����ı��
reg[31:0] i_data; // д�������
wire[31:0] rs1_val; // Դ�Ĵ���1���������
wire[31:0] rs2_val; // Դ�Ĵ���2���������

RegFile test_RF(
 .clk(clk), .rst(rst),
 .wen(wen), // дʹ��
 .rs1(rs1), // Դ�Ĵ���1�ı��
 .rs2(rs2), // Դ�Ĵ���2�ı��
 .rd(rd), // Ŀ�ļĴ����ı��
 .i_data(i_data), // д�������
 .rs1_val(rs1_val), // Դ�Ĵ���1���������
 .rs2_val(rs2_val) // Դ�Ĵ���2���������
    );
    
reg [31:0]A;
reg [31:0]B;

integer i;
always @ * // 50ns�ı�?�ε�ƽ��ʱ��
    for(i=0; i<5; i=i+1) begin
    #25;
    clk <= ~clk;
end
 
initial begin
    A = 32'd52;
    B = 32'd78;
    clk = 1;
    rd = 0;
    i_data = A;
    rs1 = 0;
    rs2 = 1;
    wen = 1;
    #50;
    wen = 0;
    #50;
    rd = 1;
    i_data = B;
    wen = 1;
    #50;
    wen = 0;
    #50;
    rst = 1;
    #50;
    rst = 0;
    #50;
    rd = 3;
    i_data = A;
    rs1 = 1;
    rs2 = 2;
    wen = 1;
    #50;
    wen = 0;
    rs1 = 3;
    rs2 = 3;
    #50;
end

endmodule
