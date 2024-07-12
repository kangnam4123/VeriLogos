module fric_xactor
  (
   clk,
   rst,
   fric_in,
   fric_out
   );
   input           clk;
   input 	   rst;
   input [7:0] 	   fric_in;
   output [7:0]    fric_out;
   reg [7:0] 	   fric_out_o;
   wire [7:0] 	   fric_in_i;
   assign #1 	   fric_out = fric_out_o;
   assign #1 	   fric_in_i = fric_in;
endmodule