module FSM(clk,rst,start,next_zero, LD_SUM, LD_NEXT, SUM_SEL, NEXT_SEL, A_SEL, DONE);
	input clk,rst,start,next_zero;
	output reg LD_SUM,LD_NEXT,SUM_SEL,NEXT_SEL,A_SEL,DONE;
	parameter START = 0, COMPUTE_SUM = 1, GET_NEXT = 2, DONED = 3;//对应四个状�??        
	reg [1:0] State, StateNext; //当前状�?�和下一个时钟周期的状�??
	
always @(*) begin
      case (State) 
         START: begin                
            LD_SUM <= 0;
			LD_NEXT <= 0;
			SUM_SEL <= 0;
			NEXT_SEL <= 0;
			A_SEL <= 0;
			DONE <= 0;
            if (start == 0) 
               StateNext <= START;   //不按按钮，保持关�?
            else
               StateNext <= COMPUTE_SUM;  //按了按钮，下�?个状态为On1
         end
         COMPUTE_SUM: begin
			LD_SUM <= 1;
			LD_NEXT <= 0;
			SUM_SEL <= 1;
			NEXT_SEL <= 1;
			A_SEL <= 1;
			DONE <= 0;                      
            StateNext <= GET_NEXT;   
         end
         GET_NEXT: begin
			LD_SUM <= 0;
			LD_NEXT <= 1;
			SUM_SEL <= 1;
			NEXT_SEL <= 1;
			A_SEL <= 0;
			DONE <= 0;    
			if (next_zero == 0) 
               StateNext <= COMPUTE_SUM;   
            else
               StateNext <= DONED;   
         end
         DONED: begin
			LD_SUM <= 0;
			LD_NEXT <= 0;
			SUM_SEL <= 0;
			NEXT_SEL <= 0;
			A_SEL <= 0;
			DONE <= 1;   
			if (start == 0) 
                StateNext <= START;  
            else
				StateNext <= State;
         end
      endcase 
   end
   
   // StateReg 
   always @(posedge clk) begin
      if (rst == 1 ) 
         State <= start; 
      else
         State <= StateNext;
   end

endmodule
