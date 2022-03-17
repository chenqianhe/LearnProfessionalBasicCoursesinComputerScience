module _7Seg_Driver_Direct(SW,SEG,AN,LED);
	input [15:0]SW;
	output reg [7:0]SEG;
	output reg [7:0]AN;
	output reg [15:0]LED;
	
	always@(*) 
		begin
			LED[15:0] = SW[15:0];
			AN[7:0] = SW[15:8];
			case(SW[3:0])
				4'b0000 : SEG = 8'b11000000;	//0
				4'b0001 : SEG = 8'b11111001;	//1
				4'b0010 : SEG = 8'b10100100;	//2
				4'b0011 : SEG = 8'b10110000;	//3
				4'b0100 : SEG = 8'b10011001;	//4
				4'b0101 : SEG = 8'b10010010;	//5
				4'b0110 : SEG = 8'b10000010;	//6
				4'b0111 : SEG = 8'b11111000;	//7
				4'b1000 : SEG = 8'b10000000;	//8
				4'b1001 : SEG = 8'b10011000;	//9
				4'b1010 : SEG = 8'b10001000;	//A
				4'b1011 : SEG = 8'b10000011;	//b
				4'b1100 : SEG = 8'b11000110;	//C
				4'b1101 : SEG = 8'b10100001;	//d
				4'b1110 : SEG = 8'b10000110;	//E
				4'b1111 : SEG = 8'b10001110;	//F
				
				default : SEG = 8'b11111111;
			endcase
	end
endmodule