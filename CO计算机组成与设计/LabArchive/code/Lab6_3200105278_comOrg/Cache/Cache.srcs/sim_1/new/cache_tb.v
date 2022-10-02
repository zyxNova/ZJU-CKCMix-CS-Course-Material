`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/02 15:53:47
// Design Name: 
// Module Name: cache_tb
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


module cache_tb;
    reg clk;
    reg clk_mem;
    reg rst;
    reg Rd_cpu;
    reg Wr_cpu;
    reg [31:0] Addr_cpu;
    reg [31:0] data_cpu_write;
    wire [31:0] data_cpu_read; // 这里是最后结果
    wire [1:0] state;
    wire hit;
    wire [7:0]index;
    wire [19:0] tag;
    wire [127:0] data_mem_read;
    wire Rdy_mem;
    wire Rd_mem;
    wire Wr_mem;
    wire [31:0] Addr_mem;
    wire [127:0] data_mem_write;
    wire [149 : 0] line_data;

    always #5 clk = ~clk;
    always #30 clk_mem = ~clk_mem;
    initial begin
        rst = 1;
        Rd_cpu = 0;
        Wr_cpu = 0;
        Addr_cpu = 0;
        data_cpu_write = 0;
        clk = 1;
        clk_mem = 1;
        #10;
        rst = 0;
        
        #50
        // read miss
        Rd_cpu = 1;
        Addr_cpu = 4; // read addr = 32'h0000_0004, 读出第一个word，应为00000001
        
        // read miss
        #100
        Addr_cpu = 32'h0000_0010; // read addr = 32'h0000_0010，读出第4个word

        // read hit
        #100
        Addr_cpu = 32'h0000_000C; // read addr = 32'h0000_000C，读出第3个word

        // write hit
        #100
        Rd_cpu = 0;
        Wr_cpu = 1;
        Addr_cpu = 32'h0000_0008; // write addr = 32'h0000_0008，修改第2个word
        data_cpu_write = 32'h1234_5678;

        // read hit
        #100
        Wr_cpu = 0;
        Rd_cpu = 1;

        // write miss
        #100
        Rd_cpu = 0;
        Wr_cpu = 1;
        Addr_cpu = 32'h0000_0020; // write addr = 32'h0000_0020，读第8个word
        data_cpu_write = 32'h9876_5432;

        // read hit
        #100
        Wr_cpu = 0;
        Rd_cpu = 1;

        // 冲突失配，先把脏块写回去
        #100
        Rd_cpu = 0;
        Wr_cpu = 1;
        Addr_cpu = 32'h0000_1020; 
        data_cpu_write = 32'h2333_3333;

        // read MISS
        #100
        Wr_cpu = 0;
        Rd_cpu = 1;
        Addr_cpu = 32'h0000_0024; // write addr = 32'h0000_0024，读第9个word
    end

    Cache cache(
        .clk(clk),
        .rst(rst),
        .Rd_cpu(Rd_cpu),
        .Wr_cpu(Wr_cpu),
        .Addr_cpu(Addr_cpu),
        .data_cpu_write(data_cpu_write),
        .Rdy_mem(Rdy_mem),
        .data_mem_read(data_mem_read),
        .data_cpu_read(data_cpu_read),
        .Rd_mem(Rd_mem),
        .Wr_mem(Wr_mem),
        .Addr_mem(Addr_mem),
        .data_mem_write(data_mem_write),
        .hit(hit),
        .index(index),
        .tag(tag),
        .line_data(line_data),
        .state(state)
    );

    DMem dmem(
        .clk(clk_mem), //可能mem比cache慢
        .wen(Wr_mem),
        .ren(Rd_mem),
        .addr(Addr_mem),
        .i_data(data_mem_write),
        .o_data(data_mem_read),
        .ready(Rdy_mem)
    );
    
endmodule
