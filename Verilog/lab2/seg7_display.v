module seg7_display(in,lit);
	input [3:0] in;
	output reg[7:0] lit;
	
	always@(*) 
		begin
			case(in[3:0])
				4'b0000 : lit = 8'b11000000;	//0
				4'b0001 : lit = 8'b11111001;	//1
				4'b0010 : lit = 8'b10100100;	//2
				4'b0011 : lit = 8'b10110000;	//3
				4'b0100 : lit = 8'b10011001;	//4
				4'b0101 : lit = 8'b10010010;	//5
				4'b0110 : lit = 8'b10000010;	//6
				4'b0111 : lit = 8'b11111000;	//7
				4'b1000 : lit = 8'b10000000;	//8
				4'b1001 : lit = 8'b10011000;	//9
				4'b1010 : lit = 8'b10001000;	//A
				4'b1011 : lit = 8'b10000011;	//b
				4'b1100 : lit = 8'b11000110;	//C
				4'b1101 : lit = 8'b10100001;	//d
				4'b1110 : lit = 8'b10000110;	//E
				4'b1111 : lit = 8'b10001110;	//F
				
				default : lit = 8'b11111111;
			endcase
		end
	
endmodule