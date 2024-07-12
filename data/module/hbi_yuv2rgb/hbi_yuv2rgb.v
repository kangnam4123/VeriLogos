module hbi_yuv2rgb
    (
     input              hb_clk,       
     input [31:0]	hbi_din,      
     input [2:0]	mw_dp_mode,   
     input [9:0]	lut_v0,       
     input [9:0]	lut_v1,       
     input [9:0]	lut_u0,       
     input [9:0]	lut_u1,       
     input		ycbcr_sel_n,  
     input              select,       
     output reg [31:0]	pci_data,
     output reg [7:0]	lut_u0_index, 
     output reg [7:0]	lut_v0_index 
     );
  reg [10:0] green_uv0;
  reg [10:0] red0, green0, blue0;
  reg [10:0] red1, green1, blue1;
  reg [7:0]  red0_pix, green0_pix, blue0_pix;
  reg [7:0]  red1_pix, green1_pix, blue1_pix;
  reg [31:0] hbi_del;
  reg [2:0]  mw_dp_mode_del;
  reg 	     select_del;
  wire [7:0] y0, y1, y2, y3;
  always @(posedge hb_clk) begin
    hbi_del        <= hbi_din;
    mw_dp_mode_del <= mw_dp_mode;
    select_del     <= select;
  end
  assign y0[7:0] = hbi_del[15:8];
  assign y1[7:0] = hbi_del[31:24];
  always @* begin
    if (ycbcr_sel_n) begin
      lut_u0_index = {~hbi_din[7],hbi_din[6:0]};
      lut_v0_index = {~hbi_din[23],hbi_din[22:16]};
    end else begin
      lut_u0_index = hbi_din[7:0];
      lut_v0_index = hbi_din[23:16];
    end 
  end 
  always @* begin
    green_uv0[10:0] = {lut_u1[9],lut_u1[9:0]} + {lut_v1[9],lut_v1[9:0]};
  end
  always @* begin
    red0[10:0]      = {y0[7:0],1'b1} + {lut_v0[9],lut_v0[9:0]};
    blue0[10:0]     = {y0[7:0],1'b1} + {lut_u0[9],lut_u0[9:0]};
    green0[10:0]    = {y0[7:0],1'b1} - {green_uv0[10],green_uv0[10:1]};
    case (red0[10:9])
      2'b00: 
	red0_pix = red0[8:1];
      2'b01: 
	red0_pix = 8'hff;
      2'b10, 2'b11: 
	red0_pix = 8'h0;
    endcase 
    case (green0[10:9])
      2'b00: 
	green0_pix = green0[8:1];
      2'b01: 
	green0_pix = 8'hff;
      2'b10, 2'b11: 
	green0_pix = 8'h0;
    endcase 
    case (blue0[10:9])
      2'b00: 
	blue0_pix = blue0[8:1];
      2'b01: 
	blue0_pix = 8'hff;
      2'b10, 2'b11: 
	blue0_pix = 8'h0;
    endcase 
  end 
  always @* begin
    red1[10:0]      = {y1[7:0],1'b1} + {lut_v0[9],lut_v0[9:0]};
    blue1[10:0]     = {y1[7:0],1'b1} + {lut_u0[9],lut_u0[9:0]};
    green1[10:0]    = {y1[7:0],1'b1} - {green_uv0[10],green_uv0[10:1]};
    case (red1[10:9])
      2'b00: 
	red1_pix = red1[8:1];
      2'b01: 
	red1_pix = 8'hff;
      2'b10, 2'b11: 
	red1_pix = 8'h0;
    endcase 
    case (green1[10:9])
      2'b00: 
	green1_pix = green1[8:1];
      2'b01: 
	green1_pix = 8'hff;
      2'b10, 2'b11: 
	green1_pix = 8'h0;
    endcase 
    case (blue1[10:9])
      2'b00: 
	blue1_pix = blue1[8:1];
      2'b01: 
	blue1_pix = 8'hff;
      2'b10, 2'b11: 
	blue1_pix = 8'h0;
    endcase 
  end 
  always @* begin
    casex ({mw_dp_mode_del, select_del}) 
      4'b001x: 
	pci_data = {1'b0,red1_pix[7:3],green1_pix[7:3],blue1_pix[7:3],
		    1'b0,red0_pix[7:3],green0_pix[7:3],blue0_pix[7:3]};
      4'b010x: 
	pci_data = {red1_pix[7:3],green1_pix[7:2],blue1_pix[7:3],
		    red0_pix[7:3],green0_pix[7:2],blue0_pix[7:3]};
      4'b0110: 
	pci_data = {8'h0, red0_pix, green0_pix, blue0_pix};
      4'b0111: 
	pci_data = {8'h0, red1_pix, green1_pix, blue1_pix};
      4'b100x: 
	pci_data = {2{1'b0,red0_pix[7:3],green0_pix[7:3],blue0_pix[7:3]}};
      4'b101x: 
	pci_data = {2{red0_pix[7:3],green0_pix[7:2],blue0_pix[7:3]}};
      4'b110x: 
	pci_data = {8'h0, red0_pix, green0_pix, blue0_pix};
      default:  
	pci_data = hbi_del;
    endcase 
  end 
endmodule