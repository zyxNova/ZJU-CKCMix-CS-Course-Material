// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Sun Mar  7 19:40:17 2021
// Host        : ziyue-ubuntu running 64-bit Ubuntu 20.04.2 LTS
// Command     : write_verilog -mode synth_stub DMem_stub.v
// Design      : DMem
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k160tffg676-2L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module DMem(clk, wen, addr, i_data, o_data)
/* synthesis syn_black_box black_box_pad_pin="clk,wen,addr[31:0],i_data[31:0],o_data[31:0]" */;
  input clk;
  input wen;
  input [31:0]addr;
  input [31:0]i_data;
  output [31:0]o_data;
endmodule
