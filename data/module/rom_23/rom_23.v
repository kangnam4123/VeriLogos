module rom_23
  #(parameter addr_width = 5,
    parameter b3_burst   = 0)
   (
    input 		       wb_clk,
    input 		       wb_rst,
    input [(addr_width+2)-1:2] wb_adr_i,
    input 		       wb_stb_i,
    input 		       wb_cyc_i,
    input [2:0] 	       wb_cti_i,
    input [1:0] 	       wb_bte_i,
    output reg [31:0] 	       wb_dat_o,
    output reg 		       wb_ack_o);
   reg [addr_width-1:0] 	    adr;
   always @ (posedge wb_clk or posedge wb_rst)
     if (wb_rst)
       wb_dat_o <= 32'h15000000;
     else
       case (adr)
	 0 : wb_dat_o <= 32'h18000000;
	 1 : wb_dat_o <= 32'hA8200000;
	 2 : wb_dat_o <= 32'hA8C00100;
	 3 : wb_dat_o <= 32'h44003000;
	 4 : wb_dat_o <= 32'h15000000;
	 default:
	   wb_dat_o <= 32'h00000000;
       endcase 
generate
if(b3_burst) begin : gen_b3_burst
   reg 				    wb_stb_i_r;
   reg 				    new_access_r;   
   reg 				    burst_r;
   wire burst      = wb_cyc_i & (!(wb_cti_i == 3'b000)) & (!(wb_cti_i == 3'b111));
   wire new_access = (wb_stb_i & !wb_stb_i_r);
   wire new_burst  = (burst & !burst_r);
   always @(posedge wb_clk) begin
     new_access_r <= new_access;
     burst_r      <= burst;
     wb_stb_i_r   <= wb_stb_i;
   end
   always @(posedge wb_clk)
     if (wb_rst)
       adr <= 0;
     else if (new_access)
       adr <= wb_adr_i[(addr_width+2)-1:2];
     else if (burst) begin
	if (wb_cti_i == 3'b010)
	  case (wb_bte_i)
	    2'b00: adr <= adr + 1;
	    2'b01: adr[1:0] <= adr[1:0] + 1;
	    2'b10: adr[2:0] <= adr[2:0] + 1;
	    2'b11: adr[3:0] <= adr[3:0] + 1;
	  endcase 
	else
	  adr <= wb_adr_i[(addr_width+2)-1:2];
     end 
   always @(posedge wb_clk)
     if (wb_rst)
       wb_ack_o <= 0;
     else if (wb_ack_o & (!burst | (wb_cti_i == 3'b111)))
       wb_ack_o <= 0;
     else if (wb_stb_i & ((!burst & !new_access & new_access_r) | (burst & burst_r)))
       wb_ack_o <= 1;
     else
       wb_ack_o <= 0;
     end else begin
	always @(wb_adr_i)
	  adr <= wb_adr_i;
	always @ (posedge wb_clk or posedge wb_rst)
	  if (wb_rst)
	    wb_ack_o <= 1'b0;
	  else
	    wb_ack_o <= wb_stb_i & wb_cyc_i & !wb_ack_o;
     end
endgenerate   
endmodule