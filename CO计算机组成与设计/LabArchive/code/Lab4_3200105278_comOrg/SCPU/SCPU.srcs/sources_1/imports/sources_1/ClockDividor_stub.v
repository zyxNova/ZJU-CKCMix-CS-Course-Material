// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Tue Feb 23 22:31:46 2021
// Host        : ziyue-ubuntu running 64-bit Ubuntu 20.04.1 LTS
// Command     : write_verilog -mode synth_stub ClockDividor_stub.v
// Design      : ClockDividor
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k160tffg676-2L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module ClockDividor(clk, rst, step_en, clk_step, clk_div, clk_cpu)
/* synthesis syn_black_box black_box_pad_pin="clk,rst,step_en,clk_step,clk_div[31:0],clk_cpu" */;
  input clk;
  input rst;
  input step_en;
  input clk_step;
  output [31:0]clk_div;
  output clk_cpu;
endmodule
