module ad_axis_inf_rx_2 (
  clk,
  rst,
  valid,
  last,
  data,
  inf_valid,
  inf_last,
  inf_data,
  inf_ready);
  parameter   DATA_WIDTH = 16;
  localparam  DW = DATA_WIDTH - 1;
  input           clk;
  input           rst;
  input           valid;
  input           last;
  input   [DW:0]  data;
  output          inf_valid;
  output          inf_last;
  output  [DW:0]  inf_data;
  input           inf_ready;
  reg     [ 2:0]  wcnt = 'd0;
  reg             wlast_0 = 'd0;
  reg     [DW:0]  wdata_0 = 'd0;
  reg             wlast_1 = 'd0;
  reg     [DW:0]  wdata_1 = 'd0;
  reg             wlast_2 = 'd0;
  reg     [DW:0]  wdata_2 = 'd0;
  reg             wlast_3 = 'd0;
  reg     [DW:0]  wdata_3 = 'd0;
  reg             wlast_4 = 'd0;
  reg     [DW:0]  wdata_4 = 'd0;
  reg             wlast_5 = 'd0;
  reg     [DW:0]  wdata_5 = 'd0;
  reg             wlast_6 = 'd0;
  reg     [DW:0]  wdata_6 = 'd0;
  reg             wlast_7 = 'd0;
  reg     [DW:0]  wdata_7 = 'd0;
  reg     [ 2:0]  rcnt    = 'd0;
  reg             inf_valid = 'd0;
  reg             inf_last = 'd0;
  reg     [DW:0]  inf_data = 'd0;
  wire            inf_ready_s;
  reg             inf_last_s;
  reg     [DW:0]  inf_data_s;
  always @(posedge clk) begin
    if (rst == 1'b1) begin
      wcnt <= 'd0;
    end else if (valid == 1'b1) begin
      wcnt <= wcnt + 1'b1;
    end
    if ((wcnt == 3'd0) && (valid == 1'b1)) begin
      wlast_0 <= last;
      wdata_0 <= data;
    end
    if ((wcnt == 3'd1) && (valid == 1'b1)) begin
      wlast_1 <= last;
      wdata_1 <= data;
    end
    if ((wcnt == 3'd2) && (valid == 1'b1)) begin
      wlast_2 <= last;
      wdata_2 <= data;
    end
    if ((wcnt == 3'd3) && (valid == 1'b1)) begin
      wlast_3 <= last;
      wdata_3 <= data;
    end
    if ((wcnt == 3'd4) && (valid == 1'b1)) begin
      wlast_4 <= last;
      wdata_4 <= data;
    end
    if ((wcnt == 3'd5) && (valid == 1'b1)) begin
      wlast_5 <= last;
      wdata_5 <= data;
    end
    if ((wcnt == 3'd6) && (valid == 1'b1)) begin
      wlast_6 <= last;
      wdata_6 <= data;
    end
    if ((wcnt == 3'd7) && (valid == 1'b1)) begin
      wlast_7 <= last;
      wdata_7 <= data;
    end
  end
  assign inf_ready_s = inf_ready | ~inf_valid;
  always @(rcnt or wlast_0 or wdata_0 or wlast_1 or wdata_1 or
    wlast_2 or wdata_2 or wlast_3 or wdata_3 or wlast_4 or wdata_4 or
    wlast_5 or wdata_5 or wlast_6 or wdata_6 or wlast_7 or wdata_7) begin
    case (rcnt)
      3'd0: begin
        inf_last_s = wlast_0;
        inf_data_s = wdata_0;
      end
      3'd1: begin
        inf_last_s = wlast_1;
        inf_data_s = wdata_1;
      end
      3'd2: begin
        inf_last_s = wlast_2;
        inf_data_s = wdata_2;
      end
      3'd3: begin
        inf_last_s = wlast_3;
        inf_data_s = wdata_3;
      end
      3'd4: begin
        inf_last_s = wlast_4;
        inf_data_s = wdata_4;
      end
      3'd5: begin
        inf_last_s = wlast_5;
        inf_data_s = wdata_5;
      end
      3'd6: begin
        inf_last_s = wlast_6;
        inf_data_s = wdata_6;
      end
      default: begin
        inf_last_s = wlast_7;
        inf_data_s = wdata_7;
      end
    endcase
  end
  always @(posedge clk) begin
    if (rst == 1'b1) begin
      rcnt <= 'd0;
      inf_valid <= 'd0;
      inf_last <= 'b0;
      inf_data <= 'd0;
    end else if (inf_ready_s == 1'b1) begin
      if (rcnt == wcnt) begin
        rcnt <= rcnt;
        inf_valid <= 1'd0;
        inf_last <= 1'b0;
        inf_data <= 'd0;
      end else begin
        rcnt <= rcnt + 1'b1;
        inf_valid <= 1'b1;
        inf_last <= inf_last_s;
        inf_data <= inf_data_s;
      end
    end
  end
endmodule