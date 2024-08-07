module cf_spi (
  spi_cs0n,
  spi_cs1n,
  spi_clk,
  spi_sd_o,
  spi_sd_i,
  up_rstn,
  up_clk,
  up_spi_start,
  up_spi_devsel,
  up_spi_wdata_1,
  up_spi_wdata_0,
  up_spi_rdata,
  up_spi_status,
  debug_trigger,
  debug_data);
  output          spi_cs0n;
  output          spi_cs1n;
  output          spi_clk;
  output          spi_sd_o;
  input           spi_sd_i;
  input           up_rstn;
  input           up_clk;
  input           up_spi_start;
  input           up_spi_devsel;
  input   [31:0]  up_spi_wdata_1;
  input   [15:0]  up_spi_wdata_0;
  output  [ 7:0]  up_spi_rdata;
  output          up_spi_status;
  output  [ 7:0]  debug_trigger;
  output  [63:0]  debug_data;
  reg             spi_cs0n = 'd0;
  reg             spi_cs1n = 'd0;
  reg             spi_clk = 'd0;
  reg             spi_sd_o = 'd0;
  reg             spi_count_5_d = 'd0;
  reg     [ 2:0]  spi_clk_count = 'd0;
  reg     [ 5:0]  spi_count = 'd0;
  reg             spi_rwn = 'd0;
  reg     [31:0]  spi_data_out = 'd0;
  reg     [ 7:0]  spi_data_in = 'd0;
  reg             up_spi_start_d = 'd0;
  reg             up_spi_status = 'd0;
  reg     [ 7:0]  up_spi_rdata = 'd0;
  wire            spi_cs_en_s;
  wire    [31:0]  up_spi_wdata_s;
  assign debug_trigger[7] = spi_cs0n;
  assign debug_trigger[6] = spi_cs1n;
  assign debug_trigger[5] = spi_clk_count[2];
  assign debug_trigger[4] = spi_count[5];
  assign debug_trigger[3] = up_spi_devsel;
  assign debug_trigger[2] = up_spi_start;
  assign debug_trigger[1] = up_spi_start_d;
  assign debug_trigger[0] = up_spi_status;
  assign debug_data[63:56] = 'd0;
  assign debug_data[55:55] = spi_cs_en_s;
  assign debug_data[54:54] = spi_cs0n;
  assign debug_data[53:53] = spi_cs1n;
  assign debug_data[52:52] = spi_clk;
  assign debug_data[51:51] = spi_sd_o;
  assign debug_data[50:50] = spi_count_5_d;
  assign debug_data[49:47] = spi_clk_count;
  assign debug_data[46:41] = spi_count;
  assign debug_data[40:40] = spi_rwn;
  assign debug_data[39: 8] = spi_data_out;
  assign debug_data[ 7: 0] = spi_data_in;
  assign spi_cs_en_s = spi_count_5_d | spi_count[5];
  assign up_spi_wdata_s = (up_spi_devsel == 1) ? up_spi_wdata_1 : {up_spi_wdata_0, 16'd0};
  always @(negedge up_rstn or posedge up_clk) begin
    if (up_rstn == 0) begin
      spi_cs0n <= 'd1;
      spi_cs1n <= 'd1;
      spi_clk <= 'd0;
      spi_sd_o <= 'd0;
      spi_count_5_d <= 'd0;
      spi_clk_count <= 'd0;
      spi_count <= 'd0;
      spi_rwn <= 'd0;
      spi_data_out <= 'd0;
      spi_data_in <= 'd0;
      up_spi_start_d <= 'd0;
      up_spi_status <= 'd0;
      up_spi_rdata <= 'd0;
    end else begin
      spi_cs0n <= up_spi_devsel | (~spi_cs_en_s);
      spi_cs1n <= (~up_spi_devsel) | (~spi_cs_en_s);
      spi_clk <= spi_clk_count[2] & spi_count[5];
      if ((spi_count_5_d == 1'b0) || (spi_count[5] == 1'b1)) begin
        spi_sd_o <= spi_data_out[31];
      end
      if (spi_clk_count == 3'b100) begin
        spi_count_5_d <= spi_count[5];
      end
      spi_clk_count <= spi_clk_count + 1'b1;
      if (spi_count[5] == 1'b1) begin
        if (spi_clk_count == 3'b111) begin
          spi_count <= spi_count + 1'b1;
        end
        spi_rwn <= spi_rwn;
        if (spi_clk_count == 3'b111) begin
          spi_data_out <= {spi_data_out[30:0], 1'b0};
        end
        if ((spi_clk_count == 3'b100) && (spi_rwn == 1'b1) && (spi_count[3] == 1'b1)) begin
          spi_data_in <= {spi_data_in[6:0], spi_sd_i};
        end
      end else if ((spi_clk_count == 3'b111) && (up_spi_start == 1'b1) &&
        (up_spi_start_d == 1'b0)) begin
        spi_count <= (up_spi_devsel == 1'b1) ? 6'h20 : 6'h30;
        spi_rwn <= (~up_spi_devsel) & up_spi_wdata_s[31];
        spi_data_out <= up_spi_wdata_s;
        spi_data_in <= 8'd0;
      end
      if (spi_clk_count == 3'b111) begin
        up_spi_start_d <= up_spi_start;
      end
      up_spi_status <= ~(spi_count[5] | (up_spi_start & ~up_spi_start_d));
      up_spi_rdata <= spi_data_in;
    end
  end
endmodule