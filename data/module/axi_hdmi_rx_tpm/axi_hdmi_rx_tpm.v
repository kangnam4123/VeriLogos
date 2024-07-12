module axi_hdmi_rx_tpm (
  hdmi_clk,
  hdmi_sof,
  hdmi_de,
  hdmi_data,
  hdmi_tpm_oos);
  input           hdmi_clk;
  input           hdmi_sof;
  input           hdmi_de;
  input   [15:0]  hdmi_data;
  output          hdmi_tpm_oos;
  wire    [15:0]  hdmi_tpm_lr_data_s;
  wire            hdmi_tpm_lr_mismatch_s;
  wire    [15:0]  hdmi_tpm_fr_data_s;
  wire            hdmi_tpm_fr_mismatch_s;
  reg     [15:0]  hdmi_tpm_data = 'd0;
  reg             hdmi_tpm_lr_mismatch = 'd0;
  reg             hdmi_tpm_fr_mismatch = 'd0;
  reg             hdmi_tpm_oos = 'd0;
  assign hdmi_tpm_lr_data_s[15:8] = (hdmi_tpm_data[15:8] < 8'h10) ? 8'h10 :
    ((hdmi_tpm_data[15:8] > 8'heb) ? 8'heb : hdmi_tpm_data[15:8]);
  assign hdmi_tpm_lr_data_s[ 7:0] = (hdmi_tpm_data[ 7:0] < 8'h10) ? 8'h10 :
    ((hdmi_tpm_data[ 7:0] > 8'heb) ? 8'heb : hdmi_tpm_data[ 7:0]);
  assign hdmi_tpm_lr_mismatch_s = (hdmi_tpm_lr_data_s == hdmi_data) ? 1'b0 : 1'b1;
  assign hdmi_tpm_fr_data_s[15:8] = (hdmi_tpm_data[15:8] < 8'h01) ? 8'h01 :
    ((hdmi_tpm_data[15:8] > 8'hfe) ? 8'hfe : hdmi_tpm_data[15:8]);
  assign hdmi_tpm_fr_data_s[ 7:0] = (hdmi_tpm_data[ 7:0] < 8'h01) ? 8'h01 :
    ((hdmi_tpm_data[ 7:0] > 8'hfe) ? 8'hfe : hdmi_tpm_data[ 7:0]);
  assign hdmi_tpm_fr_mismatch_s = (hdmi_tpm_fr_data_s == hdmi_data) ? 1'b0 : 1'b1;
  always @(posedge hdmi_clk) begin
    if (hdmi_sof == 1'b1) begin
      hdmi_tpm_data <= 16'd0;
      hdmi_tpm_lr_mismatch <= 1'd0;
      hdmi_tpm_fr_mismatch <= 1'd0;
      hdmi_tpm_oos <= hdmi_tpm_lr_mismatch & hdmi_tpm_fr_mismatch;
    end else if (hdmi_de == 1'b1) begin
      hdmi_tpm_data <= hdmi_tpm_data + 1'b1;
      hdmi_tpm_lr_mismatch <= hdmi_tpm_lr_mismatch | hdmi_tpm_lr_mismatch_s;
      hdmi_tpm_fr_mismatch <= hdmi_tpm_fr_mismatch | hdmi_tpm_fr_mismatch_s;
    end
  end
endmodule