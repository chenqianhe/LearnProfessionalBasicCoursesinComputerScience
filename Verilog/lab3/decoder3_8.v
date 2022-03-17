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