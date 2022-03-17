`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/26 16:06:32
// Design Name: 
// Module Name: REG
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


module REG( Din,
            CLK,
            RegWrite,
            R1addr,
            R2addr,
            Waddr,
            R1out,
            R2out
    );
    
    input [31:0] Din;
    input CLK;
    input RegWrite;
    input [4:0] R1addr;
    input [4:0] R2addr;
    input [4:0] Waddr;
    output wire [31:0] R1out;
    output wire [31:0] R2out;
    reg [31:0] data [31:0];
    
    integer i;
    initial begin
        for(i = 0;i<10'b1111111111;i=i+1)   data[i] = 0;
    end
    
    assign R1out = data[R1addr];
    assign R2out = data[R2addr]; 
    
     always @(posedge CLK) begin
        if (RegWrite == 1) begin
            data[Waddr] = Din;
        end
    end
endmodule

