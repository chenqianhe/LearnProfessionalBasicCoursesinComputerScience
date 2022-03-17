module _7Seg_Driver_Direct(SW,CA,CB,CC,CD,CE,CF,CG,DP,AN,LED);
	input [15:0]SW;
	output CA,CB,CC,CD,CE,CF,CG,DP;
	output [7:0]AN;
	output [15:0]LED;
	
	assign LED[15:0] = SW[15:0];
	assign AN[7:0] = SW[15:8];
	assign CA = SW[7];
	assign CB = SW[6];
	assign CC = SW[5];
	assign CD = SW[4];
	assign CE = SW[3];
	assign CF = SW[2];
	assign CG = SW[1];
	assign DP = SW[0];
	
endmodule