module auto_add(clk,rst,start,DONE,sum_out);
    input clk,rst,start;
    output DONE;
    output [31:0] sum_out;
    wire SUM_SEL, NEXT_SEL, A_SEL, LD_SUM, LD_NEXT, NEXT_ZERO;
     
    datapath #(32) dpath(clk, rst, SUM_SEL, NEXT_SEL, A_SEL, LD_SUM, LD_NEXT, NEXT_ZERO, sum_out);
    FSM addfsm(clk,rst,start,next_zero, LD_SUM, LD_NEXT, SUM_SEL, NEXT_SEL, A_SEL, DONE);
endmodule
