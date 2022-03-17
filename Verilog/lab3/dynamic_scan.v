module dynamic_scan(clk,  SEG, AN);
    input clk;              // 系统时钟
    output [7:0] SEG;  		// 分别对应CA、CB、CC、CD、CE、CF、CG和DP
    output [7:0] AN;        // 8位数码管片选信号
    wire clk_N;
    wire [2:0]num;
    wire [3:0]code;
    
    divider mydivider(.clk(clk), .clk_N(clk_N));
    counter mycounter(.clk(clk_N), .out(num));
    decoder3_8 mydecoder(.num(num), .sel(AN));
    rom8x4 myrom8x4(.addr(num), .data(code));
    pattern mypattern(.code(code), .patt(SEG));
    

// 功能实现

endmodule