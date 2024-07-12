module FSM_Semaforo(clk, reset, Sensor_Sync, WR, Prog_Sync, expire, WR_Reset, interval, start_timer, Rm, Ym, Gm, Rs, Ys, Gs, Walk);
	 input clk, Prog_Sync, WR, expire, Sensor_Sync, reset;
	 output WR_Reset, Rm, Ym, Gm, Rs, Ys, Gs, Walk, start_timer;
	 output reg [1:0] interval;
	 reg [3:0] state;
	 parameter STATE_0 = 0;
	 parameter STATE_1 = 1;
	 parameter STATE_2 = 2;
	 parameter STATE_3 = 3;
	 parameter STATE_4 = 4;
	 parameter STATE_5 = 5;
	 parameter STATE_6 = 6;
	 parameter STATE_7 = 7;
	 parameter STATE_8 = 8;
	 parameter STATE_9 = 9;
	 parameter STATE_10 = 10;
	 parameter STATE_11 = 11;
	 parameter STATE_12 = 12;
	 parameter STATE_13 = 13;
	 parameter STATE_14 = 14;
	 parameter STATE_15 = 15;
	 always@(posedge clk or posedge reset)
	 begin
		if (reset) 
			begin
				state <= STATE_0;
			end
		else if (Prog_Sync) 
			begin
				state <= STATE_0;
			end
		else
			begin
				case(state)
					STATE_0:
						begin
							interval <= 2'b00;
							state <= STATE_1;
						end
					STATE_1:
						begin
							interval <= 2'b00;
							if (expire & !Sensor_Sync)
									state <= STATE_2;
							else if (expire & Sensor_Sync) 
								state <= STATE_10;
							else 
								state <= STATE_1;
						end
					STATE_2:
						begin
							interval <= 2'b00;
							state <= STATE_3;
						end
					STATE_3:
						begin
							interval <= 2'b00;
							if (expire) 
								state <= STATE_4;
							else 
								state <= STATE_3;							
						end
					STATE_4:
						begin
							interval <= 2'b10;
							state <= STATE_5;
						end
					STATE_5:
						begin
							interval <= 2'b10;
							if (expire & WR) 
								state <= STATE_12;
							else if (expire & !WR) 
								state <= STATE_6;
							else 
								state <= STATE_5;
						end
					STATE_6:
						begin
							interval <= 2'b01;
							state <= STATE_7;
						end
					STATE_7:
						begin
							interval <= 2'b01;
							if (expire & Sensor_Sync) 
								state <= STATE_14;
							else if (expire & !Sensor_Sync) 
								state <= STATE_8;
							else 
								state <= STATE_7;
						end
					STATE_8:
						begin
							interval <= 2'b10;
							state <= STATE_9;
						end
					STATE_9:
						begin
							interval <= 2'b10;
							if (expire) 
								state <= STATE_0;
							else 
								state <= STATE_9;
						end
					STATE_10:
						begin
							interval <= 2'b01;
							state <= STATE_11;
						end
					STATE_11:
						begin
							interval <= 2'b01;
							if (expire) 
								state <= STATE_4;
							else 
								state <= STATE_11;
						end
					STATE_12:
						begin
							interval <= 2'b01;
							state <= STATE_13;
						end
					STATE_13:
						begin
							interval <= 2'b01;
							if (expire) 
								state <= STATE_6;
							else 
								state <= STATE_13;
						end
					STATE_14:
						begin
							interval <= 2'b01;
							state <= STATE_15;
						end
					STATE_15:
						begin
							interval <= 2'b01;
							if(expire) 
								state <= STATE_8;
							else 
								state <= STATE_15;
						end
					default: 
						begin
							state <= STATE_0;
							interval <= 2'b00;
						end
				endcase
			end
	 end
	assign start_timer = (state == STATE_1 || state == STATE_3 || state == STATE_5 || state == STATE_7 || state == STATE_9 || state == STATE_11 || state == STATE_13 || state == STATE_15);
	assign Rm = (state == STATE_7 || state == STATE_9 || state == STATE_13 || state == STATE_15);
	assign Ym = (state == STATE_5);
	assign Gm = (state == STATE_1 || state == STATE_3 || state == STATE_11);
	assign Rs = (state == STATE_1 || state == STATE_3 || state == STATE_5 || state == STATE_11 || state == STATE_13);
	assign Ys = (state == STATE_9);
	assign Gs = (state == STATE_7 || state == STATE_15);
	assign Walk = (state == STATE_13);
	assign WR_Reset = (state == STATE_12);
endmodule