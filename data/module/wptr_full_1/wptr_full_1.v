module wptr_full_1 #(
    parameter ADDRSIZE = 2
) (
    output reg wfull,
    output wire [ADDRSIZE-1:0] waddr,
    output reg [ADDRSIZE :0] wptr,
    input wire [ADDRSIZE :0] wq2_rptr,
    input wire winc, wclk, wrst
);
reg [ADDRSIZE:0] wbin;
wire [ADDRSIZE:0] wgraynext, wbinnext;
always @(posedge wclk)
    if (wrst) {wbin, wptr} <= 0;
    else {wbin, wptr} <= {wbinnext, wgraynext};
assign waddr = wbin[ADDRSIZE-1:0];
assign wbinnext = wbin + (winc & ~wfull);
assign wgraynext = (wbinnext>>1) ^ wbinnext;
wire wfull_val;
assign wfull_val = (wgraynext=={~wq2_rptr[ADDRSIZE:ADDRSIZE-1], wq2_rptr[ADDRSIZE-2:0]});
always @(posedge wclk)
    if (wrst) wfull <= 1'b0;
    else wfull <= wfull_val;
endmodule