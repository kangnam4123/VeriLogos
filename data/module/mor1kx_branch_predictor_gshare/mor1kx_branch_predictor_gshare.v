module mor1kx_branch_predictor_gshare
  #(
    parameter GSHARE_BITS_NUM = 10,
    parameter OPTION_OPERAND_WIDTH = 32
    )
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
    input branch_mispredict_i,    
    input [OPTION_OPERAND_WIDTH-1:0]  brn_pc_i
    );
   localparam [1:0]
      STATE_STRONGLY_NOT_TAKEN = 2'b00,
      STATE_WEAKLY_NOT_TAKEN   = 2'b01,
      STATE_WEAKLY_TAKEN       = 2'b10,
      STATE_STRONGLY_TAKEN     = 2'b11;
   localparam FSM_NUM = 2 ** GSHARE_BITS_NUM;
   integer i = 0;
   reg [1:0] state [0:FSM_NUM];
   reg [GSHARE_BITS_NUM:0] brn_hist_reg = 0;
   reg [GSHARE_BITS_NUM - 1:0] prev_idx = 0;
   wire [GSHARE_BITS_NUM - 1:0] state_index = brn_hist_reg[GSHARE_BITS_NUM - 1:0] ^ brn_pc_i[GSHARE_BITS_NUM + 1:2];
   assign predicted_flag_o = (state[state_index][1] && op_bf_i) ||
                             (!state[state_index][1] && op_bnf_i);
   wire brn_taken = (execute_op_bf_i && flag_i) || (execute_op_bnf_i && !flag_i);
   always @(posedge clk) begin
      if (rst) begin
         brn_hist_reg <= 0;
         prev_idx <= 0;
         for(i = 0; i < FSM_NUM; i = i + 1) begin
            state[i] = STATE_WEAKLY_TAKEN;
         end
      end else begin
         if (op_bf_i || op_bnf_i) begin
            prev_idx <= state_index;
         end
         if (prev_op_brcond_i && padv_decode_i) begin
            brn_hist_reg <= {brn_hist_reg[GSHARE_BITS_NUM - 1 : 0], brn_taken};
            if (!brn_taken) begin
               case (state[prev_idx])
                  STATE_STRONGLY_TAKEN:
                     state[prev_idx] <= STATE_WEAKLY_TAKEN;
                  STATE_WEAKLY_TAKEN:
                     state[prev_idx] <= STATE_WEAKLY_NOT_TAKEN;
                  STATE_WEAKLY_NOT_TAKEN:
                     state[prev_idx] <= STATE_STRONGLY_NOT_TAKEN;
                  STATE_STRONGLY_NOT_TAKEN:
                     state[prev_idx] <= STATE_STRONGLY_NOT_TAKEN;
               endcase
            end else begin
               case (state[prev_idx])
                  STATE_STRONGLY_NOT_TAKEN:
                     state[prev_idx] <= STATE_WEAKLY_NOT_TAKEN;
                  STATE_WEAKLY_NOT_TAKEN:
                     state[prev_idx] <= STATE_WEAKLY_TAKEN;
                  STATE_WEAKLY_TAKEN:
                     state[prev_idx] <= STATE_STRONGLY_TAKEN;
                  STATE_STRONGLY_TAKEN:
                     state[prev_idx] <= STATE_STRONGLY_TAKEN;
               endcase
            end
         end
      end
   end
endmodule