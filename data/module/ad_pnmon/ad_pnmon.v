module ad_pnmon #(
  parameter DATA_WIDTH = 16) (
  input                       adc_clk,
  input                       adc_valid_in,
  input   [(DATA_WIDTH-1):0]  adc_data_in,
  input   [(DATA_WIDTH-1):0]  adc_data_pn,
  output                      adc_pn_oos,
  output                      adc_pn_err);
  reg                         adc_valid_d = 'd0;
  reg                         adc_pn_match_d = 'd0;
  reg                         adc_pn_match_z = 'd0;
  reg                         adc_pn_oos_int = 'd0;
  reg                         adc_pn_err_int = 'd0;
  reg     [ 3:0]              adc_pn_oos_count = 'd0;
  wire                        adc_pn_match_d_s;
  wire                        adc_pn_match_z_s;
  wire                        adc_pn_match_s;
  wire                        adc_pn_update_s;
  wire                        adc_pn_err_s;
  assign adc_pn_match_d_s = (adc_data_in == adc_data_pn) ? 1'b1 : 1'b0;
  assign adc_pn_match_z_s = (adc_data_in == 'd0) ? 1'b0 : 1'b1;
  assign adc_pn_match_s = adc_pn_match_d & adc_pn_match_z;
  assign adc_pn_update_s = ~(adc_pn_oos_int ^ adc_pn_match_s);
  assign adc_pn_err_s = ~(adc_pn_oos_int | adc_pn_match_s);
  assign adc_pn_oos = adc_pn_oos_int;
  assign adc_pn_err = adc_pn_err_int;
  always @(posedge adc_clk) begin
    adc_valid_d <= adc_valid_in;
    adc_pn_match_d <= adc_pn_match_d_s;
    adc_pn_match_z <= adc_pn_match_z_s;
    if (adc_valid_d == 1'b1) begin
      adc_pn_err_int <= adc_pn_err_s;
      if ((adc_pn_update_s == 1'b1) && (adc_pn_oos_count >= 15)) begin
        adc_pn_oos_int <= ~adc_pn_oos_int;
      end
      if (adc_pn_update_s == 1'b1) begin
        adc_pn_oos_count <= adc_pn_oos_count + 1'b1;
      end else begin
        adc_pn_oos_count <= 'd0;
      end
    end
  end
endmodule