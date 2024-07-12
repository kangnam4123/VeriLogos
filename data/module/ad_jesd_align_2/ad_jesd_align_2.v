module ad_jesd_align_2 (
  rx_clk,
  rx_sof,
  rx_eof,
  rx_ferr,
  rx_fdata,
  rx_err,
  rx_data);
  input           rx_clk;
  input   [ 3:0]  rx_sof;
  input   [ 3:0]  rx_eof;
  input   [ 3:0]  rx_ferr;
  input   [31:0]  rx_fdata;
  output          rx_err;
  output  [31:0]  rx_data;
  reg     [31:0]  rx_fdata_d = 'd0;
  reg     [ 3:0]  rx_sof_hold = 'd0;
  reg     [ 3:0]  rx_eof_hold = 'd0;
  reg     [31:0]  rx_data = 'd0;
  reg             rx_err = 'd0;
  wire    [ 3:0]  rx_eof_s;
  wire            rx_err_s;
  assign rx_ferr_s = (rx_ferr == 4'd0) ? 1'b0 : 1'b1;
  always @(posedge rx_clk) begin
    rx_fdata_d <= rx_fdata;
    if (rx_sof != 4'd0) begin
      rx_sof_hold <= {rx_sof[0], rx_sof[1], rx_sof[2], rx_sof[3]};
    end
    if (rx_eof != 4'd0) begin
      rx_eof_hold <= {rx_eof[0], rx_eof[1], rx_eof[2], rx_eof[3]};
    end
    if (rx_sof_hold[3] == 1'b1) begin
      rx_data <= rx_fdata_d;
    end else if (rx_sof_hold[2] == 1'b1) begin
      rx_data <= {rx_fdata_d[23:0], rx_fdata[31:24]};
    end else if (rx_sof_hold[1] == 1'b1) begin
      rx_data <= {rx_fdata_d[15:0], rx_fdata[31:16]};
    end else if (rx_sof_hold[0] == 1'b1) begin
      rx_data <= {rx_fdata_d[7:0], rx_fdata[31:8]};
    end else begin
      rx_data <= 32'd0;
    end
    case ({rx_sof_hold, rx_eof_hold})
      8'b00000000: rx_err <= rx_ferr_s;
      8'b11111111: rx_err <= rx_ferr_s;
      8'b00010010: rx_err <= rx_ferr_s;
      8'b00100100: rx_err <= rx_ferr_s;
      8'b01001000: rx_err <= rx_ferr_s;
      8'b10000001: rx_err <= rx_ferr_s;
      8'b01011010: rx_err <= rx_ferr_s;
      8'b10100101: rx_err <= rx_ferr_s;
      default: rx_err <= 1'b1;
    endcase
  end
endmodule