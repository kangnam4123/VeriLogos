module rptr_empty_1 #(
    parameter ADDRSIZE = 2
) (
    output reg rempty,
    output wire [ADDRSIZE-1:0] raddr,
    output reg [ADDRSIZE :0] rptr,
    input wire [ADDRSIZE :0] rq2_wptr,
    input wire rinc, rclk, rrst
);
reg [ADDRSIZE:0] rbin;
wire [ADDRSIZE:0] rgraynext, rbinnext;
always @(posedge rclk)
    if (rrst) {rbin, rptr} <= 0;
    else {rbin, rptr} <= {rbinnext, rgraynext};
assign raddr = rbin[ADDRSIZE-1:0];
assign rbinnext = rbin + (rinc & ~rempty);
assign rgraynext = (rbinnext>>1) ^ rbinnext;
wire rempty_val;
assign rempty_val = (rgraynext == rq2_wptr);
always @(posedge rclk)
    if (rrst) rempty <= 1'b1;
    else rempty <= rempty_val;
endmodule