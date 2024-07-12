module apu_div
#(
  parameter PERIOD_BITS = 16
)
(
  input                    clk_in,     
  input                    rst_in,     
  input                    pulse_in,   
  input                    reload_in,  
  input  [PERIOD_BITS-1:0] period_in,  
  output                   pulse_out   
);
reg  [PERIOD_BITS-1:0] q_cnt;
wire [PERIOD_BITS-1:0] d_cnt;
always @(posedge clk_in)
  begin
    if (rst_in)
      q_cnt <= 0;
    else
      q_cnt <= d_cnt;
  end
assign d_cnt     = (reload_in || (pulse_in && (q_cnt == 0))) ? period_in    :
                   (pulse_in)                                ? q_cnt - 1'h1 : q_cnt;
assign pulse_out = pulse_in && (q_cnt == 0);
endmodule