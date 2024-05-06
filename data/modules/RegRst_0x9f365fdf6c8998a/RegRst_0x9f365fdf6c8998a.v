module RegRst_0x9f365fdf6c8998a
(
  input  wire [   0:0] clock,
  input  wire [   1:0] in_,
  output reg  [   1:0] out,
  input  wire [   0:0] reset
);
  localparam reset_value = 0;
  always @ (posedge clock) begin
    if (reset) begin
      out <= reset_value;
    end
    else begin
      out <= in_;
    end
  end
endmodule