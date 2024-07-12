module prbs_lfsr_tx (
input		ck,
input		i_init,
input		i_init_clk,
input [31:0]	i_seed,
input		i_req,
output	      	o_vld,
output 		o_res
);
   reg 	[31:0]	r_lfsr;
   wire         c_xor_in = r_lfsr[31] ^ r_lfsr[21] ^ r_lfsr[1] ^ r_lfsr[0];
   always @(posedge ck) begin
      if (i_init) begin
	 r_lfsr <= i_seed;
      end
      else if (i_req | i_init_clk) begin
	 r_lfsr <= {r_lfsr[30:0], c_xor_in};
      end
      else begin
	 r_lfsr <= r_lfsr;
      end
   end
   reg 		r_t2_vld;
   reg  	r_t2_res;
   always @(posedge ck) begin
      r_t2_vld <= i_req;
      r_t2_res <= r_lfsr[31];
   end
   assign o_vld = r_t2_vld;
   assign o_res = r_t2_res;
endmodule