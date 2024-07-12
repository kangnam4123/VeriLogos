module GameState (
	input rst, 
	input move ,
	input clk,
	input [3:0] nextMove, 
	input AISwitch,
	input [8:0] AIMove,
	input [8:0] AIMove_Hard,
	output wire [8:0] X_state,
	output wire [8:0] O_state,
	output wire [2:0] GameStatus,
	output wire [7:0] numWins
	);
	reg [8:0] X_pos;
	reg [8:0] tmp_X_pos;
	reg [8:0] O_pos;
	reg [8:0] tmp_O_pos = 9'b000000000;
	reg [2:0] game_stats = 0;
	reg [7:0] tmp_Score = 0;
	reg player;
	reg tmp_player;
	always @(*)
	begin
	if(move)
		begin
			if(player == 0) 
			begin
				case(nextMove)
					0: 
						if(((X_pos[8] | O_pos[8]) != 1) && tmp_X_pos[8] != 1) 
						begin
							tmp_O_pos = O_pos | 9'b100000000;
							tmp_player = ~player;
						end
					1: 
						if(((X_pos[7] | O_pos[7]) != 1) && (tmp_X_pos[7] != 1)) 
						begin
							tmp_O_pos = O_pos | 9'b010000000;
							tmp_player = ~player;
						end
					2: 
						if(((X_pos[6] | O_pos[6]) != 1) && (tmp_X_pos[6] != 1)) 
						begin
							tmp_O_pos = O_pos | 9'b001000000;
							tmp_player = ~player;
						end
					3: 
						if(((X_pos[5] | O_pos[5]) != 1) && (tmp_X_pos[5] != 1))
						begin
							tmp_O_pos = O_pos | 9'b000100000;
							tmp_player = ~player;
						end
					4: 
						if(((X_pos[4] | O_pos[4]) != 1) && (tmp_X_pos[4] != 1))
						begin
							tmp_O_pos = O_pos | 9'b000010000;
							tmp_player = ~player;
						end
					5: 
						if(((X_pos[3] | O_pos[3]) != 1) && (tmp_X_pos[3] != 1))
						begin
							tmp_O_pos = O_pos | 9'b000001000;
							tmp_player = ~player;
						end
					6: 
						if(((X_pos[2] | O_pos[2]) != 1) && (tmp_X_pos[2] != 1))
						begin
							tmp_O_pos = O_pos | 9'b000000100;
							tmp_player = ~player;
						end
					7: 
						if(((X_pos[1] | O_pos[1]) != 1) && (tmp_X_pos[1] != 1))
						begin
							tmp_O_pos = O_pos | 9'b000000010;
							tmp_player = ~player;
						end
					8: 
						if(((X_pos[0] | O_pos[0]) != 1) && (tmp_X_pos[0] != 1))
						begin
							tmp_O_pos = O_pos | 9'b000000001;
							tmp_player = ~player;
						end
					default: 
					;
				endcase
			end
		end
		else if(player == 1 && move == 0 && tmp_player == 1) 
			begin 
				if(AISwitch == 1'b0) begin
					tmp_X_pos = X_pos | AIMove;
					tmp_player = ~player;
				end
				else begin
					tmp_X_pos = X_pos | AIMove_Hard;
					tmp_player = ~player;
				end
			end
	end
	always @ (posedge clk or posedge rst)
	begin
		if (rst) begin
			game_stats <= 0; 
			player <= 1; 
			X_pos <= 9'b000000000;
			O_pos <= 9'b000000000;
		end
		else begin
			player <= tmp_player;
			X_pos <= tmp_X_pos;
			O_pos <= tmp_O_pos;
			if (move) begin 
				case(nextMove)
					0,1,2,3,4,5,6,7,8: 
					begin
						game_stats <= 0;
					end
					default: 
						game_stats <= 4;
				endcase
				if(game_stats == 0 && (O_pos == 9'b000_000_111 || O_pos == 9'b000_111_000 || O_pos == 9'b111_000_000 || 
					O_pos == 9'b100_100_100 || O_pos == 9'b010_010_010 || O_pos == 9'b001_001_001 || 
					O_pos == 9'b100_010_001 || O_pos == 9'b001_010_100)) 
				begin
						tmp_Score <= tmp_Score + 1;
						game_stats <= 2;
				end
				else if((O_pos | X_pos) == 9'b111_111_111)
						game_stats <= 3;
			end
			else  begin 
				if(game_stats == 0 && (X_pos == 9'b000_000_111 || X_pos == 9'b000_111_000 || X_pos == 9'b111_000_000 || 
					X_pos == 9'b100_100_100 || X_pos == 9'b010_010_010 || X_pos == 9'b001_001_001 || 
					X_pos == 9'b100_010_001 || X_pos == 9'b001_010_100)) 
				begin
					tmp_Score <= tmp_Score + 1;
					game_stats <= 1;
				end
				else if((O_pos | X_pos) == 9'b111_111_111)
					game_stats <= 3;
			end
		end
	end
	assign GameStatus = game_stats; 
	assign X_state = X_pos;
	assign O_state = O_pos;
	assign numWins = tmp_Score;
endmodule