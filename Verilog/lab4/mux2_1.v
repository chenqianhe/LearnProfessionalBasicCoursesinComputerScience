`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/13 19:37:19
// Design Name: 
// Module Name: mux2_1
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


module mux2_1(out1, a, b, sel) ;
parameter WIDTH = 8;
output [WIDTH-1:0] out1;
input [WIDTH-1:0] a, b;
input sel;
assign out1 = sel==0?a:b;
endmodule
