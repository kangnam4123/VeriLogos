module synth_reg_reg (i, ce, clr, clk, o);
   parameter width  = 8;
   parameter latency  = 1;
   input[width - 1:0] i;
   input ce, clr, clk;
   output[width - 1:0] o;
   wire[width - 1:0] o;
   genvar idx;
   reg[width - 1:0] reg_bank [latency:0];
   integer j;
   initial
     begin
	for (j=0; j < latency+1; j=j+1)
	  begin
	     reg_bank[j] = {width{1'b0}};
	  end
     end
   generate
     if (latency == 0)
        begin:has_0_latency
         assign o = i;
       end
   endgenerate
   always @(i)
	begin
	     reg_bank[0] = i;
	 end
   generate
     if (latency > 0)
        begin:more_than_1
	    assign o = reg_bank[latency];
         for (idx=0; idx < latency; idx=idx+1) begin:sync_loop
            always @(posedge clk)
                begin
                 if(clr)
                    begin
                          reg_bank[idx+1] = {width{1'b0}};
                    end
                 else if (ce)
                    begin
                        reg_bank[idx+1] <= reg_bank[idx] ;
                    end
               end
        end
      end
   endgenerate
endmodule