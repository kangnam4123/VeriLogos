module mig_7series_v2_3_poc_cc #
  (parameter TCQ                        = 100,
   parameter CCENABLE                   = 0,
   parameter PCT_SAMPS_SOLID            = 95,
   parameter SAMPCNTRWIDTH              = 8,
   parameter SAMPLES                    = 128,
   parameter TAPCNTRWIDTH               = 7)
  (
  samples, samps_solid_thresh, poc_error,
  tap, samps_hi_held, psen, clk, rst, ktap_at_right_edge,
  ktap_at_left_edge, mmcm_lbclk_edge_aligned, mmcm_edge_detect_done,
  fall_lead_right, fall_trail_right, rise_lead_right,
  rise_trail_right, fall_lead_left, fall_trail_left, rise_lead_left,
  rise_trail_left, fall_lead_center, fall_trail_center,
  rise_lead_center, rise_trail_center
  );
  localparam integer SAMPS_SOLID_THRESH = (SAMPLES+1) * PCT_SAMPS_SOLID * 0.01;
  output [SAMPCNTRWIDTH:0] samples, samps_solid_thresh;
  input [TAPCNTRWIDTH-1:0] tap;
  input [SAMPCNTRWIDTH:0] samps_hi_held;
  input psen;
  input clk, rst;
  input ktap_at_right_edge, ktap_at_left_edge;
  input mmcm_lbclk_edge_aligned;
  wire reset_aligned_cnt = rst || ktap_at_right_edge || ktap_at_left_edge || mmcm_lbclk_edge_aligned;
  input mmcm_edge_detect_done;
  reg mmcm_edge_detect_done_r;
  always @(posedge clk) mmcm_edge_detect_done_r <= #TCQ mmcm_edge_detect_done;
  wire done = mmcm_edge_detect_done && ~mmcm_edge_detect_done_r;
  reg [6:0] aligned_cnt_r;
  wire [6:0] aligned_cnt_ns = reset_aligned_cnt ? 7'b0 : aligned_cnt_r + {6'b0, done};
  always @(posedge clk) aligned_cnt_r <= #TCQ aligned_cnt_ns;
  reg poc_error_r;
  wire poc_error_ns = ~rst && (aligned_cnt_r[6] || poc_error_r);
  always @(posedge clk) poc_error_r <= #TCQ poc_error_ns;
  output poc_error;
  assign poc_error = poc_error_r;
  input [TAPCNTRWIDTH-1:0] fall_lead_right, fall_trail_right, rise_lead_right, rise_trail_right;
  input [TAPCNTRWIDTH-1:0] fall_lead_left, fall_trail_left, rise_lead_left, rise_trail_left;
  input [TAPCNTRWIDTH-1:0] fall_lead_center, fall_trail_center, rise_lead_center, rise_trail_center;
  generate if (CCENABLE == 0) begin : no_characterization
    assign samples = SAMPLES[SAMPCNTRWIDTH:0];
    assign samps_solid_thresh = SAMPS_SOLID_THRESH[SAMPCNTRWIDTH:0];
  end else begin : characterization
  end endgenerate
endmodule