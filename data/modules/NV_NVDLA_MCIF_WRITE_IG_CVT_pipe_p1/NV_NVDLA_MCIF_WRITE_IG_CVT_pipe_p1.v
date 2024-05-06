module NV_NVDLA_MCIF_WRITE_IG_CVT_pipe_p1 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,spt2cvt_cmd_pd
  ,spt2cvt_cmd_valid
  ,spt2cvt_cmd_ready
  ,cmd_pd
  ,cmd_vld
  ,cmd_rdy
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input [32 +13 -1:0] spt2cvt_cmd_pd;
input spt2cvt_cmd_valid;
output spt2cvt_cmd_ready;
output [32 +13 -1:0] cmd_pd;
output cmd_vld;
input cmd_rdy;
reg pipe_spt2cvt_cmd_valid;
reg [45-1:0] pipe_spt2cvt_cmd_pd;
wire spt2cvt_cmd_ready;
wire pipe_spt2cvt_cmd_ready;
wire cmd_vld;
wire [45-1:0] cmd_pd;
assign spt2cvt_cmd_ready = pipe_spt2cvt_cmd_ready || !pipe_spt2cvt_cmd_valid;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_spt2cvt_cmd_valid <= 1'b0;
    end else begin
        if (spt2cvt_cmd_ready) begin
            pipe_spt2cvt_cmd_valid <= spt2cvt_cmd_valid;
        end
    end
end
always @(posedge nvdla_core_clk) begin
    if (spt2cvt_cmd_ready && spt2cvt_cmd_valid) begin
        pipe_spt2cvt_cmd_pd[45-1:0] <= spt2cvt_cmd_pd[45-1:0];
    end
end
assign pipe_spt2cvt_cmd_ready = cmd_rdy;
assign cmd_vld = pipe_spt2cvt_cmd_valid;
assign cmd_pd = pipe_spt2cvt_cmd_pd;
endmodule