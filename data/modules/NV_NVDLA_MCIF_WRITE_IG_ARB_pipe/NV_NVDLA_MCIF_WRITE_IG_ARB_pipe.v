module NV_NVDLA_MCIF_WRITE_IG_ARB_pipe (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,bpt2arb_cmd_pd
  ,bpt2arb_cmd_valid
  ,bpt2arb_cmd_ready
  ,src_cmd_pd
  ,src_cmd_vld
  ,src_cmd_rdy
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input [32 +13 -1:0] bpt2arb_cmd_pd;
input bpt2arb_cmd_valid;
output bpt2arb_cmd_ready;
output [32 +13 -1:0] src_cmd_pd;
output src_cmd_vld;
input src_cmd_rdy;
reg pipe_bpt2arb_cmd_valid;
reg [45-1:0] pipe_bpt2arb_cmd_pd;
wire bpt2arb_cmd_ready;
wire pipe_bpt2arb_cmd_ready;
wire src_cmd_vld;
wire [45-1:0] src_cmd_pd;
assign bpt2arb_cmd_ready = pipe_bpt2arb_cmd_ready || !pipe_bpt2arb_cmd_valid;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_bpt2arb_cmd_valid <= 1'b0;
    end else begin
        if (bpt2arb_cmd_ready) begin
            pipe_bpt2arb_cmd_valid <= bpt2arb_cmd_valid;
        end
    end
end
always @(posedge nvdla_core_clk) begin
    if (bpt2arb_cmd_ready && bpt2arb_cmd_valid) begin
        pipe_bpt2arb_cmd_pd[45-1:0] <= bpt2arb_cmd_pd[45-1:0];
    end
end
assign pipe_bpt2arb_cmd_ready = src_cmd_rdy;
assign src_cmd_vld = pipe_bpt2arb_cmd_valid;
assign src_cmd_pd = pipe_bpt2arb_cmd_pd;
endmodule