module test2
  (
   clk,
   xvecin,
   xvecout
   );
   input clk;
   input wire [1:0] xvecin;
   output wire [1:0] xvecout;
   assign xvecout = {clk, xvecin[1]};
endmodule