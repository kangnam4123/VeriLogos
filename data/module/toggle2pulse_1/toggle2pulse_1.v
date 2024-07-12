module toggle2pulse_1(
   out,
   clk, in, reset
   );
   input  clk; 
   input  in;   
   output out;
   input  reset;
   reg 	  out_reg;
   always @ (posedge clk)
     if(reset)
       out_reg <= 1'b0;
     else
       out_reg <= in;
   assign out = in ^ out_reg;
endmodule