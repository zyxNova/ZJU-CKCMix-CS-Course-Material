`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/03 14:42:22
// Design Name: 
// Module Name: MACtrl_tb
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

module MACtrl_tb;
        //facing core
        reg [31:0]i_iaddr;
        wire [31:0]o_idata;
        reg i_dwen;
        reg [31:0]i_daddr;
        reg [31:0]i_d_idata;
        wire [31:0]o_d_odata;
        //facing IMem
        wire [31:0]o_iaddr;
        wire [31:0]i_idata;
        //facing DMem
        wire o_dwen;
        wire [31:0]o_daddr;
        wire [31:0]o_d_idata;
        wire [31:0]i_d_odata;
        //facing DR1
        wire o_dr1wen;
        wire [31:0]o_dr1_idata;
        wire [31:0]i_dr1_odata;
    
        reg clk;
    
    MACtrl test_MAC(
        //facing core
        .i_iaddr(i_iaddr),
        .o_idata(o_idata),
        .i_dwen(i_dwen),
        .i_daddr(i_daddr),
        .i_d_idata(i_d_idata),
        .o_d_odata(o_d_odata),
        //facing IMem
        .o_iaddr(o_iaddr),
        .i_idata(i_idata),
        //facing DMem
        .o_dwen(o_dwen),
        .o_daddr(o_daddr),
        .o_d_idata(o_d_idata),
        .i_d_odata(i_d_odata),
        //facing DR1
        .o_dr1wen(o_dr1wen),
        .o_dr1_idata(o_dr1_idata),
        .i_dr1_odata(i_dr1_odata)
    );
    
    Mem m0(
        //for IMem
        .i_addr(o_iaddr),
        .i_data(i_idata),
        //for DMem
        .clk(clk),
        .d_wen(o_dwen),
        .d_addr(o_daddr),
        .d_i_data(o_d_idata),
        .d_o_data(i_d_odata)
    );
    
    LEDCtrl dr1(
        .wen(o_dr1wen),
        .i_data(o_dr1_idata),
        .o_data(i_dr1_odata)
    );
    
    always begin clk = ~clk; #10; end
    initial begin
       clk = 0;
       //Imem读指令
       i_iaddr = 0;
       //i_idata = 32'h32001052;
       #100;
       //对DMem只读
       i_dwen = 0;
       i_daddr = 1;
       //i_d_odata = 32'h00105278;
       #100;
       //对DMem改写
       i_dwen = 1;
       i_d_idata = 32'h52780000;
       #100;
       //对LED只读
       i_dwen = 0;
       i_daddr = 32'hFE000000;
       //i_dr1_odata = 32'h12345678;
       #100;
       //对LED改写
       i_dwen = 1;
       #100;
    end
endmodule
