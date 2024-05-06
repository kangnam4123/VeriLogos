module NV_NVDLA_MCIF_WRITE_IG_BPT_pipe_p3 (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,in_cmd_rdy
  ,ipipe_cmd_pd
  ,ipipe_cmd_vld
  ,in_cmd_pd
  ,in_cmd_vld
  ,ipipe_cmd_rdy
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input in_cmd_rdy;
input [46 -1:0] ipipe_cmd_pd;
input ipipe_cmd_vld;
output [46 -1:0] in_cmd_pd;
output in_cmd_vld;
output ipipe_cmd_rdy;
reg pipe_ipipe_cmd_vld;
reg [46-1:0] pipe_ipipe_cmd_pd;
wire ipipe_cmd_rdy;
wire pipe_ipipe_cmd_rdy;
wire in_cmd_vld;
wire [46-1:0] in_cmd_pd;
assign ipipe_cmd_rdy = pipe_ipipe_cmd_rdy || !pipe_ipipe_cmd_vld;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
    if (!nvdla_core_rstn) begin
        pipe_ipipe_cmd_vld <= 1'b0;
    end else begin
        if (ipipe_cmd_rdy) begin
            pipe_ipipe_cmd_vld <= ipipe_cmd_vld;
        end
    end
end
always @(posedge nvdla_core_clk) begin
    if (ipipe_cmd_rdy && ipipe_cmd_vld) begin
        pipe_ipipe_cmd_pd[46-1:0] <= ipipe_cmd_pd[46-1:0];
    end
end
assign pipe_ipipe_cmd_rdy = in_cmd_rdy;
assign in_cmd_vld = pipe_ipipe_cmd_vld;
assign in_cmd_pd = pipe_ipipe_cmd_pd;
endmodule