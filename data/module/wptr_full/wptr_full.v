module wptr_full 
  #(parameter ADDRSIZE = 3,
    parameter ALMOST_FULL_SIZE=5
    )
  (output reg wfull,
   output reg w_almost_full,
   output [ADDRSIZE-1:0] waddr,
   output reg [ADDRSIZE :0] wptr,
   input [ADDRSIZE :0] wq2_rptr,
   input winc, wclk, wrst_n);
   reg [ADDRSIZE:0] wbin;
   wire [ADDRSIZE:0] wgraynext, wbinnext;
   reg [ADDRSIZE :0] wq2_rptr_bin;
   integer 	     i;
   always @(posedge wclk or negedge wrst_n)
     if (!wrst_n) {wbin, wptr} <= 0;
     else {wbin, wptr} <= {wbinnext, wgraynext};
   assign waddr = wbin[ADDRSIZE-1:0];
   assign wbinnext = wbin + (winc & ~wfull);
   assign wgraynext = (wbinnext>>1) ^ wbinnext;
   wire wfull_val = (wgraynext ==
		     {~wq2_rptr[ADDRSIZE:ADDRSIZE-1],wq2_rptr[ADDRSIZE-2:0]});
   always @(wq2_rptr)
     for (i=0; i<(ADDRSIZE+1); i=i+1)
       wq2_rptr_bin[i] = ^ (wq2_rptr >> i);
   wire [ADDRSIZE :0] subtract = wbinnext - wq2_rptr_bin - ALMOST_FULL_SIZE;
   wire w_almost_full_val = ~subtract[ADDRSIZE];
   always @(posedge wclk or negedge wrst_n)
     if (!wrst_n) begin 
	wfull <= 1'b0;
	w_almost_full <= 1'b 0;
     end
     else begin 
	wfull <= wfull_val;
	w_almost_full <= w_almost_full_val;
     end
endmodule