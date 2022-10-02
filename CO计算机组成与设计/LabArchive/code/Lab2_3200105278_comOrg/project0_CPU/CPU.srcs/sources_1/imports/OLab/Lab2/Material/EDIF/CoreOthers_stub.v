// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Sun Mar  7 18:46:51 2021
// Host        : ziyue-ubuntu running 64-bit Ubuntu 20.04.2 LTS
// Command     : write_verilog -mode synth_stub CoreOthers_stub.v
// Design      : CoreOthers
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k160tffg676-2L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module CoreOthers(dbg_pc, dbg_inst, dbg_rs1, dbg_rs1_val, dbg_rs2, 
  dbg_rs2_val, dbg_rd, dbg_reg_i_data, dbg_reg_wen, dbg_is_imm, dbg_is_auipc, dbg_is_lui, 
  dbg_imm, dbg_a_val, dbg_b_val, dbg_alu_ctrl, dbg_cmp_ctrl, dbg_alu_res, dbg_cmp_res, 
  dbg_is_branch, dbg_is_jal, dbg_is_jalr, dbg_do_branch, dbg_pc_branch, dbg_mem_wen, 
  dbg_mem_ren, dbg_dmem_o_data, dbg_dmem_i_data, dbg_dmem_addr, clk, rst, imem_o_data, 
  dmem_o_data, imem_addr, dmem_wen, dmem_addr, dmem_i_data, alu_res, cmp_res, rs1_val, rs2_val, 
  a_val, b_val, alu_ctrl, cmp_ctrl, reg_wen, rs1, rs2, rd, reg_i_data)
/* synthesis syn_black_box black_box_pad_pin="dbg_pc[31:0],dbg_inst[31:0],dbg_rs1[4:0],dbg_rs1_val[31:0],dbg_rs2[4:0],dbg_rs2_val[31:0],dbg_rd[4:0],dbg_reg_i_data[31:0],dbg_reg_wen,dbg_is_imm,dbg_is_auipc,dbg_is_lui,dbg_imm[31:0],dbg_a_val[31:0],dbg_b_val[31:0],dbg_alu_ctrl[3:0],dbg_cmp_ctrl[2:0],dbg_alu_res[31:0],dbg_cmp_res,dbg_is_branch,dbg_is_jal,dbg_is_jalr,dbg_do_branch,dbg_pc_branch[31:0],dbg_mem_wen,dbg_mem_ren,dbg_dmem_o_data[31:0],dbg_dmem_i_data[31:0],dbg_dmem_addr[31:0],clk,rst,imem_o_data[31:0],dmem_o_data[31:0],imem_addr[31:0],dmem_wen,dmem_addr[31:0],dmem_i_data[31:0],alu_res[31:0],cmp_res,rs1_val[31:0],rs2_val[31:0],a_val[31:0],b_val[31:0],alu_ctrl[3:0],cmp_ctrl[2:0],reg_wen,rs1[4:0],rs2[4:0],rd[4:0],reg_i_data[31:0]" */;
  output [31:0]dbg_pc;
  output [31:0]dbg_inst;
  output [4:0]dbg_rs1;
  output [31:0]dbg_rs1_val;
  output [4:0]dbg_rs2;
  output [31:0]dbg_rs2_val;
  output [4:0]dbg_rd;
  output [31:0]dbg_reg_i_data;
  output dbg_reg_wen;
  output dbg_is_imm;
  output dbg_is_auipc;
  output dbg_is_lui;
  output [31:0]dbg_imm;
  output [31:0]dbg_a_val;
  output [31:0]dbg_b_val;
  output [3:0]dbg_alu_ctrl;
  output [2:0]dbg_cmp_ctrl;
  output [31:0]dbg_alu_res;
  output dbg_cmp_res;
  output dbg_is_branch;
  output dbg_is_jal;
  output dbg_is_jalr;
  output dbg_do_branch;
  output [31:0]dbg_pc_branch;
  output dbg_mem_wen;
  output dbg_mem_ren;
  output [31:0]dbg_dmem_o_data;
  output [31:0]dbg_dmem_i_data;
  output [31:0]dbg_dmem_addr;
  input clk;
  input rst;
  input [31:0]imem_o_data;
  input [31:0]dmem_o_data;
  output [31:0]imem_addr;
  output dmem_wen;
  output [31:0]dmem_addr;
  output [31:0]dmem_i_data;
  input [31:0]alu_res;
  input cmp_res;
  input [31:0]rs1_val;
  input [31:0]rs2_val;
  output [31:0]a_val;
  output [31:0]b_val;
  output [3:0]alu_ctrl;
  output [2:0]cmp_ctrl;
  output reg_wen;
  output [4:0]rs1;
  output [4:0]rs2;
  output [4:0]rd;
  output [31:0]reg_i_data;
endmodule
