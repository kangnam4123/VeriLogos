module  crt_misc
  (
   input             dis_en_sta,
   input             c_raw_vsync,
   input             h_reset_n,
   input 	     h_hclk,
   input 	     color_mode,     
   input 	     h_io_16,        
   input 	     h_io_wr,        
   input [15:0]      h_addr,         
   input [5:0] 	     c_crtc_index,   
   input [7:0] 	     c_ext_index,    
   input             t_sense_n,      
   input             c_t_crt_int,    
   input             a_is01_b5,      
   input             a_is01_b4,      
   input             vsync_vde,      
   input [15:0]      h_io_dbus,
   output [7:0]      reg_ins0,
   output [7:0]      reg_ins1,
   output [7:0]      reg_fcr,   
   output reg [7:0]  reg_cr17,
   output            c_cr17_b0,
   output            c_cr17_b1,
   output            cr17_b2,
   output            cr17_b3,
   output            c_cr17_b5,
   output            c_cr17_b6,
   output            cr17_b7,
   output            vsync_sel_ctl
   );
  reg 		  str_fcr;   
  always @(posedge h_hclk or negedge h_reset_n)
    if (!h_reset_n) begin
      str_fcr  <= 1'b0;
      reg_cr17 <= 8'b0;
    end else if (h_io_wr) begin
      case (h_addr)
	16'h03b4: begin
	  if (!color_mode)
	    if (h_io_16) begin
	      case (c_crtc_index[5:0])
		6'h17: reg_cr17 <= {h_io_dbus[15:13], 1'b0, h_io_dbus[11:8]};
	      endcase 
	    end
	end
	16'h03b5: begin
	  if (!color_mode) begin
	    case (c_crtc_index[5:0])
	      6'h17: reg_cr17 <= {h_io_dbus[15:13], 1'b0, h_io_dbus[11:8]};
	    endcase 
	  end
	end
	16'h03ba: if (!color_mode) str_fcr <= h_io_dbus[3];
	16'h03d4: begin
	  if (color_mode)
	    if (h_io_16) begin
	      case (c_crtc_index[5:0])
		6'h17: reg_cr17 <= {h_io_dbus[15:13], 1'b0, h_io_dbus[11:8]};
	      endcase 
	    end
	end
	16'h03d5: begin
	  if (color_mode) begin
	    case (c_crtc_index[5:0])
	      6'h17: reg_cr17 <= {h_io_dbus[15:13], 1'b0, h_io_dbus[11:8]};
	    endcase 
	  end
	end
	16'h03da: if (color_mode) str_fcr <= h_io_dbus[3];
      endcase 
    end
  assign reg_fcr  = {4'b0, str_fcr, 3'b0};
  assign vsync_sel_ctl = str_fcr;
  assign reg_ins0 = {c_t_crt_int, 2'b00, t_sense_n, 4'b0000};
  assign reg_ins1 = {2'b00, a_is01_b5, a_is01_b4, c_raw_vsync, 
		     2'b00, dis_en_sta };
  assign c_cr17_b0 = reg_cr17[0];
  assign c_cr17_b1 = reg_cr17[1];
  assign cr17_b2   = reg_cr17[2];
  assign cr17_b3   = reg_cr17[3];
  assign c_cr17_b5 = reg_cr17[5];
  assign c_cr17_b6 = reg_cr17[6];
  assign cr17_b7   = reg_cr17[7];
endmodule