module rvdff_WIDTH1
(
  din,
  clock,
  rst_l,
  dout
);
  input [0:0] din;
  output [0:0] dout;
  input clock;
  input rst_l;
  wire N0;
  reg [0:0] dout;
  always @(posedge clock or posedge N0) begin
    if(N0) begin
      dout[0] <= 1'b0;
    end else if(1'b1) begin
      dout[0] <= din[0];
    end
  end
  assign N0 = ~rst_l;
endmodule