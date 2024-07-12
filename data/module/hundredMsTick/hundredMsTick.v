module hundredMsTick (
		      input wire  clk,
		      input wire  resetn,
		      output wire tick
		      );
   reg [31:0] 			  timer;
   always @(posedge clk) begin
      if (!resetn) begin
         timer <= 5000000;
      end else begin
         if (timer == 0) begin
            timer <= 5000000;
         end else begin
            timer <= timer - 1;
         end
      end
   end
   assign tick = (timer == 0);
endmodule