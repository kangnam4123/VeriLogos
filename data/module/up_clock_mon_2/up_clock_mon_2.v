module up_clock_mon_2 #(
  parameter TOTAL_WIDTH = 32
) (
  input                              up_rstn,
  input                              up_clk,
  output  reg [TOTAL_WIDTH-1:0]      up_d_count,
  input                              d_rst,
  input                              d_clk);
  reg     [15:0]           up_count = 'd1;
  reg                      up_count_run = 'd0;
  reg                      up_count_running_m1 = 'd0;
  reg                      up_count_running_m2 = 'd0;
  reg                      up_count_running_m3 = 'd0;
  reg                      d_count_run_m1 = 'd0;
  reg                      d_count_run_m2 = 'd0;
  reg                      d_count_run_m3 = 'd0;
  reg     [TOTAL_WIDTH:0]  d_count = 'd0;
  wire                     up_count_capture_s;
  wire                     d_count_reset_s;
  assign up_count_capture_s = up_count_running_m3 == 1'b1 && up_count_running_m2 == 1'b0;
  always @(posedge up_clk) begin
    if (up_rstn == 0) begin
      up_count_running_m1 <= 1'b0;
      up_count_running_m2 <= 1'b0;
      up_count_running_m3 <= 1'b0;
    end else begin
      up_count_running_m1 <= d_count_run_m3;
      up_count_running_m2 <= up_count_running_m1;
      up_count_running_m3 <= up_count_running_m2;
    end
  end
  always @(posedge up_clk) begin
    if (up_rstn == 0) begin
      up_d_count <= 'd0;
      up_count_run <= 1'b0;
    end else begin
      if (up_count_running_m3 == 1'b0) begin
        up_count_run <= 1'b1;
      end else if (up_count == 'h00) begin
        up_count_run <= 1'b0;
      end
      if (up_count_capture_s == 1'b1) begin
        up_d_count <= d_count[TOTAL_WIDTH-1:0];
      end else if (up_count == 'h00 && up_count_run != up_count_running_m3) begin
        up_d_count <= 'h00;
      end
    end
  end
  always @(posedge up_clk) begin
    if (up_count_run == 1'b0 && up_count_running_m3 == 1'b0) begin
      up_count <= 'h01;
    end else begin
      up_count <= up_count + 1'b1;
    end
  end
  assign d_count_reset_s = d_count_run_m3 == 1'b0 && d_count_run_m2 == 1'b1;
  always @(posedge d_clk or posedge d_rst) begin
    if (d_rst == 1'b1) begin
      d_count_run_m1 <= 1'b0;
      d_count_run_m2 <= 1'b0;
      d_count_run_m3 <= 1'b0;
    end else begin
      d_count_run_m1 <= up_count_run;
      d_count_run_m2 <= d_count_run_m1;
      d_count_run_m3 <= d_count_run_m2;
    end
  end
  always @(posedge d_clk) begin
    if (d_count_reset_s == 1'b1) begin
      d_count <= 'h00;
    end else if (d_count_run_m3 == 1'b1) begin
      if (d_count[TOTAL_WIDTH] == 1'b0) begin
        d_count <= d_count + 1'b1;
      end else begin
        d_count <= {TOTAL_WIDTH+1{1'b1}};
      end
    end
  end
endmodule