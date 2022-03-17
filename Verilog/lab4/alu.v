module alu(a, b, op, q);
  parameter WIDTH = 8;
  input [WIDTH-1:0] a, b;
  input [1:0] op;
  output reg [WIDTH-1:0] q;
  always @(*) begin
    case(op)
      2'b00: q = a + b;
      2'b01: q = a & b;
      2'b10: q = a ^ b;
      2'b11: q = a | b;
      default: q = 0;
    endcase
  end    
endmodule
