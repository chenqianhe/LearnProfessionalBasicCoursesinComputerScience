`timescale 1ns / 1ps
module auto_add_tb();
   reg clk, rst, start;
   wire DONE;
   wire [31:0] sum_out;
   TOP aadd(clk,rst,start,DONE,sum_out);
   always begin   // å¨æä¸?20nsçæ¶é?
      clk <= 0;
      #10;
      clk <= 1;
      #10;
   end   
	
	initial begin
      rst <= 1;       //å¤ä½å¯å¨
      start <= 0;         //æé®æªæä¸?
      @(posedge clk); //U
      #5 rst <= 0;      //å¤ä½å³é­
      #10 start <= 1;     //æä¸æé®
      @(posedge clk);//D


   end
endmodule
