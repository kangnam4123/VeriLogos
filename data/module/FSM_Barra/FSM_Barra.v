module FSM_Barra(clock, reset, start_barra, busy_barra,actualizar_barra, revisar_bordes_barra);
	input clock, reset, start_barra;
	output busy_barra;
	output reg actualizar_barra, revisar_bordes_barra;
	reg [2:0] state;
	parameter STATE_0 = 0;
	parameter STATE_1 = 1;
	parameter STATE_2 = 2;
	parameter STATE_3 = 3;
	initial
		begin
			state <= STATE_0;
			actualizar_barra <= 1'b0;
			revisar_bordes_barra <= 1'b0;
		end
	always@(posedge clock or posedge reset)
	begin
		if(reset)
			begin
				state <= STATE_0;
				actualizar_barra <= 1'b0;
				revisar_bordes_barra <= 1'b0;
			end
		else
			begin
				case(state)
					STATE_0: 
						begin
							if (start_barra)
								begin
									state <= STATE_1;
								end
						end
					STATE_1: 
						begin
							actualizar_barra <= 1'b1;
							state <= STATE_2;
						end
					STATE_2: 
						begin
							actualizar_barra <= 1'b0;
							revisar_bordes_barra <= 1'b1;					
							state <= STATE_3;
						end
					STATE_3:
						begin
							revisar_bordes_barra <= 1'b0;
							state <= STATE_0;
						end
					default:
						begin
							state <= STATE_0;
						end
				endcase
			end
	end
	assign busy_barra = !(state == STATE_0);
endmodule