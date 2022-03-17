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
    
    input clk;                      // 系统时钟
	output reg clk_N;                   // 分频后的时钟
	parameter N = 100_000_000;      // 1Hz的时钿,N=fclk/fclk_N
	reg [31:0] counter;             /* 计数器变量，通过计数实现分频?
                                   当计数器仿0计数刿(N/2-1)时，
                                   输出时钟翻转，计数器清零 */
	always @(posedge clk)  begin    // 时钟上升沿
	// 功能实现
		if (counter==N/2-1) begin
			clk_N = ~clk_N;
			counter = 0;
			end
		else
			counter = counter + 1;
	end                           
endmodule
