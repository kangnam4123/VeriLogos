module axi_hdmi_rx_es (
  hdmi_clk,
  hdmi_data,
  hdmi_vs_de,
  hdmi_hs_de,
  hdmi_data_de);
  parameter   DATA_WIDTH = 32;
  localparam  BYTE_WIDTH = DATA_WIDTH/8;
  input                       hdmi_clk;
  input   [(DATA_WIDTH-1):0]  hdmi_data;
  output                      hdmi_vs_de;
  output                      hdmi_hs_de;
  output  [(DATA_WIDTH-1):0]  hdmi_data_de;
  reg     [(DATA_WIDTH-1):0]  hdmi_data_d = 'd0;
  reg                         hdmi_hs_de_rcv_d = 'd0;
  reg                         hdmi_vs_de_rcv_d = 'd0;
  reg     [(DATA_WIDTH-1):0]  hdmi_data_2d = 'd0;
  reg                         hdmi_hs_de_rcv_2d = 'd0;
  reg                         hdmi_vs_de_rcv_2d = 'd0;
  reg     [(DATA_WIDTH-1):0]  hdmi_data_3d = 'd0;
  reg                         hdmi_hs_de_rcv_3d = 'd0;
  reg                         hdmi_vs_de_rcv_3d = 'd0;
  reg     [(DATA_WIDTH-1):0]  hdmi_data_4d = 'd0;
  reg                         hdmi_hs_de_rcv_4d = 'd0;
  reg                         hdmi_vs_de_rcv_4d = 'd0;
  reg     [(DATA_WIDTH-1):0]  hdmi_data_de = 'd0;
  reg                         hdmi_hs_de = 'd0;
  reg                         hdmi_vs_de = 'd0;
  reg     [ 1:0]              hdmi_preamble_cnt = 'd0;
  reg                         hdmi_hs_de_rcv = 'd0;
  reg                         hdmi_vs_de_rcv = 'd0;
  wire    [(DATA_WIDTH-1):0]  hdmi_ff_s;
  wire    [(DATA_WIDTH-1):0]  hdmi_00_s;
  wire    [(DATA_WIDTH-1):0]  hdmi_b6_s;
  wire    [(DATA_WIDTH-1):0]  hdmi_9d_s;
  wire    [(DATA_WIDTH-1):0]  hdmi_ab_s;
  wire    [(DATA_WIDTH-1):0]  hdmi_80_s;
  assign hdmi_ff_s = {BYTE_WIDTH{8'hff}};
  assign hdmi_00_s = {BYTE_WIDTH{8'h00}};
  assign hdmi_b6_s = {BYTE_WIDTH{8'hb6}};
  assign hdmi_9d_s = {BYTE_WIDTH{8'h9d}};
  assign hdmi_ab_s = {BYTE_WIDTH{8'hab}};
  assign hdmi_80_s = {BYTE_WIDTH{8'h80}};
  always @(posedge hdmi_clk) begin
    hdmi_data_d <= hdmi_data;
    hdmi_hs_de_rcv_d <= hdmi_hs_de_rcv;
    hdmi_vs_de_rcv_d <= hdmi_vs_de_rcv;
    hdmi_data_2d <= hdmi_data_d;
    hdmi_hs_de_rcv_2d <= hdmi_hs_de_rcv_d;
    hdmi_vs_de_rcv_2d <= hdmi_vs_de_rcv_d;
    hdmi_data_3d <= hdmi_data_2d;
    hdmi_hs_de_rcv_3d <= hdmi_hs_de_rcv_2d;
    hdmi_vs_de_rcv_3d <= hdmi_vs_de_rcv_2d;
    hdmi_data_4d <= hdmi_data_3d;
    hdmi_hs_de_rcv_4d <= hdmi_hs_de_rcv_3d;
    hdmi_vs_de_rcv_4d <= hdmi_vs_de_rcv_3d;
    hdmi_data_de  <= hdmi_data_4d;
    hdmi_hs_de <= hdmi_hs_de_rcv & hdmi_hs_de_rcv_4d;
    hdmi_vs_de <= hdmi_vs_de_rcv & hdmi_vs_de_rcv_4d;
  end
  always @(posedge hdmi_clk) begin
    if ((hdmi_data == hdmi_ff_s) || (hdmi_data == hdmi_00_s)) begin
      hdmi_preamble_cnt <= hdmi_preamble_cnt + 1'b1;
    end else begin
      hdmi_preamble_cnt <= 'd0;
    end
    if (hdmi_preamble_cnt == 3'b11) begin
      if ((hdmi_data == hdmi_b6_s) || (hdmi_data == hdmi_9d_s)) begin
        hdmi_hs_de_rcv <= 1'b0;
      end else if ((hdmi_data == hdmi_ab_s) || (hdmi_data == hdmi_80_s)) begin
        hdmi_hs_de_rcv <= 1'b1;
      end
      if (hdmi_data == hdmi_b6_s) begin
        hdmi_vs_de_rcv <= 1'b0;
      end else if (hdmi_data == hdmi_9d_s) begin
        hdmi_vs_de_rcv <= 1'b1;
      end
    end
  end
endmodule