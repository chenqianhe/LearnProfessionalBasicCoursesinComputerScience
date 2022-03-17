`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/26 11:05:20
// Design Name: 
// Module Name: HardwiredController
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


module HardwiredController(OP,
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
                           JAL,
                           ALUop

    );
    
    input [5:0] OP;
    input [5:0] Func;
    output wire MemToReg;
    output wire MemWrite;
    output wire ALU_SRC;
    output wire RegWrite;
    output wire SysCALL;
    output wire SignedExt;
    output wire RegDst;
    output wire BEQ;
    output wire BNE;
    output wire JR;
    output wire JUMP;
    output wire JAL;
    output wire [3:0] ALUop;
    
    ControlSignalGenerator CSG(OP,
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
                           JAL);
    OPSignalGeneration OPSG(OP,
                           Func,
                           ALUop);
    
endmodule
