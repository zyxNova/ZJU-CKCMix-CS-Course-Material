
module Top(
    input clk_100mhz,
    input rstn,
    input [15:0] sw_in,
    input [4:0] key_col,
    input ps2_clk, ps2_data,
    output [4:0] key_row,
    output hs,
    output vs,
    output [3:0] vga_r,
    output [3:0] vga_g,
    output [3:0] vga_b
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
    
    wire [15:0] A, B;
    wire [15:0] div_res, div_rem;
    wire [31:0] mul_res;
    wire div_by_0;
    wire start;
    wire mul_finish;
    wire div_finish;
    assign start = 0;
    
    DataProvider data_provider(
        .clk(clk_cpu), .data({A, B})
    );

    mul32 mul(
        .A(A),
        .B(B),
        .clk(clk_cpu),
        .rst(rst),
        .start(start),
        .product(mul_res),
        .finish(mul_finish)
    );
   
    div32 div(
        .A(A),
        .B(B),
        .clk(clk_cpu),
		.rst(rst),
		.start(start),
		.finish(div_finish),
        .quotient(div_res),
        .remainder(div_rem),
        .divide_zero(div_by_0)
    );

    VGA_muldiv vga_muldiv(
        .dbg_A({16'h0, A}),
        .dbg_B({16'h0, B}),
        .dbg_mul_res(mul_res),
        .dbg_div_res({16'h0,div_res}),
        .dbg_div_rem({16'h0,div_rem}),
        .dbg_div_by_0({31'h0,div_by_0}),
        .rst(rst),
        .clk_div(clk_div),
        .hs(hs),
        .vs(vs),
        .vga_r(vga_r),
        .vga_g(vga_g),
        .vga_b(vga_b)
    );
    
    

endmodule