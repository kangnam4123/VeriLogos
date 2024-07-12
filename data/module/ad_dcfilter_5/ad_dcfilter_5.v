module ad_dcfilter_5 #(
  parameter   DISABLE = 0) (
  input               clk,
  input               valid,
  input       [15:0]  data,
  output reg          valid_out,
  output reg  [15:0]  data_out,
  input           dcfilt_enb,
  input   [15:0]  dcfilt_coeff,
  input   [15:0]  dcfilt_offset);
  reg             valid_d = 'd0;
  reg     [15:0]  data_d = 'd0;
  reg             valid_2d = 'd0;
  reg     [15:0]  data_2d = 'd0;
  wire    [47:0]  dc_offset_s;
  always @(posedge clk) begin
    valid_d <= valid;
    if (valid == 1'b1) begin
      data_d <= data + dcfilt_offset;
    end
    valid_2d <= valid_d;
    data_2d  <= data_d;
    valid_out <= valid_2d;
    data_out  <= data_2d;
  end
endmodule