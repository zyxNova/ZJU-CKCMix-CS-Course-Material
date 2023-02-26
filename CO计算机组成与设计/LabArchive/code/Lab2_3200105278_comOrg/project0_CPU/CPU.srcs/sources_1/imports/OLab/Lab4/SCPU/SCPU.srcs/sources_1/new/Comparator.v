`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/17 22:02:38
// Design Name: 
// Module Name: Comparator
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

`define CMP_EQ  3'd0
`define CMP_NE  3'd1
`define CMP_LT  3'd2
`define CMP_LTU 3'd3
`define CMP_GE  3'd4
`define CMP_GEU 3'd5

module Comparator(
 input [31:0] a_val, // ����ֵ a_val
 input [31:0] b_val, // ����ֵ b_bal
 input [2:0] ctrl, // �Ƚ����Ŀ����ź�
 output reg result // �����1bit�Ĳ���ֵ��
);

    wire EQ_res;
    wire NE_res;
    wire LT_res;
    wire LTU_res;
    wire GE_res;
    wire GEU_res;
    
    assign EQ_res = (a_val == b_val) ? 1 : 0;
    assign NE_res = ~EQ_res;
    assign LT_res = ($signed(a_val) < $signed(b_val)) ? 1 : 0;
    assign LTU_res = (a_val < b_val) ? 1 : 0;
    assign GE_res = ~LT_res;
    assign GEU_res = ~LTU_res;
    
    always @* begin
        case (ctrl)
            `CMP_EQ: result = EQ_res;
            `CMP_NE: result = NE_res;
            `CMP_LT: result = LT_res;
            `CMP_LTU:result = LTU_res;
            `CMP_GE: result = GE_res;
            `CMP_GEU:result = GEU_res;
        endcase
    end

endmodule
