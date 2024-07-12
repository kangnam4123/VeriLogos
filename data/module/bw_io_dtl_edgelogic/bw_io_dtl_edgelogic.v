module bw_io_dtl_edgelogic (
  pad_up, pad_dn_l, pad_dn25_l, pad_clk_en_l, cmsi_clk_en_l, cmsi_l, se_buf, 
  bsr_up, bsr_dn_l, bsr_dn25_l, por, 
  data, oe, si, reset_l, sel_bypass, clk, bsr_mode, up_open, down_25, por_l, 
  se, bsr_data_to_core
  );
  input		data;
  input		oe;
  input		si;
  input		reset_l;
  input		sel_bypass;
  input		clk;
  input		bsr_mode;
  input		up_open;
  input		down_25;
  input		por_l;
  input		se;
  input		bsr_data_to_core;
  output	pad_up;
  output	pad_dn_l;
  output	pad_dn25_l;
  output	pad_clk_en_l;
  output	cmsi_clk_en_l;
  output	cmsi_l;
  output	se_buf;
  output	bsr_up;
  output	bsr_dn_l;
  output	bsr_dn25_l;
  output	por;
  reg cmsi_l;
  reg edgelogic_so;
  reg bypass_data;
  reg net223;
  reg pad_dn25_l;
  reg net229;
  reg pad_dn_l;
  reg net217;
  reg pad_up;
  wire s0 = bsr_mode && ~se;
  wire s2 = ~se && ~bsr_mode && ~reset_l;
  wire se_buf = se;
  wire die = ~se && reset_l;
  wire s3 = ~bsr_mode && die;
  wire pad_clk_en_l = sel_bypass || bsr_mode || ~die;
  wire cmsi_clk_en_l = ~(sel_bypass || bsr_mode || ~die);
  wire dn = data || ~oe;
  wire dn25 = ~down_25 || ~oe || data;
  wire up = oe ? data : ~up_open;
  wire por = ~por_l;
  wire bsr_up = pad_up;
  wire bsr_dn_l = pad_dn_l;
  wire bsr_dn25_l = pad_dn25_l;
  always @ (s3 or s2 or se_buf or s0 or bypass_data or edgelogic_so or bsr_data_to_core) begin
    casex ({s3, bypass_data, s2, 1'b0, se_buf, edgelogic_so, s0, bsr_data_to_core})
      8'b0x0x0x10: cmsi_l = 1'b1;
      8'b0x0x0x11: cmsi_l = 1'b0;
      8'b0x0x100x: cmsi_l = 1'b1;
      8'b0x0x110x: cmsi_l = 1'b0;
      8'b0x0x1010: cmsi_l = 1'b1;
      8'b0x0x1111: cmsi_l = 1'b0;
      8'b0x100x0x: cmsi_l = 1'b1;
      8'b0x110x0x: cmsi_l = 1'b0;
      8'b0x100x10: cmsi_l = 1'b1;
      8'b0x110x11: cmsi_l = 1'b0;
      8'b0x10100x: cmsi_l = 1'b1;
      8'b0x11110x: cmsi_l = 1'b0;
      8'b0x101010: cmsi_l = 1'b1;
      8'b0x111111: cmsi_l = 1'b0;
      8'b100x0x0x: cmsi_l = 1'b1;
      8'b110x0x0x: cmsi_l = 1'b0;
      8'b100x0x10: cmsi_l = 1'b1;
      8'b110x0x11: cmsi_l = 1'b0;
      8'b100x100x: cmsi_l = 1'b1;
      8'b110x110x: cmsi_l = 1'b0;
      8'b100x1010: cmsi_l = 1'b1;
      8'b110x1111: cmsi_l = 1'b0;
      8'b10100x0x: cmsi_l = 1'b1;
      8'b11110x0x: cmsi_l = 1'b0;
      8'b10100x10: cmsi_l = 1'b1;
      8'b11110x11: cmsi_l = 1'b0;
      8'b1010100x: cmsi_l = 1'b1;
      8'b1111110x: cmsi_l = 1'b0;
      8'b10101010: cmsi_l = 1'b1;
      8'b11111111: cmsi_l = 1'b0;
      default:     cmsi_l = 1'bx;
      endcase
    end
  always @(posedge clk) begin
    if (se_buf) 
      begin
      edgelogic_so <= net223;
      bypass_data  <= net223;
      end
    else
      begin
      edgelogic_so <= 1'b1;
      bypass_data <= data;
      end
    if (se_buf) 
      begin
      net223 <= net229;
      pad_dn25_l <= net229;
      end
    else
      begin
      net223 <= 1'b1;
      pad_dn25_l <= dn25;
      end  	
    if (se_buf) 
      begin
      net229 <= net217;
      pad_dn_l <= net217;
      end
    else
      begin
      net229 <= 1'b1;
      pad_dn_l <= dn;
      end  	
    if (se_buf) 
      begin
      net217 <= si; 
      pad_up <= si; 
      end
    else
      begin
      net217 <= 1'b1; 
      pad_up <= up;   
      end  	
    end
  endmodule