// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Sun Mar  7 19:32:21 2021
// Host        : ziyue-ubuntu running 64-bit Ubuntu 20.04.2 LTS
// Command     : write_verilog -mode synth_stub IMem_stub.v
// Design      : IMem
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k160tffg676-2L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module IMem(addr, data)
/* synthesis syn_black_box black_box_pad_pin="addr[31:0],data[31:0]" */;
  input [31:0]addr;
  output [31:0]data;
endmodule
