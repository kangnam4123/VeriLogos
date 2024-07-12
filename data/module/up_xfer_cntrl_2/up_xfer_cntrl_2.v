module up_xfer_cntrl_2 #(
  parameter     DATA_WIDTH = 8) (
  input                       up_rstn,
  input                       up_clk,
  input   [(DATA_WIDTH-1):0]  up_data_cntrl,
  output                      up_xfer_done,
  input                       d_rst,
  input                       d_clk,
  output  [(DATA_WIDTH-1):0]  d_data_cntrl);
  reg                         up_xfer_state_m1 = 'd0;
  reg                         up_xfer_state_m2 = 'd0;
  reg                         up_xfer_state = 'd0;
  reg     [ 5:0]              up_xfer_count = 'd0;
  reg                         up_xfer_done_int = 'd0;
  reg                         up_xfer_toggle = 'd0;
  reg     [(DATA_WIDTH-1):0]  up_xfer_data = 'd0;
  reg                         d_xfer_toggle_m1 = 'd0;
  reg                         d_xfer_toggle_m2 = 'd0;
  reg                         d_xfer_toggle_m3 = 'd0;
  reg                         d_xfer_toggle = 'd0;
  reg     [(DATA_WIDTH-1):0]  d_data_cntrl_int = 'd0;
  wire                        up_xfer_enable_s;
  wire                        d_xfer_toggle_s;
  assign up_xfer_done = up_xfer_done_int;
  assign up_xfer_enable_s = up_xfer_state ^ up_xfer_toggle;
  always @(posedge up_clk) begin
    if (up_rstn == 1'b0) begin
      up_xfer_state_m1 <= 'd0;
      up_xfer_state_m2 <= 'd0;
      up_xfer_state <= 'd0;
      up_xfer_count <= 'd0;
      up_xfer_done_int <= 'd0;
      up_xfer_toggle <= 'd0;
      up_xfer_data <= 'd0;
    end else begin
      up_xfer_state_m1 <= d_xfer_toggle;
      up_xfer_state_m2 <= up_xfer_state_m1;
      up_xfer_state <= up_xfer_state_m2;
      up_xfer_count <= up_xfer_count + 1'd1;
      up_xfer_done_int <= (up_xfer_count == 6'd1) ? ~up_xfer_enable_s : 1'b0;
      if ((up_xfer_count == 6'd1) && (up_xfer_enable_s == 1'b0)) begin
        up_xfer_toggle <= ~up_xfer_toggle;
        up_xfer_data <= up_data_cntrl;
      end
    end
  end
  assign d_data_cntrl = d_data_cntrl_int;
  assign d_xfer_toggle_s = d_xfer_toggle_m3 ^ d_xfer_toggle_m2;
  always @(posedge d_clk or posedge d_rst) begin
    if (d_rst == 1'b1) begin
      d_xfer_toggle_m1 <= 'd0;
      d_xfer_toggle_m2 <= 'd0;
      d_xfer_toggle_m3 <= 'd0;
      d_xfer_toggle <= 'd0;
      d_data_cntrl_int <= 'd0;
    end else begin
      d_xfer_toggle_m1 <= up_xfer_toggle;
      d_xfer_toggle_m2 <= d_xfer_toggle_m1;
      d_xfer_toggle_m3 <= d_xfer_toggle_m2;
      d_xfer_toggle <= d_xfer_toggle_m3;
      if (d_xfer_toggle_s == 1'b1) begin
        d_data_cntrl_int <= up_xfer_data;
      end
    end
  end
endmodule