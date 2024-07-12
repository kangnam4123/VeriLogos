module smffa
  (
   input  clk,
   input  en_d1,
   input  D,
   output reg Q
   );
   always @ (posedge clk) begin
   	Q <= D;
   end
endmodule