`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/11 15:02:20
// Design Name: 
// Module Name: core_tb
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
module core_tb;
    reg clk_cpu;
    reg rst;
    reg ext_int;
    wire tim_int;
    wire INT;
    `VGA_DBG_Core_Declaration
    `VGA_DBG_RegFile_Declaration
    `VGA_DBG_Csr_Declaration
    wire [31:0] imem_addr;
    wire [31:0] imem_o_data;

    wire [31:0] dmem_addr;
    wire [31:0] dmem_o_data;
    wire [31:0] dmem_i_data;
    wire dmem_wen;
    wire dmem_ren;

    always #50 clk_cpu = ~clk_cpu;
    initial begin
        rst = 1;
        clk_cpu = 1;
        ext_int = 0;
        #10;
        rst = 0;
        #2000
        ext_int = 1;
        #100
        ext_int = 0;
    end

    Core core(
        `VGA_DBG_Core_Arguments
        .clk(clk_cpu),
        .rst(rst),
        .imem_addr(imem_addr),
        .imem_o_data(imem_o_data),
        .dmem_addr(dmem_addr),
        .dmem_o_data(dmem_o_data),
        .dmem_i_data(dmem_i_data),
        .dmem_wen(dmem_wen),
        .dmem_ren(dmem_ren),
        .ext_int(ext_int),
        .tim_int(tim_int),
        .INT(INT)
    );

    wire [31:0] o_imem_addr;
    wire [31:0] i_imem_o_data;
    wire [31:0] o_dmem_addr;
    wire [31:0] i_dmem_o_data;
    wire [31:0] o_dmem_i_data;
    wire o_dmem_wen;
    wire o_dmem_ren;//
    
    MACtrl memacc(
        //facing core
        .i_iaddr(imem_addr),
        .o_idata(imem_o_data),
        .i_dwen(dmem_wen),
        .i_dren(dmem_ren),//
        .i_daddr(dmem_addr),
        .i_d_idata(dmem_i_data),
        .o_d_odata(dmem_o_data),
        //facing IMem
        .o_iaddr(o_imem_addr),
        .i_idata(i_imem_o_data),
        //facing DMem
        .o_dren(o_dmem_ren),
        .o_dwen(o_dmem_wen),//
        .o_daddr(o_dmem_addr),
        .o_d_idata(o_dmem_i_data),
        .i_d_odata(i_dmem_o_data),
        //facing DR1
        .o_dr1wen(dr1_wen),
        .o_dr1_idata(dr1_i_data),
        .i_dr1_odata(dr1_o_data)
    );
    Mem mem(
        .i_addr(o_imem_addr),
        .i_data(i_imem_o_data),
        .clk(~clk_cpu),//注意这里是时钟负边沿memory写入！！
        .d_wen(o_dmem_wen),
        .d_ren(o_dmem_ren),//
        .d_addr(o_dmem_addr),
        .d_i_data(o_dmem_i_data),
        .d_o_data(i_dmem_o_data)
    );

    // forget to add LEDCtrl to tb.v
    wire dr1_wen;
    wire [31:0] dr1_o_data;
    wire [31:0] dr1_i_data;    
    LEDCtrl dr1(
        .clk(~clk_cpu), //LEDCtrl is similar to DMem
        .rst(rst),
        .wen(dr1_wen),
        .i_data(dr1_i_data),
        .o_data(dr1_o_data),
        .o_led_ctrl(LED_o)
    );

    
endmodule
