`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/25 13:00:13
// Design Name: 
// Module Name: mips
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


module mips( 
//        clk
CLK
    );
//    input clk;
   input CLK; 
//    wire CLK;
//    reg CLK;    
    reg RST = 0; // Reset
    wire [31:0] PCin;
    wire [31:0] PCout; // PC
    wire PCen;
    wire [31:0] IR;
    
    wire [5:0] OP;
    wire [5:0] Func;
    
    wire [4:0] SHAMT;

    wire MemToReg;
    wire MemWrite;
    wire ALU_SRC;
    wire RegWrite;
    wire SysCALL;
    wire SignedExt;
    wire RegDst;
    wire BEQ;
    wire BNE;
    wire JR;
    wire JUMP;
    wire JAL;
    
    wire [4:0] R1addr;
    wire [4:0] R2addr;
    wire [4:0] Waddr;
    wire [31:0] RDin;
    wire [31:0] R1;
    wire [31:0] R2;
    
    wire [31:0] Y;
    wire [3:0] ALUop;
    wire EQUAL;
    wire [31:0] RESULT1;
    wire [31:0] RESULT2;
    
    wire [31:0] Mdata;

    reg [31:0] LedData = 0;
    reg [31:0] num = 0;
    reg [31:0] clk_num = 0;
    reg num_en = 1;
    
//    DIVIDER divider(clk, CLK);
//    CLK = 1;
        
    COUNTER pc(CLK, RST, PCin, PCen, PCout);
    
    ROM rom(PCout[11:2], 1, IR);
    
    HardwiredController controller(OP, Func, MemToReg, MemWrite, ALU_SRC, RegWrite, SysCALL, SignedExt, RegDst, BEQ, BNE, JR, JUMP, JAL, ALUop);
    
    REG regFile(RDin, CLK, RegWrite, R1addr, R2addr, Waddr, R1, R2);
    
    ALU alu(ALUop, R1, Y, SHAMT, EQUAL, RESULT1, RESULT2);
    
    RAM ram(RESULT1[11:2], R2, MemWrite, CLK, RST, Mdata);
    

    wire [31:0] high, low;
    assign high = PCout + 4;
    assign low = IR[27:0] << 2;

    wire [31:0] imm;
    assign imm = (SignedExt == 0)? {16'b0, IR[15:0]} : (IR[15] == 1)? {16'b1111111111111111, IR[15:0]} : {16'b0, IR[15:0]};

    assign OP = IR[31:26];
    assign Func = IR[5:0];
    assign SHAMT = IR[10:6];
    assign R1addr = (SysCALL == 1)? 5'h02 : IR[25:21];
    assign R2addr = (SysCALL == 1)? 5'h04 : IR[20:16];
    assign Waddr = (JAL == 1)? 5'h1f : (RegDst == 1)? IR[15:11] : IR[20:16];
    assign Y = (SysCALL == 1)? 32'h22 : (ALU_SRC == 1)? imm : R2;
    assign RDin = (JAL == 1)? PCout + 4 : (MemToReg == 1)? Mdata : RESULT1;
    assign PCen = (SysCALL == 1 && EQUAL == 0)? 0 : 1;
    assign PCin = (JR == 0 && JUMP == 0)? ((BEQ == 0 || EQUAL == 0) && (BNE == 0 || EQUAL == 1))? PCout + 4 : (imm << 2) + PCout + 4 : (JUMP == 1 && JR == 0)? {high[31:28], low[27:0]} : R1;


    always @(posedge CLK)begin
        if (RST == 1) begin
            LedData <= 0;
            num <= 0;
        end
        if (SysCALL && EQUAL) begin
            LedData <= R2;
        end
        if (SysCALL == 1 && EQUAL == 0)begin
            num = num;
        end
        else begin
            num = num + 1;
        end
        
        clk_num = clk_num + 1;
        
    end

    // always @(*)begin
    //     OP <= IR[31:26];
    //     Func <= IR[5:0];

    //     if (SysCALL == 1) begin
    //         R1addr <= 5'h02;
    //         R2addr <= 5'h04;
    //     end
    //     else begin
    //         R1addr <= IR[25:21];
    //         R2addr <= IR[20:16];
    //     end

    //     if (JAL == 1) begin
    //         Waddr <= 5'h1f;
    //     end
    //     else begin
    //         if (RegDst == 1) begin
    //             Waddr <= IR[15:11];
    //         end
    //         else begin
    //             Waddr <= IR[20:16];
    //         end
    //     end

    //     SHAMT <= IR[10:6];

    //     if (SysCALL == 1) begin
    //         Y <= 32'h22;
    //     end
    //     else begin
    //         if (ALU_SRC == 1) begin
    //             if (SignedExt) begin
    //                 Y <= {16'b0, IR[15:0]};
    //             end
    //             else begin
    //                 Y <= (IR[15]==1)?{16'b1, IR[15:0]}:{16'b0, IR[15:0]};
    //             end
    //         end
    //         else begin
    //             Y <= R2;
    //         end
    //     end

    //     if (JAL == 1) begin
    //         RDin <= PCout + 4;
    //     end 
    //     else begin
    //         if (MemToReg == 1) begin
    //             RDin <= Mdata;
    //         end
    //         else begin
    //             RDin <= RESULT1;
    //         end   
    //     end

    //     if (SysCALL & !EQUAL == 1) begin
    //         PCen <= 0;
    //     end
    //     else begin
    //         PCen <= 1;
    //     end

    //     if (JR == 0 && JUMP == 0) begin
    //         if ((BEQ == 0 || EQUAL == 0) && (BNE == 0 || EQUAL == 1)) begin
    //             PCin <= PCout + 4;
    //         end 
    //         else begin
    //             if (SignedExt) begin
    //                 PCin <= {16'b0, PCout[15:0]} << 2'd2 + PCout + 3'd4;
    //             end
    //             else begin
    //                 PCin <= ((PCout[15]==1)?{16'b1, PCout[15:0]}:{16'b0, PCout[15:0]}) << 2'd2 + PCout + 3'd4;
    //             end
    //         end
    //     end
    //     else if (JR == 1 && JUMP == 0) begin
    //         PCin <= R1;
    //     end
    //     else if (JUMP == 1 && JR ==0) begin

    //         PCin <= {high[31:28], low[27:0]};
    //     end
    //     else begin
    //         PCin <= R1;
    //     end
    // end
    
endmodule
