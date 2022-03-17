`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/13 21:08:36
// Design Name: 
// Module Name: LaserTimer
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


module LaserTimer(clk,rst,start,next_zero,ld_sum,ld_next,sum_sel,nest_sel,a_sel,done );
input clk,rst,start,next_zero;
output reg ld_sum,ld_next,sum_sel,nest_sel,a_sel,done;
localparam START = 0 , COMPUTE_SUM=1,GET_NEXT=2,DONE=3;
reg [1:0] State,StateNext;
initial begin
    State = 0;
        ld_sum=0;
        ld_next=0;
        sum_sel=0;
        nest_sel=0;
        a_sel=0;
        done=0;
end

always@(State,start,rst,next_zero) begin
    case(State)
    START:begin 
        ld_sum=0;
        ld_next=0;
        sum_sel=0;
        nest_sel=0;
        a_sel=0;
        done=0;
        if(start==0) StateNext=START;
        else StateNext=COMPUTE_SUM;
    end
    COMPUTE_SUM:begin 
        ld_sum=1;
        ld_next=0;
        sum_sel=1;
        nest_sel=1;
        a_sel=1;
        done=0; 
        StateNext=GET_NEXT;
    end
    GET_NEXT:begin
        ld_sum=0;
        ld_next=1;
        sum_sel=1;
        nest_sel=1;
        a_sel=0;
        done=0;
        if(next_zero == 0)StateNext=COMPUTE_SUM;
        else   StateNext=DONE;      
    end
    DONE:begin
         ld_sum=0;
        ld_next=0;
        sum_sel=0;
        nest_sel=0;
        a_sel=0;
        done=1;
        if(start == 0)StateNext=START;
        else   StateNext=DONE; 
    end
    endcase
end

always @(posedge clk) begin
        if(rst==1) State <= START;
        else State <= StateNext; //迁移到下一个状态
end

endmodule
