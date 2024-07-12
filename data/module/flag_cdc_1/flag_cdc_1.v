module flag_cdc_1(
		clkA, FlagIn_clkA, 
		clkB, FlagOut_clkB,rst_n);
   input clkA, FlagIn_clkA;
   input rst_n;
   input clkB;
   output FlagOut_clkB;
   reg 	  FlagToggle_clkA;
   reg [2:0] SyncA_clkB;
   always @(posedge clkA)
     begin : cdc_clk_a
	if (rst_n == 1'b0) begin
	   FlagToggle_clkA <= 1'b0;
	end
	else if(FlagIn_clkA == 1'b1) begin
	   FlagToggle_clkA <= ~FlagToggle_clkA;
	end
     end
   always @(posedge clkB) SyncA_clkB <= {SyncA_clkB[1:0], FlagToggle_clkA};
   assign FlagOut_clkB = (SyncA_clkB[2] ^ SyncA_clkB[1]);
endmodule