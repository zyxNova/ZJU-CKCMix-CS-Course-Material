`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/03 14:03:13
// Design Name: 
// Module Name: MACtrl
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


module MACtrl(
        //facing core
        input [31:0]i_iaddr,
        output [31:0]o_idata,
        input i_dwen,
        input [31:0]i_daddr,
        input [31:0]i_d_idata,
        output [31:0]o_d_odata,
        //facing IMem
        output [31:0]o_iaddr,
        input [31:0]i_idata,
        //facing DMem
        output o_dwen,
        output [31:0]o_daddr,
        output [31:0]o_d_idata,
        input [31:0]i_d_odata,
        //facing DR1
        output o_dr1wen,
        output [31:0]o_dr1_idata,
        input [31:0]i_dr1_odata
    );
    
    assign o_iaddr = i_iaddr;
    assign o_idata = i_idata;
    /*
    if (i_daddr != 32'hFE000000) begin//这种语法为什么会错误?报错：'i_daddr' is not a constant
        assign o_dr1wen = 0;
        assign o_dwen = i_dwen;
        assign o_daddr = i_daddr;
        assign o_d_idata = i_d_idata;
        assign o_d_odata = i_d_odata;
        end
    else begin
        assign o_dwen = 0;
        assign o_dr1wen = i_dwen;
        assign o_dr1_idata = i_d_idata;
        assign o_d_odata = i_dr1_odata;
        end
    */
    assign o_dr1wen = (i_daddr != 32'hFE000000) ? 0 : i_dwen;
    assign o_dwen = (i_daddr != 32'hFE000000) ? i_dwen : 0;
    assign o_daddr = (i_daddr != 32'hFE000000) ? i_daddr : o_daddr;
    assign o_d_idata = (i_daddr != 32'hFE000000) ? i_d_idata : o_d_idata;
    assign o_d_odata = (i_daddr != 32'hFE000000) ? i_d_odata : i_dr1_odata;
    assign o_dr1_idata = (i_daddr != 32'hFE000000) ? o_dr1_idata : i_d_idata;
endmodule
