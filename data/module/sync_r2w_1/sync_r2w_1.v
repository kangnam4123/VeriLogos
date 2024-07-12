module sync_r2w_1
    #(
    parameter ASIZE = 4
    )(
    input  wire              wclk,
    input  wire              wrst_n,
    input  wire [ASIZE:0] rptr,
    output reg  [ASIZE:0] wq2_rptr
    );
    reg [ASIZE:0] wq1_rptr;
    always @(posedge wclk or negedge wrst_n) begin
        if (!wrst_n)
            {wq2_rptr,wq1_rptr} <= 0;
        else
            {wq2_rptr,wq1_rptr} <= {wq1_rptr,rptr};
    end
endmodule