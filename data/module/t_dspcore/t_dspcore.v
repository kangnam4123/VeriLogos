module t_dspcore (
   out1_r, pla_ph1, pla_ph2,
   dsp_ph1, dsp_ph2, dsp_reset, clk_en
   );
   input dsp_ph1, dsp_ph2, dsp_reset;
   input clk_en;
   output out1_r, pla_ph1, pla_ph2;
   wire   dsp_ph1, dsp_ph2, dsp_reset;
   wire   pla_ph1, pla_ph2;
   reg 	  out1_r;
   always @(posedge dsp_ph1 or posedge dsp_reset) begin
      if (dsp_reset)
	out1_r <= 1'h0;
      else
	out1_r <= ~out1_r;
   end
   assign pla_ph1 = dsp_ph1;
   assign pla_ph2 = dsp_ph2 & clk_en;
endmodule