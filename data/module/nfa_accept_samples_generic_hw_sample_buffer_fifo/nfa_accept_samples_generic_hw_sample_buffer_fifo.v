module nfa_accept_samples_generic_hw_sample_buffer_fifo
#(parameter
    DATA_BITS  = 8,
    DEPTH      = 16,
    DEPTH_BITS = 4
)(
    input  wire                 sclk,
    input  wire                 reset_n,
    output reg                  empty_n,
    output reg                  full_n,
    input  wire                 rdreq,
    input  wire                 wrreq,
    output wire [DATA_BITS-1:0] q,
    input  wire [DATA_BITS-1:0] data
);
wire                  push;
wire                  pop;
reg  [DEPTH_BITS-1:0] pout;
reg  [DATA_BITS-1:0]  mem[0:DEPTH-1];
assign push = full_n & wrreq;
assign pop  = empty_n & rdreq;
assign q    = mem[pout];
always @(posedge sclk) begin
    if (~reset_n)
        empty_n <= 1'b0;
    else if (push)
        empty_n <= 1'b1;
    else if (~push && pop && pout == 1'b0)
        empty_n <= 1'b0;
end
always @(posedge sclk) begin
    if (~reset_n)
        full_n <= 1'b1;
    else if (rdreq)
        full_n <= 1'b1;
    else if (push && ~pop && pout == DEPTH - 2)
        full_n <= 1'b0;
end
always @(posedge sclk) begin
    if (~reset_n)
        pout <= 1'b0;
    else if (push & ~pop & empty_n)
        pout <= pout + 1'b1;
    else if (~push && pop && pout != 1'b0)
        pout <= pout - 1'b1;
end
integer i;
always @(posedge sclk) begin
    if (push) begin
        for (i = 0; i < DEPTH - 1; i = i + 1) begin
            mem[i+1] <= mem[i];
        end
        mem[0] <= data;
    end
end
endmodule