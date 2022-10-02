`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/02 11:18:57
// Design Name: 
// Module Name: Cache
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

/** cache参数
direct-mapped cache

1 word = 4 bytes
addr 32 bit
block size = 4 words -> block offset = 4 bit
#block = 256 -> index = 8 bit
tag = 32 - 4 - 8 = 20 bit
valid = 1 bit
valid   tag     block_data
1       20      4*4*8 = 128bit

tag(20)     index(8)   word_num(2bit) byte_num(2bit)
*/

`define IDLE           2'b00
`define CompareTag     2'b01
`define WriteBack      2'b10
`define Allocate       2'b11

module Cache #(parameter
    WORD_WIDTH = 32,
    BLOCK_WIDTH = 4*WORD_WIDTH,
    BYTE_OFS = 2,
    WORD_OFS = 2,
    SETS = 256,
    INDEX = 8,
    TAG = WORD_WIDTH - BYTE_OFS - WORD_OFS - INDEX,
    V = 1,
    D = 1,
    DATA = 128,
    LINE = V+D+TAG+DATA
) (
    input clk,
    input rst,
    input Rd_cpu,
    input Wr_cpu,
    input [WORD_WIDTH - 1:0] Addr_cpu,      // cpu传给cache
    input [WORD_WIDTH - 1:0] data_cpu_write, // cpu传给cache
    input Rdy_mem,              // mem传给cache表示已经读好
    input [BLOCK_WIDTH - 1:0] data_mem_read, // mem传给cache
    output reg [WORD_WIDTH - 1:0] data_cpu_read, //cache传给cpu
    output reg Rd_mem,              // cache传给mem的读信号
    output reg Wr_mem,              // cache传给mem的写信号
    output reg [WORD_WIDTH - 1:0] Addr_mem,     // cache传给mem
    output reg [BLOCK_WIDTH - 1:0] data_mem_write, // cache传给mem
    output hit,
    // output valid,
    // output dirty,
    output wire [TAG-1 : 0] tag,
    output wire [INDEX-1 : 0] index,
    output wire [LINE-1 : 0] line_data,
    output reg [1:0] state,
    output reg [1:0] next_state
    );

    reg [LINE-1 : 0] cache [0:SETS-1];
    initial $readmemh("cache_data.mem", cache);

    reg [1:0] state;
    reg [1:0] next_state;
    wire valid;
    wire dirty;
    // wire [TAG-1 : 0] tag;
    // wire [INDEX-1 : 0] index;
    wire [WORD_OFS-1 : 0] word_num;
    // wire [BYTE_OFS-1 : 0] byte_num; 不需要byte-addressed
    // wire [LINE-1 : 0] line_data;
    wire [TAG-1 : 0] cache_tag;
    // wire hit;

    assign tag = addr_compTag[WORD_WIDTH-1 : BYTE_OFS+WORD_OFS+INDEX];
    assign index = addr_compTag[BYTE_OFS+WORD_OFS+INDEX-1 : BYTE_OFS+WORD_OFS];
    assign word_num = addr_compTag[BYTE_OFS+WORD_OFS-1 : BYTE_OFS];
    // assign byte_num = addr_compTag[BYTE_OFS-1 : 0];

    assign line_data = cache[index];
    assign valid = line_data[LINE-1];
    assign dirty = line_data[LINE-V-1];
    assign cache_tag = line_data[LINE-V-D-1 : LINE-V-D-TAG];
    assign hit = valid && (tag == cache_tag);
    

    reg rd_compTag;
    reg wr_compTag;
    reg [WORD_WIDTH-1:0] write_data_compTag;
    reg [WORD_WIDTH-1:0] addr_compTag;
    always @(posedge clk or posedge rst) begin
        if (rst) state <= `IDLE;
        else state <= next_state;
    end

    always @* begin
        case (state) 
            `IDLE:begin
                if (Rd_cpu | Wr_cpu) begin
                    next_state = `CompareTag;
                    rd_compTag = Rd_cpu;
                    write_data_compTag = data_cpu_write;
                    wr_compTag = Wr_cpu;
                    addr_compTag = Addr_cpu;
                end
                else next_state = `IDLE;
            end
            `CompareTag:begin
                if (hit) begin
                    if (rd_compTag) begin
                        //从block中读word到cpu
                        case (word_num) 
                            3: data_cpu_read = line_data[LINE-V-D-TAG-1 : LINE-V-D-TAG-WORD_WIDTH];
                            2: data_cpu_read = line_data[LINE-V-D-TAG-WORD_WIDTH-1 : LINE-V-D-TAG-2*WORD_WIDTH];
                            1: data_cpu_read = line_data[LINE-V-D-TAG-2*WORD_WIDTH-1 : LINE-V-D-TAG-3*WORD_WIDTH];
                            0: data_cpu_read = line_data[LINE-V-D-TAG-3*WORD_WIDTH-1 : LINE-V-D-TAG-4*WORD_WIDTH];
                        endcase
                    end
                    else if (wr_compTag) begin //写word到cache
                        case (word_num) 
                            3: cache[index] = {2'b11, tag, write_data_compTag, line_data[LINE-V-D-TAG-WORD_WIDTH-1 : 0]};
                            2: cache[index] = {2'b11, tag, line_data[LINE-V-D-TAG-1 : LINE-V-D-TAG-WORD_WIDTH], write_data_compTag, line_data[LINE-V-D-TAG-2*WORD_WIDTH-1 : 0]};
                            1: cache[index] = {2'b11, tag, line_data[LINE-V-D-TAG-1 : LINE-V-D-TAG-2*WORD_WIDTH], write_data_compTag, line_data[LINE-V-D-TAG-3*WORD_WIDTH-1 : LINE-V-D-TAG-4*WORD_WIDTH]};
                            0: cache[index] = {2'b11, tag, line_data[LINE-V-D-TAG-1 : LINE-V-D-TAG-3*WORD_WIDTH], write_data_compTag};
                        endcase
                    end
                    next_state = `IDLE;
                end
                else begin
                    if (dirty) next_state = `WriteBack;
                    else next_state = `Allocate;
                end
            end
            `WriteBack:begin
                Addr_mem = {cache_tag, index, 4'b0000}; 
                Wr_mem = 1;
                data_mem_write = line_data[LINE-V-D-TAG-1 : 0];
                if (~Rdy_mem) next_state = `WriteBack;
                else begin
                    Wr_mem = 0;
                    next_state = `Allocate;
                end
            end
            `Allocate:begin
                Addr_mem = {addr_compTag[WORD_WIDTH-1 : WORD_OFS+BYTE_OFS], 4'b0000}; 
                Rd_mem = 1;
                if (~Rdy_mem) next_state = `Allocate;
                else begin
                    cache[index] = {2'b10, tag, data_mem_read}; //写入cache[index]
                    Rd_mem = 0;
                    next_state = `CompareTag;
                end
            end
        endcase
    end

endmodule
