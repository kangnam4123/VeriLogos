module dsi_sync_chain
  #( parameter length = 2)
   (
    input  clk_i,
    input  rst_n_i,
    input  d_i,
    output q_o );
   reg [length-1:0] sync;
   always@(posedge clk_i)
     begin
        sync[0] <= d_i;
        sync[length-1:1] <= sync[length-2:0];
     end
   assign q_o = sync[length-1];
endmodule