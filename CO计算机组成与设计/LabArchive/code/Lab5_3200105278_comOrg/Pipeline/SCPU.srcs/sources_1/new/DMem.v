`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/11 10:07:24
// Design Name: 
// Module Name: DMem
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


module DMem (
    input clk,
    input wen,
    input ren,
    input [31:0]addr,//wrong : [11:0]addr
    input [31:0]i_data,
    output [31:0] o_data
);
    wire [31:0] addr_word;
    (* ram_style = "block" *) reg [31:0] dmem[0:4095];
    initial $readmemh("dmem_data.mem", dmem);
    always @(posedge clk) begin
        if (wen) dmem[addr_word] <= i_data;
        // else if (ren) o_data <= dmem[addr];
    end
    assign addr_word = ($signed(addr) >>> 32'd2);
    assign o_data = ren ? dmem[addr_word] : 32'hZZZZZZZZ;
endmodule