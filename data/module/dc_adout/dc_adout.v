module dc_adout
    (
     input             pixclock,
     input             dcnreset,
     input             hnreset,
     input             vsync,
     input             cblank, 
     input             rsuppr,
     input [9:0]       ff_stp,
     input [9:0]       ff_rls,
     input [10:0]      ovtl_y, 
     input [10:0]      ovbr_y,
     input [1:0]       bpp,
     input [127:0]     crt_data,
     input [7:0]       vga_din,
     input             vga_en,
     output reg [23:0] datdc_out,
     output            pop
     );
  reg [3:0] counter;         
  reg [3:0] out_sel0, out_sel; 
  reg [3:0] inc;             
  reg 	    cblankd;         
  reg [11:0] lcount;          
  reg [9:0]  pcount;          
  reg 	     hdisbl;
  reg 	     vdisbl;
  reg [31:0] crt_dat;
  reg [7:0]   vga_store;      
  wire [11:0] ff_yrls;
  wire        active;         
  assign pop = cblank & (counter == 0);
  assign active = ~(hdisbl & vdisbl & cblank & rsuppr);
  always @(posedge pixclock or negedge hnreset )
    if(!hnreset) begin
      inc     <= 4'b0;
    end else if (active)
      casex (bpp)
	2'b01:   inc <= 4'h1; 
	2'b10:   inc <= 4'h2; 
	default: inc <= 4'h4; 
      endcase 
  always @(posedge pixclock or negedge hnreset )
    if(!hnreset) begin
      counter     <= 4'b0;
    end else if (!(vsync && cblank)) begin
      counter     <= 4'b0;
    end else if (active) begin
      counter     <= counter + inc;
    end
  always @(posedge pixclock or negedge hnreset )
    if(!hnreset) begin
      vga_store   <= 8'h0;
      datdc_out   <= 24'b0;
    end else begin
      vga_store <= vga_din;
      casex ({vga_en, bpp, out_sel[1:0]})
	5'b1_xx_xx: datdc_out <= {3{vga_store}};
	5'b0_01_00: datdc_out <= {3{crt_dat[7:0]}};
	5'b0_01_01: datdc_out <= {3{crt_dat[15:8]}};
	5'b0_01_10: datdc_out <= {3{crt_dat[23:16]}};
	5'b0_01_11: datdc_out <= {3{crt_dat[31:24]}};
	5'b0_10_0x: datdc_out <= {8'h0, crt_dat[15:0]};
	5'b0_10_1x: datdc_out <= {8'h0, crt_dat[31:16]};
	5'b0_00_xx, 6'b0_0_11_xx: datdc_out <= crt_dat[23:0];
      endcase 
    end
  always @(posedge pixclock or negedge hnreset )
    if(!hnreset) begin
      cblankd     <= 1'b0;
      lcount      <= 12'b0;
      pcount      <= 10'b0;
      hdisbl      <= 1'b0;
      vdisbl      <= 1'b0;
      out_sel0    <= 2'b0;
      out_sel     <= 2'b0;
    end else if(!dcnreset) begin
      cblankd     <= 1'b0;
      lcount      <= 12'b0;
      pcount      <= 10'b0;
      hdisbl      <= 1'b0;
      vdisbl      <= 1'b0;
      out_sel0    <= 2'b0;
      out_sel     <= 2'b0;
      crt_dat     <= 32'b0;
    end else begin
      out_sel0  <= counter;
      out_sel   <= out_sel0;
      case (out_sel0[3:2])
	2'd0: crt_dat <= crt_data[31:0];
	2'd1: crt_dat <= crt_data[63:32];
	2'd2: crt_dat <= crt_data[95:64];
	2'd3: crt_dat <= crt_data[127:96];
      endcase 
      cblankd     <= cblank;
      if (!(vsync & rsuppr))      lcount <= 12'b0;      
      else if (cblankd & ~cblank) lcount <= lcount + 12'h1; 
      if(!(vsync & cblank & rsuppr)) pcount <= 10'b0;   
      else if (pop)                  pcount <= pcount + 10'h1;
      if (pcount == ff_stp)                   
	hdisbl <= 1'b1;
      else if ((pcount == ff_rls) || !cblank) 
        hdisbl <= 1'b0;
      if (lcount == {1'b0,ovtl_y}) 
	vdisbl <= 1'b1;
      else if ((lcount == ff_yrls)|| !vsync)
	vdisbl <= 1'b0;
   end
  assign ff_yrls = ovbr_y +1'b1;
endmodule