module ad_csc_1_add_1 (
  clk,
  data_1,
  data_2,
  data_3,
  data_4,
  data_p,
  ddata_in,
  ddata_out);
  parameter   DELAY_DATA_WIDTH = 16;
  localparam  DW = DELAY_DATA_WIDTH - 1;
  input           clk;
  input   [24:0]  data_1;
  input   [24:0]  data_2;
  input   [24:0]  data_3;
  input   [24:0]  data_4;
  output  [ 7:0]  data_p;
  input   [DW:0]  ddata_in;
  output  [DW:0]  ddata_out;
  reg     [DW:0]  p1_ddata = 'd0;
  reg     [24:0]  p1_data_1 = 'd0;
  reg     [24:0]  p1_data_2 = 'd0;
  reg     [24:0]  p1_data_3 = 'd0;
  reg     [24:0]  p1_data_4 = 'd0;
  reg     [DW:0]  p2_ddata = 'd0;
  reg     [24:0]  p2_data_0 = 'd0;
  reg     [24:0]  p2_data_1 = 'd0;
  reg     [DW:0]  p3_ddata = 'd0;
  reg     [24:0]  p3_data = 'd0;
  reg     [DW:0]  ddata_out = 'd0;
  reg     [ 7:0]  data_p = 'd0;
  wire    [24:0]  p1_data_1_p_s;
  wire    [24:0]  p1_data_1_n_s;
  wire    [24:0]  p1_data_1_s;
  wire    [24:0]  p1_data_2_p_s;
  wire    [24:0]  p1_data_2_n_s;
  wire    [24:0]  p1_data_2_s;
  wire    [24:0]  p1_data_3_p_s;
  wire    [24:0]  p1_data_3_n_s;
  wire    [24:0]  p1_data_3_s;
  wire    [24:0]  p1_data_4_p_s;
  wire    [24:0]  p1_data_4_n_s;
  wire    [24:0]  p1_data_4_s;
  assign p1_data_1_p_s = {1'b0, data_1[23:0]};
  assign p1_data_1_n_s = ~p1_data_1_p_s + 1'b1;
  assign p1_data_1_s = (data_1[24] == 1'b1) ? p1_data_1_n_s : p1_data_1_p_s;
  assign p1_data_2_p_s = {1'b0, data_2[23:0]};
  assign p1_data_2_n_s = ~p1_data_2_p_s + 1'b1;
  assign p1_data_2_s = (data_2[24] == 1'b1) ? p1_data_2_n_s : p1_data_2_p_s;
  assign p1_data_3_p_s = {1'b0, data_3[23:0]};
  assign p1_data_3_n_s = ~p1_data_3_p_s + 1'b1;
  assign p1_data_3_s = (data_3[24] == 1'b1) ? p1_data_3_n_s : p1_data_3_p_s;
  assign p1_data_4_p_s = {1'b0, data_4[23:0]};
  assign p1_data_4_n_s = ~p1_data_4_p_s + 1'b1;
  assign p1_data_4_s = (data_4[24] == 1'b1) ? p1_data_4_n_s : p1_data_4_p_s;
  always @(posedge clk) begin
    p1_ddata <= ddata_in;
    p1_data_1 <= p1_data_1_s;
    p1_data_2 <= p1_data_2_s;
    p1_data_3 <= p1_data_3_s;
    p1_data_4 <= p1_data_4_s;
  end
  always @(posedge clk) begin
    p2_ddata <= p1_ddata;
    p2_data_0 <= p1_data_1 + p1_data_2;
    p2_data_1 <= p1_data_3 + p1_data_4;
  end
  always @(posedge clk) begin
    p3_ddata <= p2_ddata;
    p3_data <= p2_data_0 + p2_data_1;
  end
  always @(posedge clk) begin
    ddata_out <= p3_ddata;
    if (p3_data[24] == 1'b1) begin
      data_p <= 8'h00;
    end else if (p3_data[23:20] == 'd0) begin
      data_p <= p3_data[19:12];
    end else begin
      data_p <= 8'hff;
    end
  end
endmodule