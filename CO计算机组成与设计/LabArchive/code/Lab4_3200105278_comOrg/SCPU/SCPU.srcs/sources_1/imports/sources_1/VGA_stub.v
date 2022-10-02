// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Tue Feb 23 22:43:15 2021
// Host        : ziyue-ubuntu running 64-bit Ubuntu 20.04.1 LTS
// Command     : write_verilog -mode synth_stub VGA_stub.v
// Design      : VGA
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k160tffg676-2L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module VGA(pc, inst, rs1, rs1_val, rs2, rs2_val, rd, reg_i_data, 
  reg_wen, is_imm, is_auipc, is_lui, imm, a_val, b_val, alu_ctrl, cmp_ctrl, alu_res, cmp_res, is_branch, 
  is_jal, is_jalr, do_branch, pc_branch, mem_wen, mem_ren, dmem_o_data, dmem_i_data, dmem_addr, x0, ra, 
  sp, gp, tp, t0, t1, t2, s0, s1, a0, a1, a2, a3, a4, a5, a6, a7, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, t3, t4, t5, t6, rst, clk_div, hs, vs, 
  vga_r, vga_g, vga_b)
/* synthesis syn_black_box black_box_pad_pin="pc[31:0],inst[31:0],rs1[4:0],rs1_val[31:0],rs2[4:0],rs2_val[31:0],rd[4:0],reg_i_data[31:0],reg_wen,is_imm,is_auipc,is_lui,imm[31:0],a_val[31:0],b_val[31:0],alu_ctrl[3:0],cmp_ctrl[2:0],alu_res[31:0],cmp_res,is_branch,is_jal,is_jalr,do_branch,pc_branch[31:0],mem_wen,mem_ren,dmem_o_data[31:0],dmem_i_data[31:0],dmem_addr[31:0],x0[31:0],ra[31:0],sp[31:0],gp[31:0],tp[31:0],t0[31:0],t1[31:0],t2[31:0],s0[31:0],s1[31:0],a0[31:0],a1[31:0],a2[31:0],a3[31:0],a4[31:0],a5[31:0],a6[31:0],a7[31:0],s2[31:0],s3[31:0],s4[31:0],s5[31:0],s6[31:0],s7[31:0],s8[31:0],s9[31:0],s10[31:0],s11[31:0],t3[31:0],t4[31:0],t5[31:0],t6[31:0],rst,clk_div[31:0],hs,vs,vga_r[3:0],vga_g[3:0],vga_b[3:0]" */;
  input [31:0]pc;
  input [31:0]inst;
  input [4:0]rs1;
  input [31:0]rs1_val;
  input [4:0]rs2;
  input [31:0]rs2_val;
  input [4:0]rd;
  input [31:0]reg_i_data;
  input reg_wen;
  input is_imm;
  input is_auipc;
  input is_lui;
  input [31:0]imm;
  input [31:0]a_val;
  input [31:0]b_val;
  input [3:0]alu_ctrl;
  input [2:0]cmp_ctrl;
  input [31:0]alu_res;
  input cmp_res;
  input is_branch;
  input is_jal;
  input is_jalr;
  input do_branch;
  input [31:0]pc_branch;
  input mem_wen;
  input mem_ren;
  input [31:0]dmem_o_data;
  input [31:0]dmem_i_data;
  input [31:0]dmem_addr;
  input [31:0]x0;
  input [31:0]ra;
  input [31:0]sp;
  input [31:0]gp;
  input [31:0]tp;
  input [31:0]t0;
  input [31:0]t1;
  input [31:0]t2;
  input [31:0]s0;
  input [31:0]s1;
  input [31:0]a0;
  input [31:0]a1;
  input [31:0]a2;
  input [31:0]a3;
  input [31:0]a4;
  input [31:0]a5;
  input [31:0]a6;
  input [31:0]a7;
  input [31:0]s2;
  input [31:0]s3;
  input [31:0]s4;
  input [31:0]s5;
  input [31:0]s6;
  input [31:0]s7;
  input [31:0]s8;
  input [31:0]s9;
  input [31:0]s10;
  input [31:0]s11;
  input [31:0]t3;
  input [31:0]t4;
  input [31:0]t5;
  input [31:0]t6;
  input rst;
  input [31:0]clk_div;
  output hs;
  output vs;
  output [3:0]vga_r;
  output [3:0]vga_g;
  output [3:0]vga_b;
endmodule
