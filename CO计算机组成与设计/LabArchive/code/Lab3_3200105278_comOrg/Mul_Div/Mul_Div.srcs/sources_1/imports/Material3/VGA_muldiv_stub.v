// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Mon Mar 22 13:50:17 2021
// Host        : DESKTOP-IBPL55N running 64-bit major release  (build 9200)
// Command     : write_verilog -mode synth_stub VGA_muldiv_stub.v
// Design      : VGA_muldiv
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k160tffg676-2L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module VGA_muldiv(dbg_A, dbg_B, dbg_mul_res, dbg_div_res, 
  dbg_div_rem, dbg_div_by_0, rst, clk_div, hs, vs, vga_r, vga_g, vga_b)
/* synthesis syn_black_box black_box_pad_pin="dbg_A[31:0],dbg_B[31:0],dbg_mul_res[31:0],dbg_div_res[31:0],dbg_div_rem[31:0],dbg_div_by_0,rst,clk_div[31:0],hs,vs,vga_r[3:0],vga_g[3:0],vga_b[3:0]" */;
  input [31:0]dbg_A;
  input [31:0]dbg_B;
  input [31:0]dbg_mul_res;
  input [31:0]dbg_div_res;
  input [31:0]dbg_div_rem;
  input dbg_div_by_0;
  input rst;
  input [31:0]clk_div;
  output hs;
  output vs;
  output [3:0]vga_r;
  output [3:0]vga_g;
  output [3:0]vga_b;
endmodule
