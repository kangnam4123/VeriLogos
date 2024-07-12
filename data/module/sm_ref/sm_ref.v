module sm_ref
  (
   input      mem_clk,
   input      hreset_n,
   input      ref_gnt,
   input      svga_ack,
   input      c_cr11_b6,
   input      sync_c_crt_line_end,
   output     ref_svga_req,
   output     ref_req,   	 
   output     m_t_ref_n,
   output     ref_cycle_done
   );
  reg [2:0] current_state;
  reg [2:0] next_state;
  reg [2:0] rfsh_cnt_out;
  reg       ref_s1, ref_s2, ref_s3, ref_s4, ref_s5;
  wire      rfsh_done;
  wire      en_ref_inc;    
  assign    rfsh_done = (c_cr11_b6) ? (rfsh_cnt_out == 3'b101) :
					(rfsh_cnt_out == 3'b011);
  parameter ref_state0 = 3'b000,
            ref_state1 = 3'b001,
	    ref_state2 = 3'b100,
	    ref_state3 = 3'b010,
            ref_state4 = 3'b011,
	    ref_state5 = 3'b111;
  always @(posedge mem_clk or negedge hreset_n) begin
    if (!hreset_n) current_state <= ref_state0;
    else           current_state <= next_state;
  end
  always @* begin
    ref_s1    = 1'b0;
    ref_s2    = 1'b0;
    ref_s3    = 1'b0;
    ref_s4    = 1'b0;
    ref_s5    = 1'b0;
    case (current_state) 
      ref_state0: begin
	if (sync_c_crt_line_end) next_state = ref_state1;
	else                     next_state = ref_state0;
      end
      ref_state1: begin
        ref_s1 = 1'b1;
	if (ref_gnt) next_state = ref_state2;
	else         next_state = ref_state1;
      end
      ref_state2: begin
        ref_s2   = 1'b1;
        if (svga_ack) next_state = ref_state3;
	else          next_state = ref_state2;
      end
      ref_state3: begin
	ref_s3      = 1'b1;
	next_state = ref_state4;
      end
      ref_state4: begin
        ref_s4      = 1'b1;
        if (rfsh_done) next_state = ref_state5;
        else           next_state = ref_state2;
      end
      ref_state5: begin
	ref_s5    = 1'b1;
	next_state = ref_state0;
      end
    endcase               
  end     
  assign ref_req = ref_s1 & ~ref_gnt;
  assign ref_svga_req =   ref_s2;
  assign m_t_ref_n = ~ref_svga_req;     
  assign ref_cycle_done = ref_s5;
  assign en_ref_inc = ref_s3;
  always @ (posedge mem_clk or negedge hreset_n) begin
    if (~hreset_n)       rfsh_cnt_out <= 3'b000;
    else if (ref_s5)     rfsh_cnt_out <= 3'b000;
    else if (en_ref_inc) rfsh_cnt_out <= rfsh_cnt_out + 1'b1;
    else                 rfsh_cnt_out <= rfsh_cnt_out;
  end
endmodule