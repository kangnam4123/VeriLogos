module NV_NVDLA_CMAC_CORE_cfg (
   nvdla_core_clk
  ,nvdla_core_rstn
  ,dp2reg_done
  ,reg2dp_conv_mode
  ,reg2dp_op_en
  ,cfg_is_wg
  ,cfg_reg_en
  );
input nvdla_core_clk;
input nvdla_core_rstn;
input dp2reg_done;
input reg2dp_conv_mode;
input reg2dp_op_en;
output cfg_is_wg;
output cfg_reg_en;
wire cfg_is_wg_w;
wire cfg_reg_en_w;
reg  op_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       op_en_d1 <= 'b0;
   end else begin
       op_en_d1 <= reg2dp_op_en;
   end
end
reg  op_done_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       op_done_d1 <= 'b0;
   end else begin
       op_done_d1 <= dp2reg_done;
   end
end
reg  cfg_reg_en;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       cfg_reg_en <= 'b0;
   end else begin
       cfg_reg_en <= cfg_reg_en_w;
   end
end
reg  cfg_is_wg;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       cfg_is_wg <= 'b0;
   end else begin
       cfg_is_wg <= cfg_is_wg_w;
   end
end
reg  cfg_reg_en_d1;
always @(posedge nvdla_core_clk or negedge nvdla_core_rstn) begin
   if (!nvdla_core_rstn) begin
       cfg_reg_en_d1 <= 'b0;
   end else begin
       cfg_reg_en_d1 <= cfg_reg_en;
   end
end
assign cfg_reg_en_w = (~op_en_d1 | op_done_d1) & reg2dp_op_en;
assign cfg_is_wg_w = 1'b0;
endmodule