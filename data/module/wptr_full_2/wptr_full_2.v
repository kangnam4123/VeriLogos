module wptr_full_2
    #(
    parameter ADDRSIZE = 4
    )(
    input  wire                wclk,
    input  wire                wrst_n,
    input  wire                winc,
    input  wire [ADDRSIZE  :0] wq2_rptr,
    output reg                 wfull,
    output reg                 awfull,
    output wire [ADDRSIZE-1:0] waddr,
    output reg  [ADDRSIZE  :0] wptr
    );
    reg  [ADDRSIZE:0] wbin;
    wire [ADDRSIZE:0] wgraynext, wbinnext, wgraynextp1;
    wire              awfull_val, wfull_val;
    always @(posedge wclk or negedge wrst_n) begin
        if (!wrst_n) 
            {wbin, wptr} <= 0;
        else         
            {wbin, wptr} <= {wbinnext, wgraynext};
    end
    assign waddr = wbin[ADDRSIZE-1:0];
    assign wbinnext  = wbin + (winc & ~wfull);
    assign wgraynext = (wbinnext >> 1) ^ wbinnext;
    assign wgraynextp1 = ((wbinnext + 1'b1) >> 1) ^ (wbinnext + 1'b1);
     assign wfull_val = (wgraynext == {~wq2_rptr[ADDRSIZE:ADDRSIZE-1],wq2_rptr[ADDRSIZE-2:0]});
     assign awfull_val = (wgraynextp1 == {~wq2_rptr[ADDRSIZE:ADDRSIZE-1],wq2_rptr[ADDRSIZE-2:0]});
     always @(posedge wclk or negedge wrst_n) begin
        if (!wrst_n) begin
            awfull <= 1'b0;
            wfull  <= 1'b0;
        end
        else begin
            awfull <= awfull_val;
            wfull  <= wfull_val;
        end
    end
endmodule