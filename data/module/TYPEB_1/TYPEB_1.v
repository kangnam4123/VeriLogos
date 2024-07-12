module TYPEB_1
   (
      input CLK,
      input RESET_N,
      input CLKEN,
      input TDI,
      output TDO,
      input DATA_IN,
      input CAPTURE_DR
   );
   reg tdoInt;
   always @ (negedge CLK or negedge RESET_N)
   begin
      if (RESET_N== 1'b0)
         tdoInt <= #1 1'b0;
      else if (CLK == 1'b0)
         if (CLKEN==1'b1)
            if (CAPTURE_DR==1'b0)
               tdoInt <= #1 TDI;
            else
               tdoInt <= #1 DATA_IN;
   end
   assign TDO = tdoInt;
endmodule