module vga_c4_iface (
    input         wb_clk_i,
    input         wb_rst_i,
    input  [16:1] wbs_adr_i,
    input  [ 1:0] wbs_sel_i,
    input         wbs_we_i,
    input  [15:0] wbs_dat_i,
    output [15:0] wbs_dat_o,
    input         wbs_stb_i,
    output        wbs_ack_o,
    output     [17:1] wbm_adr_o,
    output     [ 1:0] wbm_sel_o,
    output            wbm_we_o,
    output     [15:0] wbm_dat_o,
    input      [15:0] wbm_dat_i,
    output reg        wbm_stb_o,
    input             wbm_ack_i
  );
  reg        plane_low;
  reg  [7:0] dat_low;
  wire       cont;
  assign wbs_ack_o = (plane_low & wbm_ack_i);
  assign wbm_adr_o = { 1'b0, wbs_adr_i[15:2], wbs_adr_i[1], plane_low };
  assign wbs_dat_o = { wbm_dat_i[7:0], dat_low };
  assign wbm_sel_o = 2'b01;
  assign wbm_dat_o = { 8'h0, plane_low ? wbs_dat_i[15:8] : wbs_dat_i[7:0] };
  assign wbm_we_o  = wbs_we_i & ((!plane_low & wbs_sel_i[0])
                                | (plane_low & wbs_sel_i[1]));
  assign cont = wbm_ack_i && wbs_stb_i;
  always @(posedge wb_clk_i)
    wbm_stb_o <= wb_rst_i ? 1'b0 : (wbm_stb_o ? ~wbs_ack_o : wbs_stb_i);
  always @(posedge wb_clk_i)
    plane_low <= wb_rst_i ? 1'b0 : (cont ? !plane_low : plane_low);
  always @(posedge wb_clk_i)
    dat_low <= wb_rst_i ? 8'h0
      : ((wbm_ack_i && wbm_stb_o && !plane_low) ? wbm_dat_i[7:0] : dat_low);
endmodule