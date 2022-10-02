`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/11 09:58:20
// Design Name: 
// Module Name: IMem
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


module IMem(
    input [31:0] addr,//这里地址是12位，但是pc是32位
    output [31:0] data
);
    
    // reg [11:0] addr = 0;

    (* ram_style = "block" *) reg [31:0] imem[0:4095]; //here is word-addressed
    initial $readmemh("imem_data.mem", imem);
    assign data = imem[addr >> 2];
endmodule
