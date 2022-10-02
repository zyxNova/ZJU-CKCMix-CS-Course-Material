`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/02 15:31:12
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

module DMem #(parameter
    SIZE = 2048,
    WIDTH = 32,
    BLOCK = 4*WIDTH
) (
    input clk,
    input wen,
    input ren,
    input [WIDTH - 1:0] addr, 
    input [BLOCK - 1:0] i_data, 
    output reg [BLOCK - 1:0] o_data, 
    output reg ready
);

    wire [$clog2(SIZE)+1:0] d_addr = addr[$clog2(SIZE)+1:0];

    (* ram_style = "block" *) reg [WIDTH - 1:0] mem[0:SIZE - 1];
    initial $readmemh("dmem.mem", mem);

    always @(posedge clk) begin
        if (wen) begin
            mem[(d_addr >> 2)] <= i_data[WIDTH-1:0];
            mem[(d_addr >> 2) + 1] <= i_data[2*WIDTH-1:WIDTH]; //+?????>>
            mem[(d_addr >> 2) + 2] <= i_data[3*WIDTH-1:2*WIDTH];
            mem[(d_addr >> 2) + 3] <= i_data[4*WIDTH-1:3*WIDTH];
            ready <= 1;
        end
        else if (ren) begin
            o_data[WIDTH-1:0] = mem[d_addr >> 2];
            o_data[2*WIDTH-1:WIDTH] = mem[(d_addr >> 2) + 1];
            o_data[3*WIDTH-1:2*WIDTH] = mem[(d_addr >> 2) + 2];
            o_data[4*WIDTH-1:3*WIDTH] = mem[(d_addr >> 2) + 3];
            ready <= 1;
        end
        else ready <= 0;
    end
    
endmodule
