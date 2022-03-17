`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/26 16:19:26
// Design Name: 
// Module Name: DIVIDER
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


module DIVIDER( clk,
                clk_N
    );
    
    input clk;                      // ϵͳʱ��
	output reg clk_N;                   // ��Ƶ���ʱ��
	parameter N = 100_000_000;      // 1Hz��ʱ��,N=fclk/fclk_N
	reg [31:0] counter;             /* ������������ͨ������ʵ�ַ�Ƶ?
                                   ����������0������(N/2-1)ʱ��
                                   ���ʱ�ӷ�ת������������ */
	always @(posedge clk)  begin    // ʱ��������
	// ����ʵ��
		if (counter==N/2-1) begin
			clk_N = ~clk_N;
			counter = 0;
			end
		else
			counter = counter + 1;
	end                           
endmodule
