module dma_engine_rr_arb (
            input [3:0]    dma_wr_mac,    
            input [15:0]   dma_pkt_avail, 
            input          dma_rd_request, 
            output reg [3:0] dma_rd_request_q,
            output [15:0]  dma_wr_mac_one_hot,
            output reg     dma_rd_request_q_vld,
            input          ctrl_done,
            input          dma_in_progress,
            input          xfer_is_rd,
            input          cnet_reprog,   
            input          reset,
            input          clk
         );
reg [3:0] pref_to_read;
reg [3:0] mac_search;
wire [15:0] mac_search_one_hot;
always @(posedge clk)
begin
   if (reset || cnet_reprog)
      pref_to_read <= 4'h0;
   else if (ctrl_done && xfer_is_rd)
      pref_to_read <= pref_to_read + 'h1;
   else if (dma_rd_request)
      pref_to_read <= dma_rd_request_q;
end
always @(posedge clk)
begin
   if (reset || cnet_reprog) begin
      dma_rd_request_q <= 4'hf;
      mac_search <= 4'hf;
      dma_rd_request_q_vld <= 1'b0;
   end
   else if (dma_rd_request && xfer_is_rd) begin
      dma_rd_request_q_vld <= 1'b0;
   end
   else if (ctrl_done && xfer_is_rd) begin
      dma_rd_request_q <= pref_to_read;
      mac_search <= pref_to_read;
      dma_rd_request_q_vld <= 1'b0;
   end
   else begin
      if (dma_rd_request_q != pref_to_read) begin
         if (mac_search == pref_to_read)
            mac_search <= dma_rd_request_q;
         else
            mac_search <= mac_search - 'h1;
         if (mac_search_one_hot & dma_pkt_avail) begin
            dma_rd_request_q <= mac_search;
            dma_rd_request_q_vld <= 1'b1;
         end
      end
   end
end
assign dma_wr_mac_one_hot = {dma_wr_mac == 4'h f,
                             dma_wr_mac == 4'h e,
                             dma_wr_mac == 4'h d,
                             dma_wr_mac == 4'h c,
                             dma_wr_mac == 4'h b,
                             dma_wr_mac == 4'h a,
                             dma_wr_mac == 4'h 9,
                             dma_wr_mac == 4'h 8,
                             dma_wr_mac == 4'h 7,
                             dma_wr_mac == 4'h 6,
                             dma_wr_mac == 4'h 5,
                             dma_wr_mac == 4'h 4,
                             dma_wr_mac == 4'h 3,
                             dma_wr_mac == 4'h 2,
                             dma_wr_mac == 4'h 1,
                             dma_wr_mac == 4'h 0};
assign mac_search_one_hot = {mac_search == 4'h f,
                             mac_search == 4'h e,
                             mac_search == 4'h d,
                             mac_search == 4'h c,
                             mac_search == 4'h b,
                             mac_search == 4'h a,
                             mac_search == 4'h 9,
                             mac_search == 4'h 8,
                             mac_search == 4'h 7,
                             mac_search == 4'h 6,
                             mac_search == 4'h 5,
                             mac_search == 4'h 4,
                             mac_search == 4'h 3,
                             mac_search == 4'h 2,
                             mac_search == 4'h 1,
                             mac_search == 4'h 0};
endmodule