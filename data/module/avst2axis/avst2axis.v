module avst2axis #(
    parameter DATA_WIDTH = 8,
    parameter KEEP_WIDTH = (DATA_WIDTH/8),
    parameter KEEP_ENABLE = (DATA_WIDTH>8),
    parameter EMPTY_WIDTH = $clog2(KEEP_WIDTH),
    parameter BYTE_REVERSE = 0
)
(
    input  wire                    clk,
    input  wire                    rst,
    output wire                    avst_ready,
    input  wire                    avst_valid,
    input  wire [DATA_WIDTH-1:0]   avst_data,
    input  wire                    avst_startofpacket,
    input  wire                    avst_endofpacket,
    input  wire [EMPTY_WIDTH-1:0]  avst_empty,
    input  wire                    avst_error,
    output wire [DATA_WIDTH-1:0]   axis_tdata,
    output wire [KEEP_WIDTH-1:0]   axis_tkeep,
    output wire                    axis_tvalid,
    input  wire                    axis_tready,
    output wire                    axis_tlast,
    output wire                    axis_tuser
);
parameter BYTE_WIDTH = KEEP_ENABLE ? DATA_WIDTH / KEEP_WIDTH : DATA_WIDTH;
assign avst_ready = axis_tready;
generate
genvar n;
if (BYTE_REVERSE) begin : rev
    for (n = 0; n < KEEP_WIDTH; n = n + 1) begin
        assign axis_tdata[n*BYTE_WIDTH +: BYTE_WIDTH] = avst_data[(KEEP_WIDTH-n-1)*BYTE_WIDTH +: BYTE_WIDTH];
    end
end else begin
    assign axis_tdata = avst_data;
end
endgenerate
assign axis_tkeep = KEEP_ENABLE ? {KEEP_WIDTH{1'b1}} >> avst_empty : 0;
assign axis_tvalid = avst_valid;
assign axis_tlast = avst_endofpacket;
assign axis_tuser = avst_error;
endmodule