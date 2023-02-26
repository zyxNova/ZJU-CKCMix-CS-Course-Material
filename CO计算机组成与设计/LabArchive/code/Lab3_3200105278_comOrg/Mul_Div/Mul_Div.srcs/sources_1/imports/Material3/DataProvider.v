module DataProvider (
    input clk,
    output reg [31:0] data
);
    
    reg [11:0] addr = 0;

    (* ram_style = "block" *) reg [31:0] mem[0:4095];
    initial $readmemh("data.mem", mem);

    always @(posedge clk) begin
        data <= mem[addr];
        addr = addr + 1'b1;
    end
    
endmodule