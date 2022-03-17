module _7Seg_Driver_Direct(SW,SEG,AN,LED);
	input [15:0]SW;
	output [7:0]SEG;
	output [7:0]AN;
	output reg [15:0]LED;
	
	always@(*)
	   begin
                LED[15:0] = SW[15:0];
       end
       
    seg7_control control(SW[15:13],AN);
	seg7_display display(SW[3:0],SEG);
	
endmodule