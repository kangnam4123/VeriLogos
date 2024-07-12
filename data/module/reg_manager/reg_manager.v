module reg_manager(
	clk,
	cmd_wr, cmd_in,
	reply_out, reply_rdy, reply_ack, reply_end,
	reg_addr, reg_data, reg_wr
);
input	clk;
input	cmd_wr;
input	[7:0] cmd_in;
output	[7:0] reply_out;
output	reply_rdy;
input	reply_ack;
output	reply_end;
output	[15:0] reg_addr;
inout	[31:0] reg_data;
output	reg_wr;
reg	[15:0] addr;
reg	[31:0] data;
reg	[4:0] state;
reg	wants_wr;
initial state = 0;
always @(posedge clk)
case (state)
	0:	if (cmd_wr && cmd_in == 8'hAA)	
			state <= 1;
	1:	if (cmd_wr)			
		begin
			wants_wr <= cmd_in[0];
			state <= 2;
		end
	2:	if (cmd_wr)			
		begin
			addr[7:0] <= cmd_in;
			state <= 3;
		end
	3:	if (cmd_wr)			
		begin
			addr[15:8] <= cmd_in;
			state <= 4;
		end
	4:	if (cmd_wr)			
		begin
			data[7:0] <= cmd_in;
			state <= 5;
		end
	5:	if (cmd_wr)			
		begin
			data[15:8] <= cmd_in;
			state <= 6;
		end
	6:	if (cmd_wr)			
		begin
			data[23:16] <= cmd_in;
			state <= 7;
		end
	7:	if (cmd_wr)			
		begin
			data[31:24] <= cmd_in;
			state <= 8;
		end
	8:	state <= 9;
	9:	if (reply_ack)			
			state <= 10;
	10:	if (reply_ack)			
			state <= 11;
	11:	if (reply_ack)			
			state <= 12;
	12:	if (reply_ack)			
			state <= 0;
	default:
		state <= 0;
endcase
assign reg_addr = (state==8 || state==9 || state==10 || state==11 || state==12) ? addr : 16'hXX;
assign reg_data = (state==8) ? data : 32'hZZ;
assign reg_wr = (state==8) && wants_wr;
assign reply_out = (state==9)  ? reg_data[7:0] : 
		   (state==10) ? reg_data[15:8] :
		   (state==11) ? reg_data[23:16] :
		   (state==12) ? reg_data[31:24] : 8'hZZ;
assign reply_rdy = state==9 || state==10 || state==11 || state==12;
assign reply_end = state==12;
endmodule