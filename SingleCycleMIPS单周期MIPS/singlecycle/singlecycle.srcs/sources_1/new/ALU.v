`timescale 1ns / 1ps


module ALU( ALUop, 
            X, 
            Y, 
            SHAMT, 
            EQUAL,
            RESULT1, 
            RESULT2);
            
    input [3:0] ALUop;
    input [31:0] X;
    input [31:0] Y;
    input [4:0] SHAMT;
    output reg EQUAL;
    output reg [31:0] RESULT1;
    output reg [31:0] RESULT2;
    

    
    always @(*)
    begin
        if (ALUop == 4'b0000) begin
            RESULT1 = Y << SHAMT;
            RESULT2 = 0;
        end
        else if (ALUop == 4'b0001) begin
            RESULT1 = Y >>> SHAMT;
            RESULT2 = 0;
        end
        else if (ALUop == 4'b0010) begin
            RESULT1 = Y >> SHAMT;
            RESULT2 = 0;
        end
        else if (ALUop == 4'b0101) begin
            RESULT1 = X + Y;
            RESULT2 = 0;
        end
        else if (ALUop == 4'b0110) begin
            RESULT1 = X - Y;
            RESULT2 = 0;
        end
        else if (ALUop == 4'b0111) begin
            RESULT1 = X & Y;
            RESULT2 = 0;
        end
        else if (ALUop == 4'b1000) begin
            RESULT1 = X | Y;
            RESULT2 = 0;
        end
        else if (ALUop == 4'b1001) begin
            RESULT1 = X ^ Y;
            RESULT2 = 0;
        end
        else if (ALUop == 4'b1010) begin
            RESULT1 = ~(X | Y);
            RESULT2 = 0;
        end
        else if (ALUop == 4'b1011) begin
            RESULT1 = ((X<Y)&(!X[31])&(!Y[31]))|((X>Y)&X[31]&Y[31])|((X[31]^Y[31])&X[31]);
            RESULT2 = 0;
        end
        else if (ALUop == 4'b1100) begin
            RESULT1 = (X < Y)?1 : 0;
            RESULT2 = 0;
        end
        else if (ALUop == 4'b1101) begin
            RESULT1 = Y << 16;
            RESULT2 = 0;
        end
        else begin
            RESULT1 = 0;
            RESULT2 = 0;
        end
        EQUAL = (X == Y);
    end
    
endmodule
