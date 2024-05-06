module NV_NVDLA_SDP_HLS_relu (
   data_in
  ,data_out
  );
parameter DATA_WIDTH = 32;
input [DATA_WIDTH-1:0] data_in;
output [DATA_WIDTH-1:0] data_out;
reg [DATA_WIDTH-1:0] data_out;
wire data_in_sign;
assign data_in_sign = data_in[DATA_WIDTH-1];
always @(
  data_in_sign
  or data_in
  ) begin
   if (!data_in_sign)
      data_out[((DATA_WIDTH) - 1):0] = data_in[((DATA_WIDTH) - 1):0];
   else
      data_out[((DATA_WIDTH) - 1):0] = {DATA_WIDTH{1'b0}};
end
endmodule