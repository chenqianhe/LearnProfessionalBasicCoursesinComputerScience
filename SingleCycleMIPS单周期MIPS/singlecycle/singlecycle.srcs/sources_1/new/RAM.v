`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/26 15:46:54
// Design Name: 
// Module Name: RAM
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


module RAM( addr,
            Din,
            MemWrite,
            CLK,
            RST,
            Dout
    );
    
    input [9:0] addr;
    input [31:0] Din;
    input MemWrite;
    input CLK;
    input RST;
    output wire [31:0] Dout;
    reg [31:0] data [11'b11111111111:0];
    
    integer i;
    initial begin
        for(i = 0;i<11'b11111111111;i=i+1)   data[i] = 0;
    end
    
    assign Dout = data[addr];

    always @(posedge CLK) begin
        if (RST == 1) begin
            for(i = 0;i<11'b11111111111;i=i+1)   data[i] = 0;
        end
        if (MemWrite == 1) begin
            data[addr] = Din;
        end
    
    end
    
    
    
    
endmodule
