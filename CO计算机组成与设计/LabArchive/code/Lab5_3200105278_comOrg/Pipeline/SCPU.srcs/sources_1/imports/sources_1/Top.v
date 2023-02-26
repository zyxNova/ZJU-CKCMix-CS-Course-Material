`include "Defines.vh"

module Top(
    input clk_100mhz,
    input rstn,
    input [15:0] sw_in,
    input [4:0] key_col,
    output [4:0] key_row,
    output hs,
    output vs,
    output [3:0] vga_r,
    output [3:0] vga_g,
    output [3:0] vga_b,
    output [7:0] LED_o
);

    wire rst;
    wire [15:0] sw;
    wire [31:0] clk_div;
    wire [4:0] key_x;
    wire [4:0] key_y;

    ClockDividor clock_dividor(
        .clk(clk_100mhz),
        .rst(rst),
        .step_en(sw[0]),
        .clk_step(key_x[0]),
        .clk_div(clk_div),
        .clk_cpu(clk_cpu)
    );

    InputAntiJitter inputter(
        .clk(clk_100mhz),
        .rstn(rstn),
        .key_col(key_col),
        .sw_in(sw_in),
        .rst(rst),
        .key_row(key_row),
        .key_x(key_x),
        .key_y(key_y),
        .sw(sw)
    );
    
    wire [31:0] imem_addr;
    wire [31:0] imem_o_data;

    wire [31:0] dmem_addr;
    wire [31:0] dmem_o_data;
    wire [31:0] dmem_i_data;
    wire dmem_wen;
    wire dmem_ren;
    
    `VGA_DBG_Core_Declaration
    `VGA_DBG_RegFile_Declaration

    Core core(
        `VGA_DBG_Core_Arguments
        .clk(clk_cpu),
        .rst(rst),
        .imem_addr(imem_addr),
        .imem_o_data(imem_o_data),
        .dmem_addr(dmem_addr),
        .dmem_o_data(dmem_o_data),
        .dmem_i_data(dmem_i_data),
        .dmem_wen(dmem_wen),
        .dmem_ren(dmem_ren)
    );

    wire [31:0] o_imem_addr;
    wire [31:0] i_imem_o_data;
    wire [31:0] o_dmem_addr;
    wire [31:0] i_dmem_o_data;
    wire [31:0] o_dmem_i_data;
    wire o_dmem_wen;
    wire o_dmem_ren;
    
    MACtrl memacc(
        //facing core
        .i_iaddr(imem_addr),
        .o_idata(imem_o_data),
        .i_dwen(dmem_wen),
        .i_dren(dmem_ren),
        .i_daddr(dmem_addr),
        .i_d_idata(dmem_i_data),
        .o_d_odata(dmem_o_data),
        //facing IMem
        .o_iaddr(o_imem_addr),
        .i_idata(i_imem_o_data),
        //facing DMem
        .o_dren(o_dmem_ren),
        .o_dwen(o_dmem_wen),
        .o_daddr(o_dmem_addr),
        .o_d_idata(o_dmem_i_data),
        .i_d_odata(i_dmem_o_data),
        //facing DR1
        .o_dr1wen(dr1_wen),
        .o_dr1_idata(dr1_i_data),
        .i_dr1_odata(dr1_o_data)
    );

    Mem mem(
        .i_addr(o_imem_addr),
        .i_data(i_imem_o_data),
        .clk(~clk_cpu),
        .d_wen(o_dmem_wen),
        .d_ren(o_dmem_ren),
        .d_addr(o_dmem_addr),
        .d_i_data(o_dmem_i_data),
        .d_o_data(i_dmem_o_data)
    );

    VGA vga(
        `VGA_DBG_VgaDebugger_Arguments
        .rst(rst),
        .clk_div(clk_div),
        .hs(hs),
        .vs(vs),
        .vga_r(vga_r),
        .vga_g(vga_g),
        .vga_b(vga_b)
    );

    wire dr1_wen;
    wire [31:0] dr1_o_data;
    wire [31:0] dr1_i_data;    
    LEDCtrl dr1(
    .clk(~clk_cpu), //LEDCtrl is similar to DMem
    .rst(rst),
    .wen(dr1_wen),
    .i_data(dr1_i_data),
    .o_data(dr1_o_data),
    .o_led_ctrl(LED_o)
    );

endmodule