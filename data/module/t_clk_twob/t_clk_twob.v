module t_clk_twob (
   fastclk, reset_l
   );
   input fastclk;
   input reset_l;
   always @ (posedge fastclk) begin
      if (reset_l) ;
   end
endmodule