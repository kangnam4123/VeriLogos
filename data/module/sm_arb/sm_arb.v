module sm_arb
  (
   input        mem_clk,
   input        hreset_n,
   input        crt_req,
   input        cpu_rd_req,
   input        cpu_wr_req,
   input        a_empty,
   input        b_empty,
   input        a_full_done,
   input        b_full_done,
   input        sync_crt_line_end,
   output reg   crt_gnt,   	   
   output reg   cpu_wr_gnt,	   
   output reg   cpu_rd_gnt
   );
  reg [2:0] current_state;
  reg [2:0] next_state;
  parameter arb_state0    = 3'd0,
	    arb_state2    = 3'd2,
	    arb_state3    = 3'd3,
	    arb_state4    = 3'd4,
	    arb_state5    = 3'd5,
	    arb_state6    = 3'd6;
  always @(posedge mem_clk or negedge hreset_n) begin
    if (!hreset_n) current_state <= arb_state0;
    else           current_state <= next_state;
  end
  always @* begin
    crt_gnt     = 1'b0;
    cpu_wr_gnt  = 1'b0;
    cpu_rd_gnt  = 1'b0;
    case (current_state) 
      arb_state0: begin
	if (crt_req)         next_state = arb_state2;
        else if (cpu_wr_req) next_state = arb_state3;
        else if (cpu_rd_req) next_state = arb_state4;
        else                 next_state = arb_state0;
      end	     
      arb_state2: begin
        if (a_empty)      next_state = arb_state5;
	else if (b_empty) next_state = arb_state6;
	else              next_state = arb_state0;
      end
      arb_state3: begin
	cpu_wr_gnt = 1'b1;
        if (~cpu_wr_req) next_state = arb_state0;
	else             next_state = arb_state3;
      end
      arb_state4: begin
	cpu_rd_gnt = 1'b1;
        if (~cpu_rd_req) next_state = arb_state0;
	else             next_state = arb_state4;
      end
      arb_state5: begin
        crt_gnt = 1'b1;
        if (a_full_done | sync_crt_line_end) next_state = arb_state0;
        else                                 next_state = arb_state5;
      end
      arb_state6: begin
        crt_gnt = 1'b1;
        if (b_full_done | sync_crt_line_end) next_state = arb_state0;
        else                                 next_state = arb_state6;
      end
    endcase               
  end     
endmodule