module VgaController(
    input wire clk,
    input wire rst,
    output wire [9:0] vga_x,
    output wire [8:0] vga_y,
    output reg hs,
    output reg vs,
    output wire video_on
);
    
    reg [9:0] h_count;
    reg [9:0] v_count;

    initial begin
        h_count <= 10'b0;
        v_count <= 10'b0;
    end

    always @(posedge clk) begin
        if (rst) begin
            h_count <= 10'b0;
        end else if (h_count == 10'd799) begin
            h_count <= 10'b0;
        end else begin
            h_count <= h_count + 1;
        end
    end
    always @(posedge clk) begin
        if (rst) begin
            v_count <= 10'b0;
        end else if (h_count == 10'd799) begin
            if (v_count == 10'd524) begin
                v_count <= 10'b0;
            end else begin
                v_count <= v_count + 1;
            end
        end
    end

    localparam HS_1 = 96;
    localparam VS_1 = 2;    
    localparam HS_2 = 157;
    localparam VS_2 = 63;   
    localparam WIDTH = 640;
    localparam HEIGHT = 480;

    wire h_sync, v_sync;
    assign h_sync = (h_count >= HS_1);
    assign v_sync = (v_count >= VS_1);
    assign video_on = (h_count >= HS_2)
                   && (h_count < HS_2 + WIDTH)
                   && (v_count > VS_2)
                   && (v_count < VS_2 + HEIGHT);

    assign vga_x = video_on ? h_count - HS_2 : 10'd0;
    assign vga_y = video_on ? v_count - VS_2 : 9'd0;
    
    always @(posedge clk) begin
        if (rst) begin
            hs <= 1;
            vs <= 1;
        end else begin
            hs <= h_sync;
            vs <= v_sync;
        end
    end

endmodule
