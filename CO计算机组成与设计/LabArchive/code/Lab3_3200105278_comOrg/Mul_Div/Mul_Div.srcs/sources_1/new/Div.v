`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/17 15:06:32
// Design Name: 
// Module Name: Div
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


module div32(
        input    clk,
		input    rst,
        input    start,
        input    [15:0] A, 
        input    [15:0] B,
        output    reg finish,
        output    reg [15:0] quotient,
        output    reg [15:0] remainder,
        output    reg divide_zero
        ); 
	
	wire signDend;
    wire signDor;
    wire signQ;
    wire signR;
    assign signDend = A[15];
    assign signDor = B[15];
    assign signQ = signDend ^ signDor;
    assign signR = signDend;
    
    reg [15:0] dividend;
    reg [15:0] divisor;
    reg [32:0] temp;
    integer i;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            quotient = 0;
            remainder = 0;
            divide_zero = 0;
            finish = 0;
        end
        else if (start == 0 && finish == 0) begin
                dividend = signDend ? ~A+1 : A;
                divisor = signDor ? ~B+1 : B;//处理负数
                divide_zero = 0;
                if (divisor == 0) begin
                    divide_zero = 1;
                    finish = 1;
                end
                else begin
                    temp = {0,dividend} << 1;
                    for (i = 0; i < 16; i = i+1) begin
                        temp[31:16] = temp[31:16] - divisor;
                        if (temp[31]) begin
                            temp[31:16] = temp[31:16] + divisor;
                            temp = temp << 1;
                        end
                        else begin 
                            temp = (temp << 1) + 1;
                        end
                    end
                    quotient = signQ ? ~temp[15:0]+1 : temp[15:0];
                    remainder = signR ? ~(temp[31:16] >> 1)+1 : temp[31:16] >> 1;
                    finish = 1;
                end
        end
        else if (start) begin finish = 0; end
    end    
	endmodule
