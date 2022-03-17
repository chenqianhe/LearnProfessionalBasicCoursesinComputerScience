`timescale 1ns / 1ps

module FEM_tb( );
   reg clk,rst,start,next_zero;
   wire LD_SUM, LD_NEXT, SUM_SEL, NEXT_SEL, A_SEL, DONE; 
   FSM fsm(clk,rst,start,next_zero, LD_SUM, LD_NEXT, SUM_SEL, NEXT_SEL, A_SEL, DONE);

   always begin   // 周期为20ns的时钟
      clk <= 0;
      #10;
      clk <= 1;
      #10;
   end   

   initial begin
      rst <= 1;       //复位启动
      start <= 0;         //按钮未按下
	  next_zero <= 0;
      @(posedge clk); //U
      #5 rst <= 0;      //复位关闭
      @(posedge clk);//D
	  #5 start <= 1;     //按下按钮
	  @(posedge clk);//U
	  
	  @(posedge clk);//D
	  #5
	  @(posedge clk);//U
	  #5
	  @(posedge clk);//D
	  #5
	  #5 next_zero <= 1;
	  @(posedge clk);//U
	  #5
	  #5 start <= 0;
	  @(posedge clk);//D
	  #5
	  @(posedge clk);//U
	  #5
	  @(posedge clk);//D
	  #5
	  @(posedge clk);//U
	  #5
	  @(posedge clk);//D
	  #5
	  @(posedge clk);//U
	  #5
	  @(posedge clk);//D
	  #5
	  @(posedge clk);//U
	  #5
	  @(posedge clk);//D

   end
endmodule
