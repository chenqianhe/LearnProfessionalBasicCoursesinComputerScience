`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/26 16:22:39
// Design Name: 
// Module Name: COUNTER
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


module COUNTER( CLK, 
                RST,
                Din,
                en,
                Dout
    );
    input CLK;
    input RST;
    input en;
    input [31:0] Din;
    output wire [31:0] Dout;
    reg [31:0] data = 0;


    
    assign Dout = data;

    always @(posedge CLK)  begin
        if (RST == 1)begin
            data <= 0;
        end
        if (en == 1) begin
            data <= Din;
        end
        
    end      
endmodule
