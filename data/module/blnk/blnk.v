module blnk 
  (
   input		pixclk,
   input                reset,
   input                blankx, 
   input		misr_cntl,
   input		red_comp,
   input		grn_comp,
   input		blu_comp,
   input                vga_en,
   output reg		vsync,
   output		hsync,
   output reg		vsync_m1,
   output reg		misr_done,
   output		enable_crc,
   output reg		init_crc,
   output reg		lred_comp,
   output reg		lgrn_comp,
   output reg		lblu_comp,
   output reg		blankx4d,
   output reg		blankx6
   );
  reg 			blankx5,
			blankx1,
			blankx2, 
			blankx3,
			blankx4,
			blankx4a,
			blankx4b,
			blankx4c,
			enable_crc_i,
			misr_cntl1,
			misr_cntl2,
			vsync1;
  reg [11:0] 		pix_counter;
  assign 		enable_crc = enable_crc_i & blankx6;
  assign 		hsync   = !blankx;
  always @(posedge pixclk or negedge reset)
    if (!reset) begin
      lblu_comp <= 1'b0;
      lgrn_comp <= 1'b0;
      lred_comp <= 1'b0;
    end else if(!blankx5) begin 
      lblu_comp <= blu_comp;
      lgrn_comp <= grn_comp;
      lred_comp <= red_comp;
    end
  always @(posedge pixclk or  negedge reset) begin
    if (!reset) begin
      blankx1 <= 1'b0;
      blankx2 <= 1'b0;
      blankx3 <= 1'b0;
      blankx4 <= 1'b0;
      blankx4a <= 1'b0;
      blankx4b <= 1'b0;
      blankx4c <= 1'b0;
      blankx4d <= 1'b0;
      blankx5 <= 1'b0;
      blankx6 <= 1'b0;
      vsync1 <= 1'b0;
      misr_cntl1 <= 1'b0;
      misr_cntl2 <= 1'b0;
    end else begin
      misr_cntl1 <= misr_cntl;
      misr_cntl2 <= misr_cntl1;
      vsync1  <= vsync;
      blankx1 <= blankx;
      blankx2 <= blankx1;
      blankx3 <= blankx2;
      blankx4 <= blankx3;
      blankx4a <= blankx4;
      blankx4b <= blankx4a;
      blankx4c <= blankx4b;
      blankx4d <= (vga_en) ? blankx4c : blankx4; 
      blankx5 <= blankx4d;
      blankx6 <= blankx5;
    end
  end
  always @(posedge pixclk or negedge reset)
    if (!reset)            pix_counter <= 12'h0;
    else if (blankx  == 1) pix_counter <= 12'h0;  
    else                   pix_counter <= pix_counter + 12'b1; 
  always @(posedge pixclk or negedge reset) begin
    if (!reset) vsync<= 1'b0;
    else if (blankx == 1) vsync <= 1'b0;
    else if ((blankx == 0) & (pix_counter == 12'd2050)) vsync <= 1'b1;
  end
  always @(posedge pixclk or negedge reset) begin
    if (!reset) vsync_m1 <= 1'b0;
    else if (blankx == 1) vsync_m1 <= 1'b0;
    else if ((blankx == 0) & (pix_counter == 12'd2049))vsync_m1 <= 1'b1;
  end
  always @(posedge pixclk or negedge reset) begin
    if (!reset) init_crc <= 1'b0;
    else if (vsync1 & !vsync & misr_cntl2) init_crc <= 1'b1;
    else init_crc <= 1'b0;      
  end
  always @(posedge pixclk or negedge reset) begin
    if (!reset) enable_crc_i <= 1'b0;
    else if (init_crc) enable_crc_i <= 1'b1;
    else if (vsync & !vsync1) enable_crc_i <= 1'b0;
  end
  always @(posedge pixclk or negedge reset) begin
    if (!reset) misr_done <= 1'b0;
    else if (vsync1 & !vsync) misr_done <= 1'b0;
    else if (enable_crc_i & vsync & !vsync1) misr_done <= 1'b1;
  end
endmodule