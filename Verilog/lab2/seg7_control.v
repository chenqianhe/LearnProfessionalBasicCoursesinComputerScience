module seg7_control(in,lit);
	input [2:0] in;
	output reg[7:0] lit;
	
	always@(*) 
		begin
			case(in[2:0])
				4'b000 : lit = 8'b11111110;	//0
				4'b001 : lit = 8'b11111101;	//1
				4'b010 : lit = 8'b11111011;	//2
				4'b011 : lit = 8'b11110111;	//3
				4'b100 : lit = 8'b11101111;	//4
				4'b101 : lit = 8'b11011111;	//5
				4'b110 : lit = 8'b10111111;	//6
				4'b111 : lit = 8'b01111111;	//7
				default : lit = 8'b1111111;
			endcase
		end
	
endmodule