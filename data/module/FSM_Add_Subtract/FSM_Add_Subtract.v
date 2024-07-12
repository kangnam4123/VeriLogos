module FSM_Add_Subtract
	(
		input wire clk, 
		input wire rst, 
		input wire rst_FSM,
		input wire beg_FSM, 
		input wire zero_flag_i,
		input wire norm_iteration_i,
		input wire add_overflow_i,
		input wire round_i,
		output wire load_1_o,
		output wire load_2_o,
		output reg load_3_o, 
		output reg load_8_o,
		output reg A_S_op_o, 
		output reg load_4_o, 
		output reg left_right_o, 
		output reg bit_shift_o, 
		output reg load_5_o, 
		output reg load_6_o, 
		output reg load_7_o,
		output reg ctrl_a_o,
		output reg [1:0] ctrl_b_o,
		output reg ctrl_b_load_o,
		output reg ctrl_c_o,
		output reg ctrl_d_o,
		output reg rst_int,
		output reg ready
	 );
localparam [3:0] 
					 start = 4'd0, 
				     load_oper = 4'd1, 
					 zero_info_state = 4'd2, 
					 load_diff_exp = 4'd3, 
					 extra1_64= 4'd4,					
					 norm_sgf_first= 4'd5, 
					 add_subt = 4'd6, 
					 add_subt_r = 4'd7, 
					 overflow_add = 4'd8,
					 round_sgf = 4'd9, 
                      overflow_add_r = 4'd10,
                      extra2_64= 4'd11, 
                      norm_sgf_r = 4'd12, 
                      load_final_result  = 4'd13, 
                      ready_flag = 4'd14; 
reg [3:0] state_reg, state_next ; 
assign load_1_o= (state_reg==load_oper);
assign load_2_o= (state_reg==zero_info_state);
always @(posedge clk, posedge rst)
	if (rst) begin
		state_reg <= start;	
	end
	else begin
		state_reg <= state_next;
	end
always @*
	begin
	state_next = state_reg;
	rst_int = 0;
	load_3_o=0;
	load_8_o=0;
	A_S_op_o=1;
	load_4_o=0;
	left_right_o=0;
	bit_shift_o=0; 
	load_5_o=0;
	load_6_o=0;
	load_7_o=0;
	ctrl_a_o=0;
	ctrl_b_o=2'b00;
	ctrl_b_load_o=0;
	ctrl_c_o=0;
	ctrl_d_o=0;
	ready = 0;
	rst_int = 0;
	case(state_reg)
		start: begin
			rst_int=1;
			if(beg_FSM) begin
				state_next = load_oper;
			end
		end
		load_oper: 
		begin
			state_next = zero_info_state;
		end
		zero_info_state: 
		begin
			if (zero_flag_i)begin
				state_next = ready_flag;end
			else begin
				state_next = load_diff_exp;end
		end
		load_diff_exp: 
		begin
			load_3_o = 1;
			state_next = extra1_64;
		end
        extra1_64:
        begin
        load_3_o = 1;
            if (norm_iteration_i)begin
                load_8_o=1;
                if(add_overflow_i)begin
                    A_S_op_o=0;
                    left_right_o=0;
                    bit_shift_o=1;
                end
	            else begin
	                A_S_op_o=1;
	                left_right_o=1;
	                bit_shift_o=0;
                end
            end               
            state_next = norm_sgf_first;
        end
		norm_sgf_first: 
		begin
			load_4_o = 1;
			if (norm_iteration_i)begin
				if(add_overflow_i)begin
                    left_right_o=0;
                    bit_shift_o=1;
                    state_next = round_sgf;
                end
				else begin
					left_right_o=1;
					bit_shift_o=0;
					state_next = round_sgf;end
			end
			else 
				state_next = add_subt;
		end
		add_subt:
		begin
			load_5_o = 1;
			ctrl_c_o = 1;
			state_next = overflow_add;
		end
		overflow_add:
		begin
			load_6_o=1;
			ctrl_b_load_o=1;
            if ( add_overflow_i)begin
                ctrl_b_o=2'b10;
                end
            else begin
                A_S_op_o=1;
                ctrl_b_o=2'b01;
            end	
            state_next = extra1_64;
		end
		round_sgf:
		begin
			load_4_o = 0;
				if(round_i) begin
					ctrl_d_o =1;
					ctrl_a_o = 1;
					state_next = add_subt_r; end
				else begin
					state_next = load_final_result; end
		end
		add_subt_r:
		begin
			load_5_o = 1;
			state_next = overflow_add_r;
		end
		overflow_add_r:
		begin
            ctrl_b_load_o=1;	
			if ( add_overflow_i)begin
                ctrl_b_o=2'b10;
                end
            else begin
                ctrl_b_o=2'b11;
                end		
		    state_next = extra2_64;
		end
		extra2_64:
		begin
  			load_3_o = 1;
            load_8_o = 1;
			if ( add_overflow_i)begin
                A_S_op_o=0;
	            bit_shift_o=1;
            end
			state_next = norm_sgf_r;
        end
		norm_sgf_r:
		begin
			load_4_o = 1;
			if ( add_overflow_i)begin
                left_right_o=0;
                bit_shift_o=1;
            end
			state_next = load_final_result;
		end
		load_final_result:
		begin
			load_7_o = 1;
			state_next = ready_flag;
		end
		ready_flag:
		begin
			ready = 1;
				if(rst_FSM) begin
					state_next = start;end
		end
		default:
		begin
			state_next =start;end
	endcase
end
endmodule