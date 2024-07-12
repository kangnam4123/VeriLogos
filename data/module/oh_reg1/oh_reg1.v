module oh_reg1 #(parameter DW = 1            
		 ) 
   ( input           nreset, 
     input 	     clk, 
     input 	     en, 
     input [DW-1:0]  in, 
     output [DW-1:0] out  
     );
   reg [DW-1:0]      out_reg;	   
   always @ (posedge clk or negedge nreset)
     if(!nreset)
       out_reg[DW-1:0] <= 'b0;
     else if(en)	      
       out_reg[DW-1:0] <= in[DW-1:0];
   assign out[DW-1:0] = out_reg[DW-1:0];	   
endmodule