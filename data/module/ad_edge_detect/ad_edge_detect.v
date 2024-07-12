module ad_edge_detect #(
  parameter   EDGE = 0) (
  input                   clk,
  input                   rst,
  input                   in,
  output  reg             out);
  localparam  POS_EDGE = 0;
  localparam  NEG_EDGE = 1;
  localparam  ANY_EDGE = 2;
  reg         ff_m1 = 0;
  reg         ff_m2 = 0;
  always @(posedge clk) begin
    if (rst == 1) begin
      ff_m1 <= 0;
      ff_m2 <= 0;
    end else begin
      ff_m1 <= in;
      ff_m2 <= ff_m1;
    end
  end
  always @(posedge clk) begin
    if (rst == 1) begin
      out <= 1'b0;
    end else begin
      if (EDGE == POS_EDGE) begin
        out <= ff_m1 & ~ff_m2;
      end else if (EDGE == NEG_EDGE) begin
        out <= ~ff_m1 & ff_m2;
      end else begin
        out <= ff_m1 ^ ff_m2;
      end
    end
  end
endmodule