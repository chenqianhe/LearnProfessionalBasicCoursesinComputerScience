module full_adder(a, b, sum);
	parameter WIDTH = 8;
	
	input [WIDTH-1:0] a, b;
	output [WIDTH-1:0] sum;
	
	assign sum = a + b;
	
endmodule