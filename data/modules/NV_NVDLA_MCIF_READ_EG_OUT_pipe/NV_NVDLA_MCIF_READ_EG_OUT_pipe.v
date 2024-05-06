module NV_NVDLA_MCIF_READ_EG_OUT_pipe (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,dma_pd
  ,dma_vld
  ,dma_rdy
  ,mcif_rd_rsp_ready
  ,mcif_rd_rsp_pd
  ,mcif_rd_rsp_valid
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input [65 -1:0] dma_pd;
input dma_vld;
output dma_rdy;
output [65 -1:0] mcif_rd_rsp_pd;
output mcif_rd_rsp_valid;
input mcif_rd_rsp_ready;
reg pipe_dma_vld;
reg [65-1:0] pipe_dma_pd;
wire dma_rdy;
wire pipe_dma_rdy;
wire mcif_rd_rsp_valid;
wire [65-1:0] mcif_rd_rsp_pd;
assign dma_rdy = pipe_dma_rdy || !pipe_dma_vld;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_dma_vld <= 1'b0;
    end else begin
        if (dma_rdy) begin
            pipe_dma_vld <= dma_vld;
        end
    end
end
always @(posedge nvdla_core_clk) begin
    if (dma_rdy && dma_vld) begin
        pipe_dma_pd[65-1:0] <= dma_pd[65-1:0];
    end
end
assign pipe_dma_rdy = mcif_rd_rsp_ready;
assign mcif_rd_rsp_valid = pipe_dma_vld;
assign mcif_rd_rsp_pd = pipe_dma_pd;
endmodule