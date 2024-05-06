module rvdff_WIDTH12
(
  din,
  clock,
  rst_l,
  dout
);
  input [11:0] din;
  output [11:0] dout;
  input clock;
  input rst_l;
  wire N0;
  reg [11:0] dout;
  always @(posedge clock or posedge N0) begin
    if(N0) begin
      dout[11] <= 1'b0;
    end else if(1'b1) begin
      dout[11] <= din[11];
    end
  end
  always @(posedge clock or posedge N0) begin
    if(N0) begin
      dout[10] <= 1'b0;
    end else if(1'b1) begin
      dout[10] <= din[10];
    end
  end
  always @(posedge clock or posedge N0) begin
    if(N0) begin
      dout[9] <= 1'b0;
    end else if(1'b1) begin
      dout[9] <= din[9];
    end
  end
  always @(posedge clock or posedge N0) begin
    if(N0) begin
      dout[8] <= 1'b0;
    end else if(1'b1) begin
      dout[8] <= din[8];
    end
  end
  always @(posedge clock or posedge N0) begin
    if(N0) begin
      dout[7] <= 1'b0;
    end else if(1'b1) begin
      dout[7] <= din[7];
    end
  end
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