module vga_clkgen (
	pclk_i, rst_i, pclk_o, dvi_pclk_p_o, dvi_pclk_m_o, pclk_ena_o
);
	input  pclk_i;       
	input  rst_i;        
	output pclk_o;       
	output dvi_pclk_p_o; 
	output dvi_pclk_m_o; 
	output pclk_ena_o;   
	reg dvi_pclk_p_o;
	reg dvi_pclk_m_o;
	always @(posedge pclk_i)
	  if (rst_i) begin
	    dvi_pclk_p_o <= #1 1'b0;
	    dvi_pclk_m_o <= #1 1'b0;
	  end else begin
	    dvi_pclk_p_o <= #1 ~dvi_pclk_p_o;
	    dvi_pclk_m_o <= #1 dvi_pclk_p_o;
	  end
`ifdef VGA_12BIT_DVI
	reg pclk_o, pclk_ena_o;
	always @(posedge pclk_i)
	  if (rst_i)
	    pclk_o <= #1 1'b0;
	  else
	    pclk_o <= #1 ~pclk_o;
	always @(posedge pclk_i)
	  if (rst_i)
	    pclk_ena_o <= #1 1'b1;
	  else
	    pclk_ena_o <= #1 ~pclk_ena_o;
`else
	assign pclk_o     = pclk_i;
	assign pclk_ena_o = 1'b1;
`endif
endmodule