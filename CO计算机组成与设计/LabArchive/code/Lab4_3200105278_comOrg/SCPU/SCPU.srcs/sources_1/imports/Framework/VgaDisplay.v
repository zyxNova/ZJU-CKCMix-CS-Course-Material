module VgaDisplay(
    input wire clk,
    input wire video_on,
    input wire [9:0] vga_x,
    input wire [8:0] vga_y,
    output wire [3:0] vga_r,
    output wire [3:0] vga_g,
    output wire [3:0] vga_b,
    input wire wen,
    input wire [11:0] w_addr,
    input wire [7:0] w_data
);

    (* ram_style = "block" *) reg [7:0] display_data[0:4095];
    initial $readmemh("vga_debugger.mem", display_data);

    wire [11:0] text_index = (vga_y / 16) * 80 + vga_x / 8;
    // I don't know why I need this '- (vga_y / 16)' ...
    wire [7:0] text_ascii = display_data[text_index] - (vga_y / 16);
    wire [2:0] font_x = vga_x % 8;
    wire [3:0] font_y = vga_y % 16;
    wire [11:0] font_addr = text_ascii * 16 + font_y;

    (* ram_style = "block" *) reg [7:0] fonts_data[0:4095];
    initial $readmemh("font_8x16.mem", fonts_data);
    wire [7:0] font_data = fonts_data[font_addr];

    assign { vga_r, vga_g, vga_b } = (video_on & font_data[7 - font_x]) ? 12'hfff : 12'h0;

    always @(posedge clk) begin
        if (wen) begin
            display_data[w_addr] <= w_data;
        end
    end
    
endmodule