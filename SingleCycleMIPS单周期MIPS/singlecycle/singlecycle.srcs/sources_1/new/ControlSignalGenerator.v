`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/26 09:53:46
// Design Name: 
// Module Name: ControlSignalGenerator
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


module ControlSignalGenerator( OP,
                               Func,
                               MemToReg,
                               MemWrite,
                               ALU_SRC,
                               RegWrite,
                               SysCALL,
                               SignedExt,
                               RegDst,
                               BEQ,
                               BNE,
                               JR,
                               JUMP,
                               JAL
    );
    input [5:0] OP;
    input [5:0] Func;
    output reg MemToReg;
    output reg MemWrite;
    output reg ALU_SRC;
    output reg RegWrite;
    output reg SysCALL;
    output reg SignedExt;
    output reg RegDst;
    output reg BEQ;
    output reg BNE;
    output reg JR;
    output reg JUMP;
    output reg JAL;
    
    always @(*) begin
        MemToReg = 0;
        MemWrite = 0;
        ALU_SRC = 0;
        RegWrite = 0;
        SysCALL = 0;
        SignedExt = 0;
        RegDst = 0;
        BEQ = 0;
        BNE = 0;
        JR = 0;
        JUMP = 0;
        JAL = 0;
        
		case(OP)
			6'b000000:begin
			             case(Func)
			                6'b001000:begin
			                            JR = 1;
										JUMP = 1;
			                        end
							6'b001100:begin
										SysCALL = 1;
										RegDst = 1;
									end
							default:begin
										RegWrite = 1;
										RegDst = 1;
									end
			             endcase
					end
			6'b000010:begin
						JUMP = 1;
					end
			6'b000011:begin
				RegWrite = 1;
				JUMP = 1;
				JAL = 1;
			end
			6'b000100:begin
				BEQ = 1;
			end
			6'b000101:begin
				BNE = 1;
			end
			6'b001000:begin
				ALU_SRC = 1;
				RegWrite = 1;
				SignedExt = 1;
			end
			6'b001001:begin
				ALU_SRC = 1;
				RegWrite = 1;
				SignedExt = 1;
			end
			6'b001010:begin
				ALU_SRC = 1;
				RegWrite = 1;
				SignedExt = 1;
			end
			6'b001100:begin
				ALU_SRC = 1;
				RegWrite = 1;
			end
			6'b001101:begin
				ALU_SRC = 1;
				RegWrite = 1;
			end
			6'b100011:begin
				ALU_SRC = 1;
				RegWrite = 1;
				MemToReg = 1;
			end
			6'b101011:begin
				ALU_SRC = 1;
				MemWrite = 1;
			end
		endcase
    
    end
	
endmodule
