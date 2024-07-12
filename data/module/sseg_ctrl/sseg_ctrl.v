module sseg_ctrl
  #(
    parameter n_digits    = 8,
    parameter n_segs      = 8
    )
   (
    input                        clk_i,
    input                        rst_i,
    input                        async_rst_i,
    input                        enable_i,
    input  [15:0]                clk_div_i,
    input  [7:0]                 brightness_i,
    input  [n_digits*n_segs-1:0] segments_i,
    output [n_segs-1:0]          seg_o,
    output [n_digits-1:0]        seg_sel_o,
    output                       sync_o
    );
   reg [15:0] cnt_strobe_reg;
   wire strobe = (enable_i & cnt_strobe_reg == 16'b0);
   always @(posedge clk_i or posedge async_rst_i)
     if (async_rst_i)
       cnt_strobe_reg <= 16'b0;
     else if (rst_i | ~enable_i)
       cnt_strobe_reg <= 16'b0;
     else if (strobe)
       cnt_strobe_reg <= clk_div_i;
     else
       cnt_strobe_reg <= cnt_strobe_reg - 16'd1;
   reg [7:0] cnt_strobe_dig_reg;
   always @(posedge clk_i or posedge async_rst_i)
     if (async_rst_i)
       cnt_strobe_dig_reg <= 8'b0;
     else if (rst_i | ~enable_i)
       cnt_strobe_dig_reg <= 8'b0;
     else if (strobe)
       cnt_strobe_dig_reg <= cnt_strobe_dig_reg - 8'd1;
   wire strobe_dig = (strobe & cnt_strobe_dig_reg == 8'hff);
   reg pwm_reg;
   always @(posedge clk_i or posedge async_rst_i)
     if (async_rst_i)
       pwm_reg <= 1'b0;
     else if (rst_i | ~enable_i)
       pwm_reg <= 1'b0;
     else if (strobe)
       pwm_reg <= (cnt_strobe_dig_reg <= brightness_i);
   reg [4:0] cnt_strobe_frame_reg;
   always @(posedge clk_i or posedge async_rst_i)
     if (async_rst_i)
       cnt_strobe_frame_reg <= 5'b0;
     else if (rst_i | ~enable_i)
       cnt_strobe_frame_reg <= 5'b0;
     else if (strobe_dig &cnt_strobe_frame_reg == 5'b0)
       cnt_strobe_frame_reg <= n_digits - 1;
     else if (strobe_dig)
       cnt_strobe_frame_reg <= cnt_strobe_frame_reg - 5'd1;
   wire strobe_frame = (strobe_dig & cnt_strobe_frame_reg == 5'b0);
   wire [n_digits-1:0] seg_sel_reg_new;
   assign seg_sel_reg_new = {strobe_frame, seg_sel_reg[n_digits-1:1]};
   reg [n_digits-1:0] seg_sel_reg;
   always @(posedge clk_i or posedge async_rst_i)
     if (async_rst_i)
       seg_sel_reg <= 0;
     else if (rst_i | ~enable_i)
       seg_sel_reg <= 0;
     else if (strobe_dig)
       seg_sel_reg <= seg_sel_reg_new;
   assign seg_sel_o = seg_sel_reg; 
   integer i;
   reg [n_segs-1:0] seg_reg;
   always @(posedge clk_i or posedge async_rst_i)
     if (async_rst_i)
       seg_reg <= 0;
     else if (rst_i | ~enable_i)
       seg_reg <= 0;
     else if (strobe_dig)
       for (i = 0; i < n_digits; i = i + 1)
         if (seg_sel_reg_new[i])
           seg_reg <= segments_i[n_segs*(n_digits-i)-1 -: n_segs];
   assign seg_o = seg_reg & {n_segs{pwm_reg}};
   assign sync_o = strobe_frame;
endmodule