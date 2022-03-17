`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/13 19:35:18
// Design Name: 
// Module Name: Memory
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


module Memory( A, D);
parameter DATA_WIDTH=8;
parameter ADDR_WIDTH=8;
input [ADDR_WIDTH-1:0] A;
output reg [DATA_WIDTH-1:0] D ;
reg [DATA_WIDTH-1:0] rom[2**ADDR_WIDTH-1:0];
initial
$readmemh("G:/Cqh_files/2021verilog/upload/lab4/rom_init.txt", rom); //从文件中读取数据到存储器rom
always @ (*) begin
D <= rom[A];
end
endmodule
