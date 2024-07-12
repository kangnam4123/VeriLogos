module initial_edge_n (res_n,
		       rst_n);
   output  res_n;
   input   rst_n;
   reg 	   res_n = 1'b0;
   always @(negedge rst_n) begin
      if (rst_n == 1'b0) begin
         res_n <= 1'b1;
      end
   end
endmodule