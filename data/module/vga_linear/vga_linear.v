module vga_linear (
    input clk,
    input rst,
    output [17:1] csr_adr_o,
    input  [15:0] csr_dat_i,
    output        csr_stb_o,
    input [9:0] h_count,
    input [9:0] v_count,
    input       horiz_sync_i,
    input       video_on_h_i,
    output      video_on_h_o,
    output [7:0] color,
    output       horiz_sync_o
  );
  reg [ 9:0] row_addr;
  reg [ 6:0] col_addr;
  reg [14:1] word_offset;
  reg [ 1:0] plane_addr;
  reg [ 1:0] plane_addr0;
  reg [ 7:0] color_l;
  reg [4:0] video_on_h;
  reg [4:0] horiz_sync;
  reg [5:0] pipe;
  reg [15:0] word_color;
  assign csr_adr_o = { word_offset, plane_addr, 1'b0 };
  assign csr_stb_o = pipe[1];
  assign color = pipe[4] ? csr_dat_i[7:0] : color_l;
  assign video_on_h_o = video_on_h[4];
  assign horiz_sync_o = horiz_sync[4];
  always @(posedge clk)
    pipe <= rst ? 6'b0 : { pipe[4:0], ~h_count[0] };
  always @(posedge clk)
    video_on_h <= rst ? 5'b0 : { video_on_h[3:0], video_on_h_i };
  always @(posedge clk)
    horiz_sync <= rst ? 5'b0 : { horiz_sync[3:0], horiz_sync_i };
  always @(posedge clk)
    if (rst)
      begin
        row_addr    <= 10'h0;
        col_addr    <= 7'h0;
        plane_addr0 <= 2'b00;
        word_offset <= 14'h0;
        plane_addr  <= 2'b00;
      end
    else
      begin
        row_addr    <= { v_count[8:1], 2'b00 } + v_count[8:1];
        col_addr    <= h_count[9:3];
        plane_addr0 <= h_count[2:1];
        word_offset <= { row_addr + col_addr[6:4], col_addr[3:0] };
        plane_addr  <= plane_addr0;
      end
  always @(posedge clk)
    color_l <= rst ? 8'h0 : (pipe[4] ? csr_dat_i[7:0] : color_l);
endmodule