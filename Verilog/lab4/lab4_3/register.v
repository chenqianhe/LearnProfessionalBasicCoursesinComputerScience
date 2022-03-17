`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/13 19:36:28
// Design Name: 
// Module Name: register
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


module register(clk, rst_n, en, d, q);
  parameter WIDTH = 8;
  input  rst_n, en,clk;
  input [WIDTH-1:0] d;
  output reg [WIDTH-1:0] q;
  always @(posedge clk) begin
    if (rst_n) q <=0;
    else if (en) q <= d;
  end    
endmodule

