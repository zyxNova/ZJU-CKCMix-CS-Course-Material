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
        else if (start == 1 && finish == 0) begin//���㿪ʼ���Ҽ���δ��ɣ�����finish����ѭ������
                if (A == 0) result = B;
                else if (B == 0) result = A;
                else begin
                //��ʼ��pA,pB
                    pA = {fracA, 4'h0};
                    pB = {fracB, 4'h0};
                //�ݴ�expA, expB;
                    expA = A[30:23];
                    expB = B[30:23];
                //�����ص�С����ǰ��1����,pA����0.1XXXX��X��ԭ����23λβ����
                   if (expA >=1 && expA <=254) begin
                        pA = pA >> 2;
                        sliceA = pA[24:0];
                        pA = {1'b0, 1'b1, sliceA};//�����﷨�����⣬ƴ�ӷ����˲�ǳ
                        expA = expA - 1;
                   end
                   //pA������0.XXXX,��һ��0����
                   else if (expA == 0) begin
                        pA = pA >> 1;
                   end
                   
                   if (expB >=1 && expB <=254) begin
                        pB = pB >> 2;
                        sliceB = pB[24:0];
                        pB = {1'b0, 1'b1, sliceB};
                        expB = expB - 1;
                   end
                   //pB������0.XXXX,��һ��0����
                   else if (expB == 0) begin
                        pB = pB >> 1;
                   end
                   
                   //�ѷ���λ�Ž��������A>0������00.1XXXX����00.XXXX
                   //���A<0������11.0XXXX����11.XXXX(��ȡ�����ٰѷ���λ�ƽ�����
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
                   
                   expBsubA = expB - expA;//����3��û����expBsubA...
                   if (expBsubA >= 0) begin // B >= A, A�����ƶ���
                        pA = $signed(pA) >>> expBsubA;
                        resExp = expB;
                   end else if (expBsubA < 0) begin // B < A, B�����ƶ���A
                        pB = $signed(pB) >>> (~expBsubA+1); //expBsubA == 0����Ҫ��λ������һ��ʼû�жϳ����������
                        resExp = expA; end
                   
                   tempRes = pA + pB;
                   //���
                   //01.XXX -> 00.1XXX, 10.XXX -> 11.0XXX, �ҹ飬ָ��++
                   if (tempRes[26:25] == 2'b10 || tempRes[26:25] == 2'b01) begin tempRes = $signed(tempRes) >>> 1; resExp = resExp + 1; end
                   //00.0XXX -> 00.1XX,��飬ָ��--
                   else if (tempRes[26:24] == 3'b000) begin
                        while (tempRes[26:24] != 3'b001) begin tempRes = tempRes << 1; resExp = resExp - 1; end
                   end
                   //11.1XXX -> 11.0XX, ��飬ָ��--
                   else if (tempRes[26:24] == 3'b111) begin
                        while (tempRes[26:24] != 3'b110) begin tempRes = tempRes << 1; resExp = resExp - 1; end
                   end
                   //detect underflow or overflow,��֪��verilog��ô���쳣����û��дerror���
                   if (resExp >= 0 && resExp < 254) begin
                        //rounding,����Ϊ�˷��㲻�����룬ֱ�ӽ�ȡtempRes��[23:1]��Ϊ�����fraction���֡������Ļ�ȡ����                             
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