module cmd_buf
(
output reg [7:0]cmd,
output [51:0]param,
output package_complete,
output en_crc5,
output en_crc16,
input clk_cmd,
input rst_for_new_package,
input bits_in,
input sync
);
parameter QueryRep		= 8'b0000_1100;
parameter ACK			= 8'b0000_1101;
parameter Query			= 8'b0011_1000;
parameter QueryAdjust		= 8'b0011_1001;
parameter Select		= 8'b0011_1010;
parameter NAK			= 8'b1100_0000;
parameter Req_RN		= 8'b1100_0001;
parameter Read			= 8'b1100_0010;
parameter Kill			= 8'b1100_0100;
parameter Lock			= 8'b1100_0101;
reg cmd_complete;
reg [52:0]param_tmp;
assign param = param_tmp[51:0];
assign en_crc5 = (cmd_complete & cmd != Query)? 1'b0 : 1'b1;
assign en_crc16 = (cmd_complete & cmd != Select & cmd != Req_RN & cmd != Read & cmd != Kill & cmd != Lock)? 1'b0 : 1'b1;
assign package_complete = (cmd == QueryRep & param_tmp[2])? 1'b1 :
						  (cmd == ACK & param_tmp[16])? 1'b1 :
						  (cmd == Query & param_tmp[18])? 1'b1 :
						  (cmd == QueryAdjust & param_tmp[5])? 1'b1 :
						  (cmd == Select & param_tmp[52])? 1'b1 :
						  (cmd == NAK)? 1'b1 :
						  (cmd == Req_RN & param_tmp[32])? 1'b1 :
						  (cmd == Read & param_tmp[50])? 1'b1 :
						  (cmd == Kill & param_tmp[51])? 1'b1 :
						  (cmd == Lock & param_tmp[52])? 1'b1 : 1'b0;
always@(*) begin
	if(cmd == QueryRep | cmd == ACK | cmd == Query |
	   cmd == QueryAdjust | cmd == Select | cmd == NAK |
	   cmd == Req_RN | cmd == Read | cmd == Kill | cmd == Lock) cmd_complete = 1'b1;
	else cmd_complete = 1'b0;
end
always@(posedge clk_cmd or negedge rst_for_new_package) begin
	if(~rst_for_new_package) cmd <= 8'b0000_0011;
	else begin
		if(sync & ~cmd_complete) cmd <= {cmd[6:0], bits_in};
	end
end
always@(posedge clk_cmd or negedge rst_for_new_package) begin
	if(~rst_for_new_package) param_tmp <= 53'b1;
	else begin
		if(cmd_complete & ~package_complete) param_tmp <= {param_tmp[51:0], bits_in};
	end
end
endmodule