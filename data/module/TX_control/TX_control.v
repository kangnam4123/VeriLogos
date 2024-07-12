module TX_control
#(	parameter INTER_BYTE_DELAY = 1000000,   
	parameter WAIT_FOR_REGISTER_DELAY = 100 
)(
	input clock,
	input reset,
	input PB,                  
	input send16,              
	input [15:0] dataIn16,     
	output reg [7:0] tx_data,  
	output reg tx_start,       
	output reg busy            
    );
    reg [2:0]   next_state, state; 
    reg [15:0]  tx_data16;
    reg [31:0]  hold_state_timer;
    localparam IDLE 				= 3'd0;  
    localparam REGISTER_DATAIN16 	= 3'd1;  
    localparam SEND_BYTE_0 			= 3'd2;  
    localparam DELAY_BYTE_0 		= 3'd3;  
    localparam SEND_BYTE_1 			= 3'd4;  
    localparam DELAY_BYTE_1 		= 3'd5;	 
    always@(*) begin
        next_state = state;
		busy = 1'b1;
		tx_start = 1'b0;
		tx_data = tx_data16[7:0];
    	case (state)
    		IDLE: 	begin
						busy = 1'b0;
						if(PB) begin
							next_state=REGISTER_DATAIN16;
						end
					end
			REGISTER_DATAIN16:  begin
			                         if(hold_state_timer >= WAIT_FOR_REGISTER_DELAY)
				                        next_state=SEND_BYTE_0;				
					               end
            SEND_BYTE_0:	begin
								next_state = DELAY_BYTE_0;
								tx_start = 1'b1;
							end
            DELAY_BYTE_0: 	begin
								if(hold_state_timer >= INTER_BYTE_DELAY) begin
									if (send16)
										next_state = SEND_BYTE_1;
									else
										next_state = IDLE;
								end
							end
            SEND_BYTE_1: begin
                        tx_data = tx_data16[15:8];
						next_state = DELAY_BYTE_1;
						tx_start = 1'b1;
					end
			DELAY_BYTE_1: begin
						if(hold_state_timer >= INTER_BYTE_DELAY)
							next_state = IDLE;
					end	
    	endcase
    end	
    always@(posedge clock) begin
    	if(reset)
    		state <= IDLE;
    	else
    		state <= next_state;
	end
	always@ (posedge clock) begin
		if(state == REGISTER_DATAIN16)
			tx_data16 <= dataIn16;
	end
	always@(posedge clock) begin
    	if(state == DELAY_BYTE_0 || state == DELAY_BYTE_1 || state == REGISTER_DATAIN16) begin
    		hold_state_timer <= hold_state_timer + 1;
    	end else begin
    		hold_state_timer <= 0;
    	end
	end
endmodule