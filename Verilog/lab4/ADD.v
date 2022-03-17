`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/13 19:34:36
// Design Name: 
// Module Name: ADD
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


module ADD(
a,b,q
    );
  parameter WIDTH = 8;
  input [WIDTH-1:0] a, b;
  output reg [WIDTH-1:0] q;
  always @(*)
  begin
   q = a + b;
  end    

endmodule
