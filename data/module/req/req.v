module req (p_clk, carb_rst_rnp, req_rp, len_rxp, deq_req, deq_len, deq_val);
   input p_clk; 
   input carb_rst_rnp; 
   input [4:0] len_rxp; 
   input       req_rp; 
   input       deq_req; 
   output [4:0] deq_len; 
   output 	deq_val; 
   reg [5:0] 	fifo_entry1_rp;
   reg [5:0] 	fifo_entry2_rp;
   reg [4:0] 	deq_len; 
   reg 		deq_val;
endmodule