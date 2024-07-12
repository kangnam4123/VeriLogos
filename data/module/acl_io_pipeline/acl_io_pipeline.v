module acl_io_pipeline #(
  parameter WIDTH = 1
)(
  input  clk,
  input  reset,
  input  i_stall,
  input  i_valid,
  input  [WIDTH-1:0] i_data,
  output o_stall,
  output reg o_valid,
  output reg [WIDTH-1:0] o_data
);
reg R_valid;
assign o_stall = i_stall & R_valid;
always@(posedge clk) begin
  if(!o_stall) {o_valid, o_data} <= {i_valid, i_data};
end
always@(posedge clk or posedge reset)begin
  if(reset) R_valid <= 1'b0;
  else if(!o_stall) R_valid <= i_valid;
end
endmodule