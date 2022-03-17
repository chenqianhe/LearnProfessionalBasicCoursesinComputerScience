`timescale 1ns / 1ps
module auto_add_tb();
   reg clk, rst, start;
   wire DONE;
   wire [31:0] sum_out;
   TOP aadd(clk,rst,start,DONE,sum_out);
   always begin   // 周期�?20ns的时�?
      clk <= 0;
      #10;
      clk <= 1;
      #10;
   end   
	
	initial begin
      rst <= 1;       //复位启动
      start <= 0;         //按钮未按�?
      @(posedge clk); //U
      #5 rst <= 0;      //复位关闭
      #10 start <= 1;     //按下按钮
      @(posedge clk);//D


   end
endmodule
