module mor1kx_branch_predictor_saturation_counter
   (
    input clk,
    input rst,
    output predicted_flag_o,     
    input execute_op_bf_i,       
    input execute_op_bnf_i,      
    input op_bf_i,               
    input op_bnf_i,              
    input padv_decode_i,         
    input flag_i,                
    input prev_op_brcond_i,      
    input branch_mispredict_i    
    );
   localparam [1:0]
      STATE_STRONGLY_NOT_TAKEN = 2'b00,
      STATE_WEAKLY_NOT_TAKEN   = 2'b01,
      STATE_WEAKLY_TAKEN       = 2'b10,
      STATE_STRONGLY_TAKEN     = 2'b11;
   reg [1:0] state = STATE_WEAKLY_TAKEN;
   assign predicted_flag_o = (state[1] && op_bf_i) || (!state[1] && op_bnf_i);
   wire brn_taken = (execute_op_bf_i && flag_i) || (execute_op_bnf_i && !flag_i);
   always @(posedge clk) begin
      if (rst) begin
         state <= STATE_WEAKLY_TAKEN;
      end else begin
         if (prev_op_brcond_i && padv_decode_i) begin
            if (!brn_taken) begin
               case (state)
                  STATE_STRONGLY_TAKEN:
                     state <= STATE_WEAKLY_TAKEN;
                  STATE_WEAKLY_TAKEN:
                     state <= STATE_WEAKLY_TAKEN;
                  STATE_WEAKLY_TAKEN:
                     state <= STATE_STRONGLY_NOT_TAKEN;
                  STATE_STRONGLY_NOT_TAKEN:
                     state <= STATE_STRONGLY_NOT_TAKEN;
               endcase
            end else begin
               case (state)
                  STATE_STRONGLY_NOT_TAKEN:
                     state <= STATE_WEAKLY_NOT_TAKEN;
                  STATE_WEAKLY_NOT_TAKEN:
                     state <= STATE_WEAKLY_TAKEN;
                  STATE_WEAKLY_TAKEN:
                     state <= STATE_STRONGLY_TAKEN;
                  STATE_STRONGLY_TAKEN:
                     state <= STATE_STRONGLY_TAKEN;
               endcase
            end
         end
      end
   end
endmodule