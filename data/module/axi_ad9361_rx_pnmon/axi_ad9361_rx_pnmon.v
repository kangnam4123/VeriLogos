module axi_ad9361_rx_pnmon (
  adc_clk,
  adc_valid,
  adc_data_i,
  adc_data_q,
  adc_pn_oos,
  adc_pn_err);
  input           adc_clk;
  input           adc_valid;
  input   [11:0]  adc_data_i;
  input   [11:0]  adc_data_q;
  output          adc_pn_oos;
  output          adc_pn_err;
  reg     [15:0]  adc_data = 'd0;
  reg     [15:0]  adc_pn_data = 'd0;
  reg             adc_valid_d = 'd0;
  reg             adc_iq_match = 'd0;
  reg             adc_pn_match_d = 'd0;
  reg             adc_pn_match_z = 'd0;
  reg             adc_pn_err = 'd0;
  reg     [ 6:0]  adc_pn_oos_count = 'd0;
  reg             adc_pn_oos = 'd0;
  wire    [11:0]  adc_data_i_s;
  wire    [11:0]  adc_data_q_s;
  wire    [11:0]  adc_data_q_rev_s;
  wire    [15:0]  adc_data_s;
  wire            adc_iq_match_s;
  wire    [15:0]  adc_pn_data_s;
  wire            adc_pn_match_d_s;
  wire            adc_pn_match_z_s;
  wire            adc_pn_match_s;
  wire            adc_pn_update_s;
  wire            adc_pn_err_s;
  function [15:0] pnfn;
    input [15:0] din;
    reg   [15:0] dout;
    begin
      dout = {din[14:0], ~((^din[15:4]) ^ (^din[2:1]))};
      pnfn = dout;
    end
  endfunction
  function [11:0] brfn;
    input [11:0] din;
    reg   [11:0] dout;
    begin
      dout[11] = din[ 0];
      dout[10] = din[ 1];
      dout[ 9] = din[ 2];
      dout[ 8] = din[ 3];
      dout[ 7] = din[ 4];
      dout[ 6] = din[ 5];
      dout[ 5] = din[ 6];
      dout[ 4] = din[ 7];
      dout[ 3] = din[ 8];
      dout[ 2] = din[ 9];
      dout[ 1] = din[10];
      dout[ 0] = din[11];
      brfn = dout;
    end
  endfunction
  assign adc_data_i_s = ~adc_data_i;
  assign adc_data_q_s = ~adc_data_q;
  assign adc_data_q_rev_s = brfn(adc_data_q_s);
  assign adc_data_s = {adc_data_i_s, adc_data_q_rev_s[3:0]};
  assign adc_iq_match_s = (adc_data_i_s[7:0] == adc_data_q_rev_s[11:4]) ? 1'b1 : 1'b0;
  assign adc_pn_data_s = (adc_pn_oos == 1'b1) ? adc_data_s : adc_pn_data;
  assign adc_pn_match_d_s = (adc_data_s == adc_pn_data) ? 1'b1 : 1'b0;
  assign adc_pn_match_z_s = (adc_data_s == adc_data) ? 1'b0 : 1'b1;
  assign adc_pn_match_s = adc_iq_match & adc_pn_match_d & adc_pn_match_z;
  assign adc_pn_update_s = ~(adc_pn_oos ^ adc_pn_match_s);
  assign adc_pn_err_s = ~(adc_pn_oos | adc_pn_match_s);
  always @(posedge adc_clk) begin
    if (adc_valid == 1'b1) begin
      adc_data <= adc_data_s;
      adc_pn_data <= pnfn(adc_pn_data_s);
    end
    adc_valid_d <= adc_valid;
    adc_iq_match <= adc_iq_match_s;
    adc_pn_match_d <= adc_pn_match_d_s;
    adc_pn_match_z <= adc_pn_match_z_s;
    if (adc_valid_d == 1'b1) begin
      adc_pn_err <= adc_pn_err_s;
      if (adc_pn_update_s == 1'b1) begin
        if (adc_pn_oos_count >= 16) begin
          adc_pn_oos_count <= 'd0;
          adc_pn_oos <= ~adc_pn_oos;
        end else begin
          adc_pn_oos_count <= adc_pn_oos_count + 1'b1;
          adc_pn_oos <= adc_pn_oos;
        end
      end else begin
        adc_pn_oos_count <= 'd0;
        adc_pn_oos <= adc_pn_oos;
      end
    end
  end
endmodule