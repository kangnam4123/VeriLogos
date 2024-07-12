module filesystem_encrypt_buffer_V_m_axi_throttl
#(parameter
    USED_FIX       = 0,
    FIX_VALUE      = 4
)(
    input               clk,
    input               reset,
    input               ce,
    input   [7:0]       in_len,
    input               in_req_valid,
    input               in_req_ready,
    input               in_data_valid,
    input               in_data_ready,
    output              out_req_valid,
    output              out_req_ready
);
localparam threshold = (USED_FIX)? FIX_VALUE-1 : 0;
wire                req_en;
wire                handshake;
wire  [7:0]         load_init;
reg   [7:0]         throttl_cnt;
if (USED_FIX) begin
    assign load_init = FIX_VALUE-1;
    assign handshake = 1'b1;
end else begin
    assign load_init = in_len;
    assign handshake = in_data_valid & in_data_ready;
end
assign out_req_valid = in_req_valid & req_en;
assign out_req_ready = in_req_ready & req_en;
assign req_en = (throttl_cnt == 0);
always @(posedge clk)
begin
    if (reset)
        throttl_cnt <= 0;
    else if (ce) begin
        if (in_len > threshold && throttl_cnt == 0 && in_req_valid && in_req_ready)
            throttl_cnt <= load_init; 
        else if (throttl_cnt > 0 && handshake)
            throttl_cnt <= throttl_cnt - 1'b1;
    end
end
endmodule