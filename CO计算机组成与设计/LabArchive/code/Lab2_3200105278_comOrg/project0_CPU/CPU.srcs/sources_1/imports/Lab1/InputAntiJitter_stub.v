// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Tue Feb 23 22:37:46 2021
// Host        : ziyue-ubuntu running 64-bit Ubuntu 20.04.1 LTS
// Command     : write_verilog -mode synth_stub InputAntiJitter_stub.v
// Design      : InputAntiJitter
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k160tffg676-2L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module InputAntiJitter(clk, rstn, key_col, sw_in, rst, key_row, key_x, key_y, 
  sw)
/* synthesis syn_black_box black_box_pad_pin="clk,rstn,key_col[4:0],sw_in[15:0],rst,key_row[4:0],key_x[4:0],key_y[4:0],sw[15:0]" */;
  input clk;
  input rstn;
  input [4:0]key_col;
  input [15:0]sw_in;
  output rst;
  output [4:0]key_row;
  output [4:0]key_x;
  output [4:0]key_y;
  output [15:0]sw;
endmodule
