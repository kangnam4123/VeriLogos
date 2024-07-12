module vga_blank(input clk, output reg [11:0] pixel_count, line_count, output reg hsync, output wire vsync, output reg fb_reset, output wire fb_enable);
parameter HFRONT = 48;
parameter HSYNCP = 112;
parameter HBACK = 248;
parameter HLINE = 1688;
parameter VFRONT = 1;
parameter VSYNCP = 3;
parameter VBACK = 38;
parameter VFRAME = 1066;
assign vsync = (line_count >= VFRONT & line_count < (VFRONT + VSYNCP));
assign fb_enable = pixel_count >= (HFRONT + HSYNCP + HBACK) & line_count >= (VFRONT + VSYNCP + VBACK);
always @(posedge clk) begin
  pixel_count <= next_pixel_count;
  line_count <= next_line_count;
  fb_reset <= next_fb_reset;
  hsync <= (pixel_count >= HFRONT & pixel_count < (HFRONT + HSYNCP)); 
end 
reg [11:0] next_pixel_count, next_line_count;
reg next_fb_reset;
reg next_hsync;
always @(*) begin
  next_pixel_count = (pixel_count == (HLINE - 1)) ? 0 : pixel_count + 1;
  next_line_count = (pixel_count == (HLINE - 1)) ? ((line_count == (VFRAME - 1)) ? 0 : line_count + 1) : line_count;
  next_fb_reset = (pixel_count == 0) & (line_count == 0);
end
endmodule