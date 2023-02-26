`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/28 14:26:45
// Design Name: 
// Module Name: CSR
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

module CSR(
    `VGA_DBG_Csr_Outputs //7个寄存器的debug信号
    input clk, rst,
    input wen,
    input [11:0] ind,
    input [31:0] i_data,
    input [31:0] EPCval,
    input [31:0] CauseVal,
    input [31:0] tval,
    input is_exp,
    input is_mret,
    output reg [31:0] o_data,
    output reg INT,
    output reg [31:0] pc_exp
    );
    reg [31:0] mstatus_o;
    reg [31:0] mcause_o;
    reg [31:0] mepc_o;
    reg [31:0] mtval_o;
    reg [31:0] mtvec_o;
    reg [31:0] mie_o;
    reg [31:0] mip_o;
    `VGA_DBG_Csr_Assignments
    always @* begin
        case (ind) 
            `CSR_MSTATUS: o_data = mstatus_o;
            `CSR_MIE: o_data = mie_o;
            `CSR_MIP: o_data = mip_o;
            `CSR_MEPC: o_data = mepc_o;
            `CSR_MCAUSE: o_data = mcause_o;
            `CSR_MTVAL: o_data = mtval_o;
            `CSR_MTVEC: o_data = mtvec_o;
        endcase
        if (INT) pc_exp = mtvec_o;
        else if (is_mret) pc_exp = mepc_o;
    end
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            mstatus_o <= 0;
            mcause_o <= 0;
            mepc_o <= 0;
            mtval_o <= 0;
            mtvec_o <= 0;
            mie_o <= 0;
            mip_o <= 0;
            INT <= 0;
        end
        else if (wen) begin
            INT <= mstatus_o[3] & mie_o[mcause_o[3:0]] & mip_o[mcause_o[3:0]];
            case (ind) 
                `CSR_MSTATUS: mstatus_o <= i_data;
                `CSR_MIE: mie_o <= i_data;
                `CSR_MIP: mip_o <= i_data;
                `CSR_MEPC: mepc_o <= i_data;
                `CSR_MCAUSE: mcause_o <= i_data;
                `CSR_MTVAL: mtval_o <= i_data;
                `CSR_MTVEC: mtvec_o <= i_data;
            endcase
        end
        else begin
            if (is_exp) mip_o[CauseVal[3:0]] = 1;
            else if (is_mret) mip_o[mcause_o[3:0]] = 0;
            if (mstatus_o[3] & mie_o[CauseVal[3:0]] & mip_o[CauseVal[3:0]] | is_mret) begin
                if (is_mret) begin
                    mstatus_o[3] <= mstatus_o[7];
                    mstatus_o[7] <= 1;
                end
                else begin
                    mepc_o <= EPCval;
                    mcause_o = CauseVal;
                    mtval_o <= tval;
                    mstatus_o[7] <= mstatus_o[3];
                    mstatus_o[3] <= 0;
                end
            end
            INT = mstatus_o[3] & mie_o[mcause_o[3:0]] & mip_o[mcause_o[3:0]];
        end
    end
endmodule
