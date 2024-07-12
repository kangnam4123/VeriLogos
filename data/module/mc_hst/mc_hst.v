module mc_hst
  (
   input	    mclock,
   input	    reset_n,
   input	    hst_clock,
   input	    hst_gnt,       
   input [22:0]	    hst_org,       
   input	    hst_read,      
   input	    hst_req,       
   input	    rc_push_en,
   input	    rc_pop_en,     
   output reg [22:0] hst_arb_addr,  
   output reg	     hst_pop,       
   output reg	     hst_push,      
   output reg	     hst_rdy,       
   output reg [1:0]  hst_mw_addr,   
   output reg [1:0]  hst_arb_page,  
   output reg	     hst_arb_read,  
   output 	     hst_arb_req    
   );
  reg [22:0]	capt_addr[1:0];
  reg [1:0] 	capt_read;
  reg		input_select, output_select, capt_select;
  reg [1:0] 	req_sync_1, req_sync_2, req_sync_3;
  reg [1:0] 	hst_push_cnt;
  reg [1:0] 	busy;
  reg [1:0] 	clear_busy;
  reg [1:0] 	clear_busy0;
  reg [1:0] 	clear_busy1;
  reg [1:0] 	avail_mc;
  reg 		final_select;
  reg [1:0] 	hst_arb_req_int;
  assign hst_arb_req = |hst_arb_req_int;
  always @ (posedge hst_clock or negedge reset_n) begin
    if(!reset_n) begin
      input_select   <= 1'b0;
      hst_rdy        <= 1'b1;
      capt_addr[0]   <= 23'b0;
      capt_addr[1]   <= 23'b0;
      capt_read      <= 2'b0;
      busy           <= 2'b0;
      clear_busy0    <= 2'b0;
      clear_busy1    <= 2'b0;
    end else begin 
      clear_busy0 <= clear_busy;
      clear_busy1 <= clear_busy0;
      hst_rdy <= ~&busy;
      if (clear_busy1[0] ^ clear_busy0[0]) busy[0] <= 1'b0;
      if (clear_busy1[1] ^ clear_busy0[1]) busy[1] <= 1'b0;
      if (hst_req && ~&busy) begin
	input_select <= ~input_select;
	busy[input_select] <= 1'b1;
	capt_addr[input_select] <= hst_org;
	capt_read[input_select] <= hst_read;
	hst_rdy   <= 1'b0;
      end
    end 
  end 
  always @ (posedge mclock or negedge reset_n) begin
    if(!reset_n) begin
      hst_arb_req_int<= 1'b0;
      req_sync_1     <= 2'b0;
      req_sync_2     <= 2'b0;
      req_sync_3     <= 2'b0;
      avail_mc       <= 2'b0;
      capt_select    <= 1'b0;
      output_select   <= 1'b0;
      clear_busy      <= 2'b0;
      final_select    <= 1'b0;
    end else begin
      req_sync_1 <= busy;
      req_sync_2 <= req_sync_1;
      req_sync_3 <= req_sync_2;
      if (~req_sync_3[0] && req_sync_2[0]) avail_mc[0] <= 1'b1;
      if (~req_sync_3[1] && req_sync_2[1]) avail_mc[1] <= 1'b1;
      if (avail_mc[output_select]) begin
	output_select <= ~output_select;
	hst_arb_req_int[output_select] <= 1'b1;
	avail_mc[output_select] <= 1'b0;
      end 
      hst_arb_read <= capt_read[capt_select];
      hst_arb_page <= capt_read[capt_select] ? 2'h3 : 2'h1;
      hst_arb_addr <= capt_addr[capt_select];
      if(hst_gnt) begin
	capt_select <= ~capt_select;
	hst_arb_req_int[capt_select] <= 1'b0;
      end 
      if (&hst_push_cnt | hst_mw_addr[0]) begin
	clear_busy[final_select] <= ~clear_busy[final_select];
	final_select <= ~final_select;
      end
    end 
  end 
  always @ (posedge mclock or negedge reset_n) begin
    if(!reset_n) begin
      hst_push        <= 1'b0;
      hst_pop         <= 1'b0;
      hst_mw_addr     <= 2'b0;
      hst_push_cnt    <= 2'b0;
    end else begin
      if (rc_push_en) begin
	hst_push <= 1'b1;
	hst_push_cnt <= hst_push_cnt + 2'b1;
      end else hst_push <= 1'b0;
      if (rc_pop_en) begin
	hst_pop <= 1'b1;
	hst_mw_addr <= hst_mw_addr + 2'b1;
      end else hst_pop <= 1'b0;
    end 
  end 
endmodule