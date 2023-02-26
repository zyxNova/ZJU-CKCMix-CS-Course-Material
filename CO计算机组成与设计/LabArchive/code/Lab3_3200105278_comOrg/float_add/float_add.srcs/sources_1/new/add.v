`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/25 17:03:13
// Design Name: 
// Module Name: float_add
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

module float_add(
	input clk, 
	input rst,
	input [31:0] A,
	input [31:0] B,
	/*input [1:0] c,      // 00 +, 01 -, 10 *, 11 /*/
	input start,			// en = 1, begin
	output reg [31:0] result,
	output reg finish		// fin = 1 when finish
    );
	 
	wire signA;
	reg [7:0] expA;
	wire [22:0] fracA;
	wire signB;
	reg [7:0] expB;
	wire [22:0] fracB;
	reg expBsubA;
	assign signA = A[31];
	assign fracA = A[22:0];
	assign signB = B[31];
	assign fracB = B[22:0];
	
	reg [26:0] pA;
	reg [26:0] pB;
	reg [7:0] resExp;
	reg [26:0] tempRes;
	
	reg[24:0] sliceA;
	reg[24:0] sliceB;
	always @(posedge clk or posedge rst) begin
        if (rst) begin
            result = 0;
            finish = 0;
        end
        else if (start == 1 && finish == 0) begin//计算开始而且计算未完成，少了finish条件循环计算
                if (A == 0) result = B;
                else if (B == 0) result = A;
                else begin
                //初始化pA,pB
                    pA = {fracA, 4'h0};
                    pB = {fracB, 4'h0};
                //暂存expA, expB;
                    expA = A[30:23];
                    expB = B[30:23];
                //把隐藏的小数点前的1右移,pA形如0.1XXXX（X是原来的23位尾数）
                   if (expA >=1 && expA <=254) begin
                        pA = pA >> 2;
                        sliceA = pA[24:0];
                        pA = {1'b0, 1'b1, sliceA};//这里语法有问题，拼接符害人不浅
                        expA = expA - 1;
                   end
                   //pA本来是0.XXXX,补一个0进来
                   else if (expA == 0) begin
                        pA = pA >> 1;
                   end
                   
                   if (expB >=1 && expB <=254) begin
                        pB = pB >> 2;
                        sliceB = pB[24:0];
                        pB = {1'b0, 1'b1, sliceB};
                        expB = expB - 1;
                   end
                   //pB本来是0.XXXX,补一个0进来
                   else if (expB == 0) begin
                        pB = pB >> 1;
                   end
                   
                   //把符号位放进来，如果A>0则形如00.1XXXX或者00.XXXX
                   //如果A<0则形如11.0XXXX或者11.XXXX(先取反，再把符号位移进来）
                   if (signA) begin
                        pA = ~pA+1;
                        pA = $signed(pA) >>> 1;
                   end
                   else pA = pA >> 1;
                   if (signB) begin
                        pB = ~pB+1;
                        pB = $signed(pB) >>> 1;
                   end
                   else pB = pB >> 1;
                   
                   expBsubA = expB - expA;//错误3：没计算expBsubA...
                   if (expBsubA >= 0) begin // B >= A, A向右移对齐
                        pA = $signed(pA) >>> expBsubA;
                        resExp = expB;
                   end else if (expBsubA < 0) begin // B < A, B向右移对齐A
                        pB = $signed(pB) >>> (~expBsubA+1); //expBsubA == 0则不需要移位操作。一开始没判断出现溢出错误
                        resExp = expA; end
                   
                   tempRes = pA + pB;
                   //规格化
                   //01.XXX -> 00.1XXX, 10.XXX -> 11.0XXX, 右归，指数++
                   if (tempRes[26:25] == 2'b10 || tempRes[26:25] == 2'b01) begin tempRes = $signed(tempRes) >>> 1; resExp = resExp + 1; end
                   //00.0XXX -> 00.1XX,左归，指数--
                   else if (tempRes[26:24] == 3'b000) begin
                        while (tempRes[26:24] != 3'b001) begin tempRes = tempRes << 1; resExp = resExp - 1; end
                   end
                   //11.1XXX -> 11.0XX, 左归，指数--
                   else if (tempRes[26:24] == 3'b111) begin
                        while (tempRes[26:24] != 3'b110) begin tempRes = tempRes << 1; resExp = resExp - 1; end
                   end
                   //detect underflow or overflow,不知道verilog怎么抛异常所以没有写error语句
                   if (resExp >= 0 && resExp < 254) begin
                        //rounding,这里为了方便不做舍入，直接截取tempRes的[23:1]作为结果的fraction部分。负数的话取补码                             
                        resExp = resExp + 1;
                        result[31] = tempRes[26];//sign bit
                        result[30:23] = resExp;
                        result[22:0] = (result[31]) ? ~tempRes[23:1]+1 : tempRes[23:1];
                   end
                finish = 1;
                end
        end
        else if (start == 0) begin finish = 0; end
    end    
endmodule