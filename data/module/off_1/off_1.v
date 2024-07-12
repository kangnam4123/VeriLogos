module off_1 (
   clk, toggle
   );
   input clk;
   input toggle;
   always @ (posedge clk) begin
      if (toggle) begin
      end
   end
   always @ (posedge clk) begin
      if (toggle) begin
      end
   end
endmodule