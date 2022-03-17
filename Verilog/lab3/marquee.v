module marquee(clk, BTNL, BTNR, BTNC, SEG, AN);
    input clk, BTNL, BTNR, BTNC;              // ϵͳʱ��
    output [7:0] SEG;  		// �ֱ��ӦCA��CB��CC��CD��CE��CF��CG��DP
    output [7:0] AN;        // 8λ�����Ƭѡ�ź�
    wire clk_N;
    wire [2:0]num;
    wire [3:0]code;
    
    divider mydivider(.clk(clk), .flag(BTNC), .clk_N(clk_N));
    counter mycounter(.clk(clk_N), .out(num));
    decoder3_8 mydecoder(.num(num), .sel(AN));
    always
    
    rom8x4 myrom8x4(.addr(num), .data(code));
    pattern mypattern(.code(code), .patt(SEG));
    

    

// ����ʵ��

endmodule

module divider(clk, flag, clk_N);
	input clk, flag;                      // 系统时钟
	output reg clk_N;                   // 分频后的时钟
	reg N;       // 1Hz的时�?,N=fclk/fclk_N
	reg [31:0] counter;             /* 计数器变量，通过计数实现分频�?
                                   当计数器�?0计数�?(N/2-1)时，
                                   输出时钟翻转，计数器清零 */
    initial begin
        N = 100_000_000;
    end                               
                                   
	always @(posedge clk, N)  begin    // 时钟上升�?
	// 功能实现
	    if (flag==1)begin
	       N = 10;
	    end
		if (counter>=N/2-1) begin
			clk_N = ~clk_N;
			counter = 0;
			end
		else
			counter = counter + 1;
	end                           
endmodule

module counter(clk, out);
    input clk;                    // 计数时钟
    output reg [2:0] out;             // 计数�?

always @(posedge clk)  begin  // 在时钟上升沿计数器加1
    // 功能实现
	if (out==7) 
		out = 0;
	else 
		out = out + 1;
end                           
endmodule

module decoder3_8(num, sel);
	input [2: 0] num;       // 数码管编号：0~7
	output reg [7:0] sel;       // 7段数码管片�?�信号，低电平有�?
// 功能实现
	always@(*) 
		begin
			case(num)
				3'b000 : sel = 8'b11111110;	//0
				3'b001 : sel = 8'b11111101;	//1
				3'b010 : sel = 8'b11111011;	//2
				3'b011 : sel = 8'b11110111;	//3
				3'b100 : sel = 8'b11101111;	//4
				3'b101 : sel = 8'b11011111;	//5
				3'b110 : sel = 8'b10111111;	//6
				3'b111 : sel = 8'b01111111;	//7
				default : sel = 8'b1111111;
			endcase
		end
endmodule

module rom8x4(addr, data);
	input [2:0] addr;           // 地址
	output reg [3:0] data;          // 地址addr处存储的数据 

	reg [3: 0] mem [7: 0];      //  8�?4位的存储�?

	initial   begin             // 初始化存储器
        mem[0] = 4'b0000;
		mem[1] = 4'b0010;
		mem[2] = 4'b0100;
		mem[3] = 4'b0110;
		mem[4] = 4'b1000;
		mem[5] = 4'b1010;
		mem[6] = 4'b1100;
		mem[7] = 4'b1110;
	end     
// 读取addr单元的�?�输�?
	always @(*)  begin  
		data = mem[addr];
	end  
                    
endmodule

module pattern(code, patt);
	input [3: 0] code;       // 16进制数字�?4位二进制编码
	output reg [7:0] patt;       // 7段数码管驱动，低电平有效
// 功能实现
	always@(*) 
		begin
			case(code)
				4'b0000 : patt = 8'b11000000;	//0
				4'b0001 : patt = 8'b11111001;	//1
				4'b0010 : patt = 8'b10100100;	//2
				4'b0011 : patt = 8'b10110000;	//3
				4'b0100 : patt = 8'b10011001;	//4
				4'b0101 : patt = 8'b10010010;	//5
				4'b0110 : patt = 8'b10000010;	//6
				4'b0111 : patt = 8'b11111000;	//7
				4'b1000 : patt = 8'b10000000;	//8
				4'b1001 : patt = 8'b10011000;	//9
				4'b1010 : patt = 8'b10001000;	//A
				4'b1011 : patt = 8'b10000011;	//b
				4'b1100 : patt = 8'b11000110;	//C
				4'b1101 : patt = 8'b10100001;	//d
				4'b1110 : patt = 8'b10000110;	//E
				4'b1111 : patt = 8'b10001110;	//F
				
				default : patt = 8'b11111111;
			endcase
		end
endmodule