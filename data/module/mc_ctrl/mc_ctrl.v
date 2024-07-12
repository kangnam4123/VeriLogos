module mc_ctrl (
	clk		,
	rstn		,
	mc_start_i		,
	mc_done_o		,
  mvd_access_o    ,
	chroma_start_o		,
	chroma_sel_o		,
	chroma_done_i		,
	tq_start_o		,
	tq_sel_o		,
	tq_done_i		
);
input 	 [1-1:0] 	 clk 	         ; 
input 	 [1-1:0] 	 rstn 	         ; 
input 	 [1-1:0] 	 mc_start_i 	 ; 
output 	 [1-1:0] 	 mc_done_o 	 ; 
output             mvd_access_o ;
output 	 [1-1:0] 	 chroma_start_o  ; 
output 	 [1-1:0] 	 chroma_sel_o 	 ; 
input 	 [1-1:0] 	 chroma_done_i 	 ; 
output 	 [1-1:0] 	 tq_start_o 	 ; 
output 	 [2-1:0] 	 tq_sel_o 	 ; 
input 	 [1-1:0] 	 tq_done_i 	 ; 
parameter IDLE         = 3'd0;
parameter TQ_LUMA      = 3'd1;
parameter MC_CB        = 3'd2;
parameter TQ_CB        = 3'd3;
parameter MC_CR        = 3'd4;
parameter TQ_CR        = 3'd5;
parameter DONE         = 3'd6;
reg      [3-1:0]        current_state, next_state;
always @(*) begin
                next_state = IDLE;
    case(current_state) 
        IDLE : begin
            if ( mc_start_i)
                next_state = TQ_LUMA;
            else
                next_state = IDLE;
        end
        TQ_LUMA: begin
            if ( tq_done_i)
                next_state = MC_CB;
            else
                next_state = TQ_LUMA;
        end
        MC_CB: begin
            if ( chroma_done_i)
                next_state = TQ_CB;
            else
                next_state = MC_CB;
        end
        TQ_CB: begin
            if ( tq_done_i)
                next_state = MC_CR;
            else
                next_state = TQ_CB;
        end
        MC_CR: begin
            if ( chroma_done_i)
                next_state = TQ_CR;
            else
                next_state = MC_CR;
        end
        TQ_CR: begin
            if ( tq_done_i)
                next_state = DONE;
            else
                next_state = TQ_CR;
        end
        DONE: begin
            next_state = IDLE;
        end
    endcase
end
assign 	 mc_done_o 	 = (current_state == DONE); 
assign 	 chroma_start_o  = (current_state == TQ_LUMA && next_state == MC_CB)  ||
                           (current_state == TQ_CB   && next_state == MC_CR)  ; 
assign 	 chroma_sel_o 	 = (current_state == MC_CR) ? 1'b1 : 1'b0; 
assign 	 tq_start_o 	 = (current_state == IDLE    && next_state == TQ_LUMA)||
                           (current_state == MC_CB   && next_state == TQ_CB)  || 
                           (current_state == MC_CR   && next_state == TQ_CR)  ; 
assign 	 tq_sel_o 	 = (current_state == TQ_LUMA) ? 2'b00 :
                           (current_state == TQ_CB  ) ? 2'b10 :
                           (current_state == TQ_CR  ) ? 2'b11 : 2'b00;
assign mvd_access_o = ( current_state == TQ_LUMA );
always @ (posedge clk or negedge rstn) begin
    if(~rstn) begin
        current_state <= IDLE;
    end
    else begin
        current_state <= next_state;
    end
end
endmodule