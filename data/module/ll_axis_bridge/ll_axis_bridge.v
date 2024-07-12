module ll_axis_bridge #
(
    parameter DATA_WIDTH = 8
)
(
    input  wire                   clk,
    input  wire                   rst,
    input  wire [DATA_WIDTH-1:0]  ll_data_in,
    input  wire                   ll_sof_in_n,
    input  wire                   ll_eof_in_n,
    input  wire                   ll_src_rdy_in_n,
    output wire                   ll_dst_rdy_out_n,
    output wire [DATA_WIDTH-1:0]  m_axis_tdata,
    output wire                   m_axis_tvalid,
    input  wire                   m_axis_tready,
    output wire                   m_axis_tlast
);
assign m_axis_tdata = ll_data_in;
assign m_axis_tvalid = !ll_src_rdy_in_n;
assign m_axis_tlast = !ll_eof_in_n;
assign ll_dst_rdy_out_n = !m_axis_tready;
endmodule