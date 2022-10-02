`include "Defines.vh"

module Core (
    `VGA_DBG_Core_Outputs
    input clk, rst,
    input [31:0] imem_o_data,
    input [31:0] dmem_o_data,
    output [31:0] imem_addr,
    output dmem_wen,
    output [31:0] dmem_addr,
    output [31:0] dmem_i_data
);

    wire [31:0] alu_res;
    wire cmp_res;
    wire [31:0] rs1_val, rs2_val;
    wire [31:0] a_val, b_val;
    wire [3:0] alu_ctrl;
    wire [2:0] cmp_ctrl;
    wire reg_wen;
    wire [4:0] rs1, rs2, rd;
    wire [31:0] reg_i_data;

    CoreOthers core_others(
        `VGA_DBG_CoreOthers_Ports
        .clk(clk),
        .rst(rst),
        .imem_o_data(imem_o_data),
        .dmem_o_data(dmem_o_data),
        .imem_addr(imem_addr),
        .dmem_wen(dmem_wen),
        .dmem_addr(dmem_addr),
        .dmem_i_data(dmem_i_data),
        
        // added
        .alu_res(alu_res),
        .cmp_res(cmp_res),
        .rs1_val(rs1_val),
        .rs2_val(rs2_val),
        .a_val(a_val), 
        .b_val(b_val),
        .alu_ctrl(alu_ctrl),
        .cmp_ctrl(cmp_ctrl),
        .reg_wen(reg_wen),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .reg_i_data(reg_i_data)
    );

    Alu alu(
        .a_val(a_val),
        .b_val(b_val),
        .ctrl(alu_ctrl),
        .result(alu_res)
    );

    Comparator comparator(
        .a_val(rs1_val),
        .b_val(rs2_val),
        .ctrl(cmp_ctrl),
        .result(cmp_res)
    );

    RegFile reg_file(
        `VGA_DBG_RegFile_Arguments
        .clk(~clk),
        .rst(rst),
        .wen(reg_wen),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .i_data(reg_i_data),
        .rs1_val(rs1_val),
        .rs2_val(rs2_val)
    );

   
endmodule
