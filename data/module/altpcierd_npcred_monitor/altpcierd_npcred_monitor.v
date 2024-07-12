module altpcierd_npcred_monitor  # (
    parameter  CRED_LAT = 10   
) ( 
   input             clk_in, 
   input             rstn,   
   input [2:0]       np_cred,        
   input             np_sent,        
   input             np_tx_sent,     
   output reg        have_cred       
   );
   localparam  LATCH_CRED      = 2'h0;
   localparam  GRANT_CRED      = 2'h1;
   localparam  WAIT_LAST_NP_TX = 2'h2;
   localparam  WAIT_CRED_UPD   = 2'h3;
   reg[2:0]  cred_sm;
   reg[2:0]  local_creds_avail;
   reg[7:0]  creds_granted; 
   reg[7:0]  latency_counter;
   reg[7:0]  creds_sent_on_tx;      
   wire      update_creds;
   assign update_creds = (cred_sm==LATCH_CRED) & (np_cred > 0);
   always @ (negedge rstn or posedge clk_in) begin
      if (rstn==1'b0) begin  
          cred_sm <= LATCH_CRED;
          local_creds_avail <= 3'h0;
          creds_sent_on_tx <= 8'h0;
          creds_granted <= 8'h0;
      end
      else begin    
          if (update_creds) begin
              creds_sent_on_tx <= 8'h0;
          end
          else if (np_tx_sent) begin
              creds_sent_on_tx <= creds_sent_on_tx + 8'h1;
          end
          case (cred_sm)
              LATCH_CRED: begin
                  latency_counter     <= 8'h0;
                  local_creds_avail   <= np_cred;  
                  creds_granted       <= np_cred;
                  if (np_cred > 0) begin
                      cred_sm   <= GRANT_CRED;
                      have_cred <= 1'b1; 
                  end 
                  else begin
                      cred_sm   <= cred_sm;
                      have_cred <= 1'b0; 
                  end
              end
              GRANT_CRED: begin
                  local_creds_avail <= np_sent ? local_creds_avail-3'h1 : local_creds_avail; 
                  have_cred <= (local_creds_avail==3'h1) & np_sent ? 1'b0 : 1'b1;
                  if ((local_creds_avail==3'h1) & np_sent) begin
                      cred_sm   <= WAIT_LAST_NP_TX; 
                  end
                  else begin
                      cred_sm <= cred_sm;
                  end
              end
              WAIT_LAST_NP_TX: begin
                  if (creds_sent_on_tx == creds_granted) begin
                      cred_sm <= WAIT_CRED_UPD;
                  end
                  else begin
                      cred_sm <= cred_sm;
                  end
              end
              WAIT_CRED_UPD: begin
                  latency_counter <= latency_counter + 8'h1;
                  if (latency_counter==CRED_LAT) begin
                      cred_sm <= LATCH_CRED;
                  end
                  else begin
                      cred_sm <= cred_sm;
                  end
              end
          endcase 
      end
   end
endmodule