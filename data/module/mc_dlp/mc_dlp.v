module mc_dlp
  #(parameter           BYTES = 16)
  (
   input                reset_n,
   input                mclock,
   input                hst_clock,
   input                dlp_req,
   input [4:0]          dlp_wcnt,
   input [27:0]         dlp_org,
   input                dlp_gnt,
   input                dlp_push,
   output reg           dlp_mc_done,
   output reg           dlp_arb_req,
   output reg [4:0]     dlp_arb_wcnt,
   output reg [27:0]    dlp_arb_addr,
   output reg           dlp_ready
   );
  reg [27:0]    capt_org;
  reg [4:0]     capt_wcnt;
  reg           dlp_req_toggle;
  reg           req_sync_1, req_sync_2, req_sync_3;
  reg           dlp_gnt_toggle;
  reg           gnt_sync_1, gnt_sync_2, gnt_sync_3;
  reg [1:0]     request_count;
  reg [4:0]     dlp_count;
  localparam    DLP = 3'h1;
  always @ (posedge hst_clock or negedge reset_n) begin
    if(!reset_n) begin
      dlp_ready      <= 1'b1;
      dlp_req_toggle <= 1'b0;
      gnt_sync_1     <= 1'b0;
      gnt_sync_2     <= 1'b0;
      gnt_sync_3     <= 1'b0;
    end else begin
      if(dlp_req==1'b1) begin
        dlp_req_toggle <= ~dlp_req_toggle;
        capt_org  <= dlp_org;
        capt_wcnt <= dlp_wcnt;
        dlp_ready <= 1'b0;
      end 
      gnt_sync_1 <= dlp_gnt_toggle;
      gnt_sync_2 <= gnt_sync_1;
      gnt_sync_3 <= gnt_sync_2;
      if(gnt_sync_2 ^ gnt_sync_3) dlp_ready <= 1'b1;
    end 
  end 
  always @ (posedge mclock or negedge reset_n) begin
    if(!reset_n) begin
      dlp_arb_req    <= 1'b0;
      dlp_gnt_toggle <= 1'b0;
      req_sync_1     <= 1'b0;
      req_sync_2     <= 1'b0;
      req_sync_3     <= 1'b0;
      dlp_mc_done    <= 1'b0;
      dlp_arb_addr   <= 28'b0;
      dlp_arb_req    <= 1'b0;
      dlp_count      <= 5'b0;
    end else begin
      req_sync_1 <= dlp_req_toggle;
      req_sync_2 <= req_sync_1;
      req_sync_3 <= req_sync_2;
      if(req_sync_2 ^ req_sync_3) begin
        dlp_arb_addr <= capt_org;
        dlp_arb_req  <= 1'b1;
        dlp_arb_wcnt <= capt_wcnt;
      end 
      if(dlp_gnt==1'b1) begin
        dlp_arb_req <= 1'b0;
        dlp_gnt_toggle <= ~dlp_gnt_toggle;
      end 
      if (dlp_push && ~dlp_mc_done)
        	dlp_count <= dlp_count + 5'h1;
      else if(dlp_mc_done)
        	dlp_count <= 5'h0;
      if (dlp_push && ~dlp_mc_done) begin
        if (BYTES == 4)      dlp_mc_done <= &dlp_count;		
        else if (BYTES == 8) dlp_mc_done <= dlp_count[0];	
        else 		     dlp_mc_done <= (dlp_count == dlp_arb_wcnt);
      end 
      else dlp_mc_done <= 1'b0;
    end 
  end 
endmodule