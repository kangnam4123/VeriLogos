module hq_dac
(
  input         reset,
  input         clk,
  input         clk_ena,
  input  [19:0] pcm_in,
  output reg    dac_out
);
wire [23:0] w_data_in_p0;
wire [23:0] w_data_err_p0;
wire [23:0] w_data_int_p0;
reg  [23:0] r_data_fwd_p1;
assign w_data_in_p0  = { {4{pcm_in[19]}}, pcm_in };
assign w_data_err_p0 = w_data_in_p0 - w_data_qt_p2;
assign w_data_int_p0 = { {3{w_data_err_p0[23]}}, w_data_err_p0[22:2] } 
                     + r_data_fwd_p1;
always @(posedge reset or posedge clk)
  if (reset)
    r_data_fwd_p1 <= 24'd0;
  else if (clk_ena)
    r_data_fwd_p1 <= w_data_int_p0;
wire [23:0] w_data_fb1_p1;
wire [23:0] w_data_fb2_p1;
wire [23:0] w_data_lpf_p1;
reg  [23:0] r_data_lpf_p2;
assign w_data_fb1_p1 = { {3{r_data_fwd_p1[23]}}, r_data_fwd_p1[22:2] } 
                     - { {3{w_data_qt_p2[23]}},  w_data_qt_p2[22:2] }; 
assign w_data_fb2_p1 = w_data_fb1_p1
                     - { {14{r_data_fwd_p2[23]}}, r_data_fwd_p2[22:13] }; 
assign w_data_lpf_p1 = w_data_fb2_p1 + r_data_lpf_p2;
always @(posedge reset or posedge clk)
  if (reset)
    r_data_lpf_p2 <= 24'd0;
  else if (clk_ena)
    r_data_lpf_p2 <= w_data_lpf_p1;
wire [23:0] w_data_fb3_p1;
wire [23:0] w_data_int_p1;
reg  [23:0] r_data_fwd_p2;
assign w_data_fb3_p1 = { {2{w_data_lpf_p1[23]}}, w_data_lpf_p1[22:1] } 
                     - { {2{w_data_qt_p2[23]}},  w_data_qt_p2[22:1] }; 
assign w_data_int_p1 = w_data_fb3_p1 + r_data_fwd_p2;
always @(posedge reset or posedge clk)
  if (reset)
    r_data_fwd_p2 <= 24'd0;
  else if (clk_ena)
    r_data_fwd_p2 <= w_data_int_p1;
wire [23:0] w_data_qt_p2;
assign w_data_qt_p2 = (r_data_fwd_p2[23]) ? 24'hF00000 : 24'h100000;
always @(posedge reset or posedge clk)
  if (reset)
    dac_out <= 1'b0;
  else if (clk_ena)
    dac_out <= ~r_data_fwd_p2[23];
endmodule