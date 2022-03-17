module led_twinkle(clk, sig);
    input clk;
    wire temp;
    output [2:0]sig;
    
    divider D1(.clk(clk), .clk_N(temp));
    counter counter1(.clk(temp), .out(sig));

endmodule