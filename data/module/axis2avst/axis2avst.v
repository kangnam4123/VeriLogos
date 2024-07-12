module axis2avst #(
    parameter DATA_WIDTH = 8,
    parameter KEEP_WIDTH = (DATA_WIDTH/8),
    parameter KEEP_ENABLE = (DATA_WIDTH>8),
    parameter EMPTY_WIDTH = $clog2(KEEP_WIDTH),
    parameter BYTE_REVERSE = 0
)
(
    input  wire                    clk,
    input  wire                    rst,
    input  wire [DATA_WIDTH-1:0]   axis_tdata,
    input  wire [KEEP_WIDTH-1:0]   axis_tkeep,
    input  wire                    axis_tvalid,
    output wire                    axis_tready,
    input  wire                    axis_tlast,
    input  wire                    axis_tuser,
    input  wire                    avst_ready,
    output wire                    avst_valid,
    output wire [DATA_WIDTH-1:0]   avst_data,
    output wire                    avst_startofpacket,
    output wire                    avst_endofpacket,
    output wire [EMPTY_WIDTH-1:0]  avst_empty,
    output wire                    avst_error
);
parameter BYTE_WIDTH = KEEP_ENABLE ? DATA_WIDTH / KEEP_WIDTH : DATA_WIDTH;
reg frame_reg = 1'b0;
generate
genvar n;
if (BYTE_REVERSE) begin : rev
    for (n = 0; n < KEEP_WIDTH; n = n + 1) begin
        assign avst_data[n*BYTE_WIDTH +: BYTE_WIDTH] = axis_tdata[(KEEP_WIDTH-n-1)*BYTE_WIDTH +: BYTE_WIDTH];
    end
end else begin
    assign avst_data = axis_tdata;
end
endgenerate
reg [EMPTY_WIDTH-1:0] empty;
assign avst_empty = empty;
integer k;
always @* begin
    empty = KEEP_WIDTH-1;
    for (k = 0; k < KEEP_WIDTH; k = k + 1) begin
        if (axis_tkeep[k]) begin
            empty = KEEP_WIDTH-1-k;
        end
    end
end
assign avst_valid = axis_tvalid;
assign avst_startofpacket = axis_tvalid & !frame_reg;
assign avst_endofpacket = axis_tlast;
assign avst_error = axis_tuser;
assign axis_tready = avst_ready;
always @(posedge clk) begin
    if (axis_tvalid && axis_tready) begin
        frame_reg <= !axis_tlast;
    end
    if (rst) begin
        frame_reg <= 1'b0;
    end
end
endmodule