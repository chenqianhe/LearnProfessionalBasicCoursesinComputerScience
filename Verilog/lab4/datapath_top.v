module datapath_top(clk, rst, SUM_SEL, NEXT_SEL, A_SEL, LD_SUM, LD_NEXT, NEXT_ZERO, sum_out);
    parameter DATA_WIDTH=32;
    parameter ADDR_WIDTH=8;
    input clk,rst,SUM_SEL,NEXT_SEL,A_SEL,LD_SUM,LD_NEXT;    
    output NEXT_ZERO;
    output [DATA_WIDTH-1:0] sum_out;
    wire [DATA_WIDTH-1:0]D;
    wire [DATA_WIDTH-1:0]add1,add2;
    wire [DATA_WIDTH-1:0]SUM_SEL_OUT,NEXT_SEL_OUT,A_SEL_OUT;
    wire [DATA_WIDTH-1:0]next_out;
    
    wire [DATA_WIDTH-1:0]zero=0;
    wire [DATA_WIDTH-1:0]One=1;
    
    ADD  #(DATA_WIDTH) ADD_1(sum_out,D,add1);
    ADD  #(DATA_WIDTH) ADD_2(One,next_out,add2);
    
    mux2_1 #(DATA_WIDTH) mux2_1_SUM(SUM_SEL_OUT,zero,add1,SUM_SEL);
    mux2_1 #(DATA_WIDTH) mux2_1_NEXT(NEXT_SEL_OUT,zero,D,NEXT_SEL);
    mux2_1 #(DATA_WIDTH) mux2_1_A(A_SEL_OUT,next_out,add2,A_SEL);
    
    comparator #(DATA_WIDTH) comparator1(zero,NEXT_SEL_OUT,NEXT_ZERO);
    
    register #(DATA_WIDTH) SUM(clk,rst,LD_SUM,SUM_SEL_OUT,sum_out);
    register #(DATA_WIDTH) NEXT(clk,rst,LD_NEXT,NEXT_SEL_OUT,next_out);
    
    Memory #(DATA_WIDTH,ADDR_WIDTH)Memory1(A_SEL_OUT,D);

endmodule
