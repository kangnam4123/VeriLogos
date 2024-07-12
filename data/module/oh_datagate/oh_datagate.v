module oh_datagate #(parameter DW = 32, 
		     parameter N  = 3   
		     )
   ( 
     input 	     clk, 
     input 	     en,  
     input [DW-1:0]  din, 
     output [DW-1:0] dout 
     );
   reg [N-1:0]    enable_pipe;   
   wire 	  enable;
   always @ (posedge clk)
     enable_pipe[N-1:0] <= {enable_pipe[N-2:0],en};
   assign enable = en | (|enable_pipe[N-1:0]);
   assign dout[DW-1:0] = {(DW){enable}} & din[DW-1:0];
endmodule