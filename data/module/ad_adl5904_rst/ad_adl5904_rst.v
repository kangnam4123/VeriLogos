module ad_adl5904_rst (
  input           sys_cpu_clk,
  input           rf_peak_det_n,
  output          rf_peak_rst);
  reg             rf_peak_det_n_d = 'd0;
  reg             rf_peak_det_enb_d = 'd0;
  reg             rf_peak_rst_enb = 'd0;
  reg             rf_peak_rst_int = 'd0;
  wire            rf_peak_det_enb_s;
  wire            rf_peak_rst_1_s;
  wire            rf_peak_rst_0_s;
  assign rf_peak_rst = rf_peak_rst_int;
  assign rf_peak_det_enb_s = ~(rf_peak_det_n_d & rf_peak_det_n);
  assign rf_peak_rst_1_s = ~rf_peak_det_enb_d & rf_peak_det_enb_s;
  assign rf_peak_rst_0_s = rf_peak_det_enb_d & ~rf_peak_det_enb_s;
  always @(posedge sys_cpu_clk) begin
    rf_peak_det_n_d <= rf_peak_det_n;
    rf_peak_det_enb_d <= rf_peak_det_enb_s;
    if (rf_peak_rst_1_s == 1'b1) begin
      rf_peak_rst_enb <= 1'b1;
    end else if (rf_peak_rst_0_s == 1'b1) begin
      rf_peak_rst_enb <= 1'b0;
    end
    rf_peak_rst_int = ~rf_peak_rst_int & rf_peak_rst_enb;
  end
endmodule