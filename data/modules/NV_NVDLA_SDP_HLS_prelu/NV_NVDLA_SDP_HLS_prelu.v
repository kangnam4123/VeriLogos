module NV_NVDLA_SDP_HLS_prelu (
   cfg_prelu_en
  ,data_in
  ,op_in
  ,data_out
  );
parameter IN_WIDTH = 32;
parameter OP_WIDTH = 32;
parameter OUT_WIDTH = 64;
input cfg_prelu_en;
input [IN_WIDTH-1:0] data_in;
input [OP_WIDTH-1:0] op_in;
output [OUT_WIDTH-1:0] data_out;
reg [OUT_WIDTH-1:0] data_out;
wire data_in_sign;
assign data_in_sign = data_in[IN_WIDTH-1];
always @(
  cfg_prelu_en
  or data_in_sign
  or data_in
  or op_in
  ) begin
   if (cfg_prelu_en & !data_in_sign)
      data_out[((OUT_WIDTH) - 1):0] = {{(OUT_WIDTH-IN_WIDTH){1'b0}},data_in[IN_WIDTH-1:0]};
   else
      data_out[((OUT_WIDTH) - 1):0] = $signed(data_in[((IN_WIDTH) - 1):0]) * $signed(op_in[((OP_WIDTH) - 1):0]);
end
endmodule