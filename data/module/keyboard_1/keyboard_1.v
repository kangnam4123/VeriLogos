module keyboard_1(ps2_clk, ps2_data,
                clk, reset,
                keyboard_data, keyboard_rdy);
    input ps2_clk;
    input ps2_data;
    input clk;
    input reset;
    output [7:0] keyboard_data;
    output keyboard_rdy;
  reg ps2_clk_p;
  reg ps2_clk_s;
  reg ps2_data_p;
  reg ps2_data_s;
  wire [3:0] ps2_clk_int_x;
  reg [3:0] ps2_clk_int_r;
  reg ps2_clk_lvl;
  reg ps2_clk_lvl_prv;
  wire ps2_clk_fall;
  wire ps2_clk_rise;
  wire ps2_clk_edge;
  wire [9:0] data_x;
  reg [9:0] data_r;
  wire [12:0] timer_x;
  reg [12:0] timer_r;
  wire ps2_clk_quiet;
  wire [3:0] bitcnt_x;
  reg [3:0] bitcnt_r;
  wire rdy_x;
  reg rdy_r;
  wire err_x;
  reg err_r;
  always @(posedge clk) begin
    ps2_clk_p <= ps2_clk;
    ps2_clk_s <= ps2_clk_p;
    ps2_data_p <= ps2_data;
    ps2_data_s <= ps2_data_p;
  end
  assign ps2_clk_int_x =
    (ps2_clk_int_r == 4'b1111 && ps2_clk_s == 1) ? 4'b1111 :
    (ps2_clk_int_r == 4'b0000 && ps2_clk_s == 0) ? 4'b0000 :
    (ps2_clk_s == 1) ? ps2_clk_int_r + 1 :
    ps2_clk_int_r - 1;
  always @(posedge clk) begin
    if (reset == 1) begin
      ps2_clk_lvl_prv <= 1;
      ps2_clk_lvl <= 1;
    end else begin
      ps2_clk_lvl_prv <= ps2_clk_lvl;
      if (ps2_clk_int_r == 4'b0100) begin
        ps2_clk_lvl <= 0;
      end
      if (ps2_clk_int_r == 4'b1011) begin
        ps2_clk_lvl <= 1;
      end
    end
  end
  assign ps2_clk_fall = ps2_clk_lvl_prv & ~ps2_clk_lvl;
  assign ps2_clk_rise = ~ps2_clk_lvl_prv & ps2_clk_lvl;
  assign ps2_clk_edge = ps2_clk_fall | ps2_clk_rise;
  assign data_x =
    (ps2_clk_fall == 1) ? { ps2_data_s, data_r[9:1]} : data_r;
  assign timer_x =
    (ps2_clk_edge == 1) ? 13'b0000000000000 : timer_r + 1;
  assign ps2_clk_quiet =
    (timer_r == 13'b1010000000000 && ps2_clk_lvl == 1) ? 1 : 0;
  assign bitcnt_x =
    (ps2_clk_fall == 1) ? bitcnt_r + 1 :
    (ps2_clk_quiet == 1 || err_r == 1) ? 4'b0000:
    bitcnt_r;
  assign rdy_x =
    (bitcnt_r == 4'b1011 && ps2_clk_quiet == 1) ? 1 : 0;
  assign err_x =
    ((timer_r == 13'b1010000000000 &&
      ps2_clk_lvl == 0) ||
     (ps2_clk_quiet == 1 &&
      bitcnt_r != 4'b1011 &&
      bitcnt_r != 4'b0000)) ? 1 : err_r;
  always @(posedge clk) begin
    if (reset == 1 || err_r == 1) begin
      ps2_clk_int_r <= 4'b1111;
      data_r <= 10'b0000000000;
      timer_r <= 13'b0000000000000;
      bitcnt_r <= 4'b0000;
      rdy_r <= 0;
      err_r <= 0;
    end else begin
      ps2_clk_int_r <= ps2_clk_int_x;
      data_r <= data_x;
      timer_r <= timer_x;
      bitcnt_r <= bitcnt_x;
      rdy_r <= rdy_x;
      err_r <= err_x;
    end
  end
  assign keyboard_data = data_r[7:0];
  assign keyboard_rdy = rdy_r;
endmodule