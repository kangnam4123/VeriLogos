module fsm_2(input clock, input reset, input pad_touched, output reg play);
		parameter STATE_0 = 0;
		parameter STATE_1 = 1;
		parameter STATE_2 = 2;
		parameter STATE_3 = 3;
		reg [2:0] state;
		initial
			begin	
				state <= 0;
				play <= 1'b0;
			end
		always@(posedge clock or posedge reset)
		begin
			if(reset)
				begin
					state <= STATE_0;
					play <= 1'b0;
				end
			else
				begin
					case(state)
						STATE_0:
							begin
								if(pad_touched)
									state <= STATE_1;
								else
									state <= STATE_0;
							end
						STATE_1:
							begin
								play <= 1'b1;
								state <= STATE_2;
							end
						STATE_2: 
							begin
								if(pad_touched)
									state <= STATE_2;
								else
									state <= STATE_3;
							end
						STATE_3:
							begin
								play <= 1'b0;
								state <= STATE_0;
							end
						default:
							begin
								state <= STATE_0;
							end
					endcase					
				end 
		end 
endmodule