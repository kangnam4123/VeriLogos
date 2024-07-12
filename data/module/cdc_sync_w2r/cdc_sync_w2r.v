module cdc_sync_w2r #(
    parameter ADDRSIZE = 2
) (
    output reg [ADDRSIZE:0] rq2_wptr,
    input wire [ADDRSIZE:0] wptr,
    input wire rclk, rrst
);
reg [ADDRSIZE:0] cdc_sync_rq1_wptr;
always @(posedge rclk)
    if (rrst) {rq2_wptr,cdc_sync_rq1_wptr} <= 0;
    else {rq2_wptr,cdc_sync_rq1_wptr} <= {cdc_sync_rq1_wptr,wptr};
endmodule