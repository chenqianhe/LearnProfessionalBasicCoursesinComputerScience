`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/13 21:40:23
// Design Name: 
// Module Name: TOP
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


module TOP(clk,rst,start,done,sum_out,sum_sel,next_sel,a_sel,ld_sum,ld_next,next_zero);
parameter DATA_WIDTH=32;
parameter ADDR_WIDTH=8;
input clk,rst,start;
output done;
output [DATA_WIDTH-1:0]sum_out;
output sum_sel,next_sel,a_sel,ld_sum,ld_next,next_zero;

datapath_top #(DATA_WIDTH,ADDR_WIDTH) h1(clk,rst,sum_sel,next_sel,a_sel,ld_sum,ld_next,next_zero,sum_out);
LaserTimer h2(clk,rst,start,next_zero,ld_sum,ld_next,sum_sel,next_sel,a_sel,done);

endmodule
