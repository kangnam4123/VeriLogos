module up_xfer_status #(
  parameter     DATA_WIDTH = 8) (
  input                       up_rstn,
  input                       up_clk,
  output  [(DATA_WIDTH-1):0]  up_data_status,
  input                       d_rst,
  input                       d_clk,
  input   [(DATA_WIDTH-1):0]  d_data_status);
  reg                         d_xfer_state_m1 = 'd0;
  reg                         d_xfer_state_m2 = 'd0;
  reg                         d_xfer_state = 'd0;
  reg     [ 5:0]              d_xfer_count = 'd0;
  reg                         d_xfer_toggle = 'd0;
  reg     [(DATA_WIDTH-1):0]  d_xfer_data = 'd0;
  reg     [(DATA_WIDTH-1):0]  d_acc_data = 'd0;
  reg                         up_xfer_toggle_m1 = 'd0;
  reg                         up_xfer_toggle_m2 = 'd0;
  reg                         up_xfer_toggle_m3 = 'd0;
  reg                         up_xfer_toggle = 'd0;
  reg     [(DATA_WIDTH-1):0]  up_data_status_int = 'd0;
  wire                        d_xfer_enable_s;
  wire                        up_xfer_toggle_s;
  assign d_xfer_enable_s = d_xfer_state ^ d_xfer_toggle;
  always @(posedge d_clk or posedge d_rst) begin
    if (d_rst == 1'b1) begin
      d_xfer_state_m1 <= 'd0;
      d_xfer_state_m2 <= 'd0;
      d_xfer_state <= 'd0;
      d_xfer_count <= 'd0;
      d_xfer_toggle <= 'd0;
      d_xfer_data <= 'd0;
      d_acc_data <= 'd0;
    end else begin
      d_xfer_state_m1 <= up_xfer_toggle;
      d_xfer_state_m2 <= d_xfer_state_m1;
      d_xfer_state <= d_xfer_state_m2;
      d_xfer_count <= d_xfer_count + 1'd1;
      if ((d_xfer_count == 6'd1) && (d_xfer_enable_s == 1'b0)) begin
        d_xfer_toggle <= ~d_xfer_toggle;
        d_xfer_data <= d_acc_data;
      end
      if ((d_xfer_count == 6'd1) && (d_xfer_enable_s == 1'b0)) begin
        d_acc_data <= d_data_status;
      end else begin
        d_acc_data <= d_acc_data | d_data_status;
      end
    end
  end
  assign up_data_status = up_data_status_int;
  assign up_xfer_toggle_s = up_xfer_toggle_m3 ^ up_xfer_toggle_m2;
  always @(posedge up_clk) begin
    if (up_rstn == 1'b0) begin
      up_xfer_toggle_m1 <= 'd0;
      up_xfer_toggle_m2 <= 'd0;
      up_xfer_toggle_m3 <= 'd0;
      up_xfer_toggle <= 'd0;
      up_data_status_int <= 'd0;
    end else begin
      up_xfer_toggle_m1 <= d_xfer_toggle;
      up_xfer_toggle_m2 <= up_xfer_toggle_m1;
      up_xfer_toggle_m3 <= up_xfer_toggle_m2;
      up_xfer_toggle <= up_xfer_toggle_m3;
      if (up_xfer_toggle_s == 1'b1) begin
        up_data_status_int <= d_xfer_data;
      end
    end
  end
endmodule