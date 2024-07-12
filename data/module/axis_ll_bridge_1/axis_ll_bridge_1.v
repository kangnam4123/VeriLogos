module axis_ll_bridge_1 #
(
    parameter DATA_WIDTH = 8
)
(
    input  wire                   clk,
    input  wire                   rst,
    input  wire [DATA_WIDTH-1:0]  s_axis_tdata,
    input  wire                   s_axis_tvalid,
    output wire                   s_axis_tready,
    input  wire                   s_axis_tlast,
    output wire [DATA_WIDTH-1:0]  ll_data_out,
    output wire                   ll_sof_out_n,
    output wire                   ll_eof_out_n,
    output wire                   ll_src_rdy_out_n,
    input  wire                   ll_dst_rdy_in_n
);
reg last_tlast = 1'b1;
always @(posedge clk) begin
    if (rst) begin
        last_tlast = 1'b1;
    end else begin
        if (s_axis_tvalid && s_axis_tready) last_tlast = s_axis_tlast;
    end
end
wire invalid = s_axis_tvalid && s_axis_tlast && last_tlast;
assign s_axis_tready = !ll_dst_rdy_in_n;
assign ll_data_out = s_axis_tdata;
assign ll_sof_out_n = !(last_tlast && s_axis_tvalid && !invalid);
assign ll_eof_out_n = !(s_axis_tlast && !invalid);
assign ll_src_rdy_out_n = !(s_axis_tvalid && !invalid);
endmodule