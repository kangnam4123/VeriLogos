module rvdff_WIDTH7
(
  din,
  clock,
  rst_l,
  dout
);
  input [6:0] din;
  output [6:0] dout;
  input clock;
  input rst_l;
  wire N0;
  reg [6:0] dout;
  always @(posedge clock or posedge N0) begin
    if(N0) begin
      dout[6] <= 1'b0;
    end else if(1'b1) begin
      dout[6] <= din[6];
    end
  end
  always @(posedge clock or posedge N0) begin
    if(N0) begin
      dout[5] <= 1'b0;
    end else if(1'b1) begin
      dout[5] <= din[5];
    end
  end
  always @(posedge clock or posedge N0) begin
    if(N0) begin
      dout[4] <= 1'b0;
    end else if(1'b1) begin
      dout[4] <= din[4];
    end
  end
  always @(posedge clock or posedge N0) begin
    if(N0) begin
      dout[3] <= 1'b0;
    end else if(1'b1) begin
      dout[3] <= din[3];
    end
  end
  always @(posedge clock or posedge N0) begin
    if(N0) begin
      dout[2] <= 1'b0;
    end else if(1'b1) begin
      dout[2] <= din[2];
    end
  end
  always @(posedge clock or posedge N0) begin
    if(N0) begin
      dout[1] <= 1'b0;
    end else if(1'b1) begin
      dout[1] <= din[1];
    end
  end
  always @(posedge clock or posedge N0) begin
    if(N0) begin
      dout[0] <= 1'b0;
    end else if(1'b1) begin
      dout[0] <= din[0];
    end
  end
  assign N0 = ~rst_l;
endmodule