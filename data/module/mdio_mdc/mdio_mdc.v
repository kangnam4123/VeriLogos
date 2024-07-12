module mdio_mdc(
 input reset,
 input clk,
 output  mdc,
 inout  mdio,
 input req_enb,
 input [1:0] req_op,   
 input [4:0] phy_addr,
 input [4:0] reg_addr,
 input [15:0] data_phy,
 output work_flag,
 output reg [15:0] data_sta,
 output sta_enb
);
wire turn_z_flag;
assign turn_z_flag = ((state==TA_STATE)&&(op_flag == 1'b0));
wire z_flag;
assign z_flag = ( (!work_flag)   ||   turn_z_flag   ||   rd_data_flag  ) ? 1'b1 : 1'b0;
assign mdc = clk;
assign mdio = (z_flag) ? 1'bz : mdio_out;  
wire mdio_in; 
assign mdio_in = mdio;
reg [2:0]  state;
reg [4:0]  count_bit;
parameter 	IDLE_STATE=3'd0,
			PRE_STATE=3'd1,
			ST_STATE=3'd2,
			OP_STATE=3'd3,
			PHYAD_STATE=3'd4,
			REGAD_STATE=3'd5,
			TA_STATE=3'd6,
			DATA_STATE=3'd7;			
wire state_jump_flag;
wire req_coming_flag;
wire count_over_flag;
assign req_coming_flag = (state == IDLE_STATE) && (req_enb == 1);
assign count_over_flag = (state != IDLE_STATE) && (count_bit==0);
assign state_jump_flag = req_coming_flag || count_over_flag;
always @(posedge clk or negedge reset) begin
	if(!reset) begin
		count_bit<=0;
		state<=IDLE_STATE;
	end
	else begin	
		if(count_bit!= 5'd0) begin
			count_bit <= count_bit-5'd1;
		end
		else begin
			count_bit <= count_bit;
		end
		if(state_jump_flag == 1'b1) begin
			case(state)
				IDLE_STATE: begin 
					count_bit<=5'd7;
					state<=PRE_STATE;
				end
				PRE_STATE: begin
					count_bit<=5'd1;
					state<=ST_STATE;
				end
				ST_STATE: begin
					count_bit<=5'd1;
					state<=OP_STATE;
				end
				OP_STATE: begin
					count_bit<=5'd4;
					state<=PHYAD_STATE;
				end
				PHYAD_STATE: begin
					count_bit<=5'd4;
					state<=REGAD_STATE;
				end
				REGAD_STATE: begin
					count_bit<=5'd1;
					state<=TA_STATE;
				end
				TA_STATE: begin
					count_bit<=5'd15;
					state<=DATA_STATE;
				end
				DATA_STATE: begin
					count_bit<=5'd0;
					state<=IDLE_STATE;
				end
				default: begin
					count_bit<=5'd0;
					state<=IDLE_STATE;
				end
			endcase
		end
		else begin
			state <= state;
		end
	end
end
reg [39:0] shift_reg;
reg op_flag;
wire mdio_out;
assign mdio_out = shift_reg[39];
assign work_flag = (state != IDLE_STATE);
always @(posedge clk or negedge reset) begin
	if(!reset) begin
		op_flag <= 1'b0;
		shift_reg <= 40'b0;
	end
 	else begin
		if(req_coming_flag == 1'b1) begin 
			op_flag <= req_op[0];
			shift_reg <= {8'hff,2'b01,req_op,phy_addr,reg_addr,2'b10,data_phy};
		end
		else if(work_flag) begin
			op_flag <= op_flag;
			shift_reg <= {shift_reg[38:0],1'b0};
		end
		else begin
			op_flag <= 1'b0;
			shift_reg <= 40'b0;
		end
	end
end
wire rd_data_flag;
reg rd_data_flag_r;
assign rd_data_flag = (state==DATA_STATE) && (op_flag== 1'b0);
always @(posedge clk or negedge reset) begin
	if(!reset) begin
		rd_data_flag_r <= 1'b0;
	end
	else begin
		rd_data_flag_r <= rd_data_flag;
	end
end
assign sta_enb = (~rd_data_flag) & rd_data_flag_r;
always @(posedge clk or negedge reset) begin
	if(!reset) begin
		data_sta<=16'd0;
	end
	else begin
		if(rd_data_flag == 1'b1) begin
			data_sta<={data_sta[14:0],mdio_in};
		end
		else begin
			data_sta<=data_sta;
		end
	end
end
endmodule