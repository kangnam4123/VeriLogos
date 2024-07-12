module util_pulse_gen #(
  parameter   PULSE_WIDTH = 7,
  parameter   PULSE_PERIOD = 100000000)(         
  input               clk,
  input               rstn,
  input       [31:0]  pulse_period,
  input               pulse_period_en,
  output  reg         pulse
);
  reg     [(PULSE_WIDTH-1):0]  pulse_width_cnt = {PULSE_WIDTH{1'b1}};
  reg     [31:0]               pulse_period_cnt = 32'h0;
  reg     [31:0]               pulse_period_d = 32'b0;
  wire                         end_of_period_s;
  always @(posedge clk) begin
    pulse_period_d <= (pulse_period_en) ? pulse_period : PULSE_PERIOD;
  end
  always @(posedge clk) begin
    if (rstn == 1'b0) begin
      pulse_period_cnt <= 32'h0;
    end else begin
      pulse_period_cnt <= (pulse_period_cnt == pulse_period_d) ? 32'b0 : (pulse_period_cnt + 1);
    end
  end
  assign  end_of_period_s = (pulse_period_cnt == pulse_period_d) ? 1'b1 : 1'b0;
  always @(posedge clk) begin
    if (rstn == 1'b0) begin
      pulse_width_cnt <= 0;
      pulse <= 0;
    end else begin
      pulse_width_cnt <= (pulse == 1'b1) ? pulse_width_cnt + 1 : {PULSE_WIDTH{1'h0}};
      if(end_of_period_s == 1'b1) begin
        pulse <= 1'b1;
      end else if(pulse_width_cnt == {PULSE_WIDTH{1'b1}}) begin
        pulse <= 1'b0;
      end
    end
  end
endmodule