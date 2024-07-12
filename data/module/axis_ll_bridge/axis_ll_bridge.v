module axis_ll_bridge #
(
    parameter DATA_WIDTH = 8
)
(
    input  wire                   clk,
    input  wire                   rst,
    input  wire [DATA_WIDTH-1:0]  axis_tdata,
    input  wire                   axis_tvalid,
    output wire                   axis_tready,
    input  wire                   axis_tlast,
    output wire [DATA_WIDTH-1:0]  ll_data_out,
    output wire                   ll_sof_out_n,
    output wire                   ll_eof_out_n,
    output wire                   ll_src_rdy_out_n,
    input  wire                   ll_dst_rdy_in_n
);
reg last_tlast = 1'b1;
always @(posedge clk or posedge rst) begin
    if (rst) begin
        last_tlast = 1'b1;
    end else begin
        if (axis_tvalid & axis_tready) last_tlast = axis_tlast;
    end
end
wire invalid = axis_tvalid & axis_tlast & last_tlast;
assign axis_tready = ~ll_dst_rdy_in_n;
assign ll_data_out = axis_tdata;
assign ll_sof_out_n = ~(last_tlast & axis_tvalid & ~invalid);
assign ll_eof_out_n = ~(axis_tlast & ~invalid);
assign ll_src_rdy_out_n = ~(axis_tvalid & ~invalid);
endmodule