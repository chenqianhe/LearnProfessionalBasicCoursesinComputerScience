module ram(data, read_addr, write_addr, clk, we, q);
  parameter DATA_WIDTH = 8;
  parameter ADDR_WIDTH = 3;

  input clk, we;
  input [DATA_WIDTH-1:0] data;
  input [ADDR_WIDTH-1:0] read_addr, write_addr;
  output reg [DATA_WIDTH-1:0] q;

  // 申明存储器数�?
  reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

initial begin                              //对存储器初始�?
        $readmemh("F:/Cqh_files/2021verilog/upload/lab4/ram_init.txt", ram);	
        end
  always @(posedge clk) begin
    if (we)
      ram[write_addr] <= data;
    q <= ram[read_addr];
end

endmodule
