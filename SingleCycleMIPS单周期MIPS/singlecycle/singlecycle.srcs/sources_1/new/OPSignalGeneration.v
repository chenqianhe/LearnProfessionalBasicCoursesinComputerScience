`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/26 10:26:29
// Design Name: 
// Module Name: OPSignalGeneration
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module OPSignalGeneration( OP,
                           Func,
                           ALUop
    );
    
    input [5:0] OP;
    input [5:0] Func;
    output reg [3:0] ALUop;
    
	    always @(*) begin
        ALUop = 0;

		case(OP)
			6'b000000:begin
			             case(Func)
			                6'b000000:begin
			                            ALUop = 0;
			                        end
							6'b000011:begin
										ALUop = 4'b0001;
									end
							6'b000010:begin
										ALUop = 4'b0010;
									end
							6'b100000:begin
										ALUop = 4'b0101;
									end
							6'b100001:begin
										ALUop = 4'b0101;
									end
							6'b100010:begin
										ALUop = 4'b0110;
									end
							6'b100100:begin
										ALUop = 4'b0111;
									end
							6'b100101:begin
										ALUop = 4'b1000;
									end
							6'b100111:begin
										ALUop = 4'b1010;
									end
							6'b101010:begin
										ALUop = 4'b1011;
									end
							6'b101011:begin
										ALUop = 4'b1100;
									end
							default:begin
										ALUop = 4'b1111;
									end
			             endcase
					end
			6'b001000:begin
				ALUop = 4'b0101;
			end
			6'b001001:begin
				ALUop = 4'b0101;
			end
			6'b001010:begin
				ALUop = 4'b1011;
			end
			6'b001100:begin
				ALUop = 4'b0111;
			end
			6'b001101:begin
				ALUop = 4'b1000;
			end
			6'b100011:begin
				ALUop = 4'b0101;
			end
			6'b101011:begin
				ALUop = 4'b0101;
			end
			default:begin
				ALUop = 4'b1111;
			end
		endcase
    
    end
endmodule
