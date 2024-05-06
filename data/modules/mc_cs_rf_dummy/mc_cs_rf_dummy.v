module mc_cs_rf_dummy(clk, rst, wb_we_i, din, rf_we, addr, csc, tms, poc, csc_mask, cs,
		wp_err, lmr_req, lmr_ack, init_req, init_ack );
parameter	[2:0]	this_cs = 0;
input		clk, rst;
input		wb_we_i;
input	[31:0]	din;
input		rf_we;
input	[31:0]	addr;
output	[31:0]	csc;
output	[31:0]	tms;
input	[31:0]	poc;
input	[31:0]	csc_mask;
output		cs;
output		wp_err;
output		lmr_req;
input		lmr_ack;
output		init_req;
input		init_ack;
assign csc = 32'h0;
assign tms = 32'h0;
assign cs = 1'b0;
assign wp_err = 1'b0;
assign lmr_req = 1'b0;
assign init_req = 1'b0;
endmodule