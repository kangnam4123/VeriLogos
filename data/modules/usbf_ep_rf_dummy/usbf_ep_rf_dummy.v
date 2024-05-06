module usbf_ep_rf_dummy(
		clk, wclk, rst,
		adr, re, we, din, dout, inta, intb,
		dma_req, dma_ack,
		idin,
		ep_sel, ep_match,
		buf0_rl, buf0_set, buf1_set,
		uc_bsel_set, uc_dpd_set,
		int_buf1_set, int_buf0_set, int_upid_set,
		int_crc16_set, int_to_set, int_seqerr_set,
		out_to_small,
		csr, buf0, buf1, dma_in_buf_sz1, dma_out_buf_avail
		);
input		clk, wclk, rst;
input	[1:0]	adr;
input		re;
input		we;
input	[31:0]	din;
output	[31:0]	dout;
output		inta, intb;
output		dma_req;
input		dma_ack;
input	[31:0]	idin;		
input	[3:0]	ep_sel;		
output		ep_match;	
input		buf0_rl;	
input		buf0_set;	
input		buf1_set;	
input		uc_bsel_set;	
input		uc_dpd_set;	
input		int_buf1_set;	
input		int_buf0_set;	
input		int_upid_set;	
input		int_crc16_set;	
input		int_to_set;	
input		int_seqerr_set;	
input		out_to_small;	
output	[31:0]	csr;		
output	[31:0]	buf0;		
output	[31:0]	buf1;		
output		dma_in_buf_sz1;	
output		dma_out_buf_avail;
assign	dout = 32'h0;
assign	inta = 1'b0;
assign	intb = 1'b0;
assign	dma_req = 1'b0;
assign	ep_match = 1'b0;
assign	csr = 32'h0;
assign	buf0 = 32'hffff_ffff;
assign	buf1 = 32'hffff_ffff;
assign	dma_in_buf_sz1 = 1'b0;
assign	dma_out_buf_avail = 1'b0;
endmodule