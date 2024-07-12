module pll_drp_ram 
  (
   input 	 clk_a_i,
   input [4:0] 	 aa_i,
   input [39:0]  da_i,
   input 	 wea_i,
   input 	 clk_b_i,
   input [4:0] 	 ab_i,
   output reg [39:0] qb_o
   );
   reg [39:0] 	 ram [0:31];
   always@(posedge clk_a_i)
     if(wea_i)
       ram[aa_i] <= da_i;
   always@(posedge clk_b_i)
     qb_o <= ram[ab_i];
endmodule