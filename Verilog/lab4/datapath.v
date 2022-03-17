module datapath(clk, rst, SUM_SEL, NEXT_SEL, A_SEL, LD_SUM, LD_NEXT, NEXT_ZERO, sum_out);
    parameter width = 8;
    input clk,rst,SUM_SEL,NEXT_SEL,A_SEL,LD_SUM,LD_NEXT;    
    output NEXT_ZERO;
    output [width-1:0] sum_out;
    wire [width-1:0] gr_data, sum, sum_sel_out, next_sel_out, next_answer, sum2;
    wire is_great, is_less;
    wire [width-1:0] zero = 0;
    wire [width-1:0] one = 1;
    
    ram #(width, width) GR(.data(zero), .read_addr(a_sel_out), .write_addr(a_sel_out), .clk(clk), .we(zero), .q(gr_data));

    full_adder #(width) ADD(.a(sum_out), .b(gr_data), .sum(sum));
    mux_21 #(width) SUM_SELER(.a(zero), .b(sum), .sel(SUM_SEL), .out(sum_sel_out));
    register #(width) LD_SUMER(.clk(clk), .rst_n(rst), .en(LD_SUM), .d(sum_sel_out), .q(sum_out));
    
    mux_21 #(width) NEXT_SELER(.a(zero), .b(gr_data), .sel(NEXT_SEL), .out(next_sel_out));
    register #(width) LD_NEXTER(.clk(clk), .rst_n(rst), .en(LD_NEXT), .d(next_sel_out), .q(next_answer));
    
    comparator #(width) ZERO_COMPARATOR(.a(zero), .b(next_sel_out), .is_equal(NEXT_ZERO), .is_great(is_great), .is_less(is_less));
   
    full_adder #(width) ADD2(.a(next_answer), .b(one), .sum(sum2));
    
    mux_21 #(width) A_SELER(.a(next_answer), .b(sum2), .sel(A_SEL), .out(a_sel_out));
    
endmodule