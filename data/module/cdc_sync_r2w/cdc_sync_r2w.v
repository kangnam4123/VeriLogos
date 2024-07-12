module cdc_sync_r2w #(
    parameter ADDRSIZE = 2
) (
    output reg [ADDRSIZE:0] wq2_rptr,
    input wire [ADDRSIZE:0] rptr,
    input wire wclk, wrst
);
reg [ADDRSIZE:0] cdc_sync_wq1_rptr;
always @(posedge wclk)
    if (wrst) {wq2_rptr,cdc_sync_wq1_rptr} <= 0;
    else {wq2_rptr,cdc_sync_wq1_rptr} <= {cdc_sync_wq1_rptr,rptr};
endmodule