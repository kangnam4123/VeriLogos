module RegEn_0x68db79c4ec1d6e5b
(
  input  wire [   0:0] clock,
  input  wire [   0:0] en,
  input  wire [  15:0] in_,
  output reg  [  15:0] out,
  input  wire [   0:0] reset
);
  always @ (posedge clock) begin
    if (en) begin
      out <= in_;
    end
    else begin
    end
  end
endmodule