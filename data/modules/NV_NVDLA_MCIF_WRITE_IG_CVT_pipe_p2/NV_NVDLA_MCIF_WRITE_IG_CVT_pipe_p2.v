module NV_NVDLA_MCIF_WRITE_IG_CVT_pipe_p2 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,spt2cvt_dat_pd
  ,spt2cvt_dat_valid
  ,spt2cvt_dat_ready
  ,dat_pd
  ,dat_vld
  ,dat_rdy
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input [64 +1 -1:0] spt2cvt_dat_pd;
input spt2cvt_dat_valid;
output spt2cvt_dat_ready;
output [64 +1 -1:0] dat_pd;
output dat_vld;
input dat_rdy;
reg pipe_spt2cvt_dat_valid;
reg [65-1:0] pipe_spt2cvt_dat_pd;
wire spt2cvt_dat_ready;
wire pipe_spt2cvt_dat_ready;
wire dat_vld;
wire [65-1:0] dat_pd;
assign spt2cvt_dat_ready = pipe_spt2cvt_dat_ready || !pipe_spt2cvt_dat_valid;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_spt2cvt_dat_valid <= 1'b0;
    end else begin
        if (spt2cvt_dat_ready) begin
            pipe_spt2cvt_dat_valid <= spt2cvt_dat_valid;
        end
    end
end
always @(posedge nvdla_core_clk) begin
    if (spt2cvt_dat_ready && spt2cvt_dat_valid) begin
        pipe_spt2cvt_dat_pd[65-1:0] <= spt2cvt_dat_pd[65-1:0];
    end
end
assign pipe_spt2cvt_dat_ready = dat_rdy;
assign dat_vld = pipe_spt2cvt_dat_valid;
assign dat_pd = pipe_spt2cvt_dat_pd;
endmodule