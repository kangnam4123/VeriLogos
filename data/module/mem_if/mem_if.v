module mem_if
(
output reg rd_data,
output reg rd_complete,
output reg [5:0]A,
output CEN,
input [18:0]addr,
input [15:0]Q,
input clk_if,
input rst_for_new_package
);
wire clk_if_n;
reg d_1clk;
reg d_flag;
reg [3:0]d_cnt;
reg [5:0]A_cnt;
assign CEN = (addr == 19'h0)? 1'b1 : 1'b0;
assign clk_if_n = ~clk_if;
always@(posedge clk_if or negedge rst_for_new_package) begin
	if(~rst_for_new_package) rd_data <= 1'b0;
	else rd_data <= Q[d_cnt];
end
always@(*) begin
	if(~addr[18]) begin
		if(addr[15:8] == 8'b0000_0000) A = 6'h5 + A_cnt;
		else A = 6'h11 - {2'b0, addr[15:12]} + A_cnt;
	end
	else begin
		case(addr[17:16])
			2'b00 : A = addr[15:8] + A_cnt;
			2'b01 : A = addr[15:8] + 6'h4 + A_cnt;
			2'b10 : A = addr[15:8] + 6'h27 + A_cnt;
			2'b11 : A = 6'h29;
		endcase
	end
end
always@(posedge clk_if_n or negedge rst_for_new_package) begin
	if(~rst_for_new_package) A_cnt <= 6'h0;
	else if(d_cnt == 4'h0) A_cnt <= A_cnt + 6'h1;
end
always@(posedge clk_if or negedge rst_for_new_package) begin
	if(~rst_for_new_package) d_1clk <= 1'b0;
	else d_1clk <= 1'b1;
end
always@(posedge clk_if or negedge rst_for_new_package) begin
	if(~rst_for_new_package) d_flag <= 1'b0;
	else if(~addr[18] & addr[15:8] != 8'h0) d_flag <= 1'b1;
end
always@(posedge clk_if or negedge rst_for_new_package) begin
	if(~rst_for_new_package) d_cnt <= 4'hf;
	else begin
		if(~addr[18] & addr[15:8] != 8'h0 & ~d_flag) d_cnt <= addr[11:8];
		else if(d_1clk) d_cnt <= d_cnt - 4'h1;
	end
end
always@(posedge clk_if or negedge rst_for_new_package) begin
	if(~rst_for_new_package) rd_complete <= 1'b0;
	else begin
		if(~addr[18]) begin
			if(A == 6'h12) rd_complete <= 1'b1;
		end
		else begin
			if(addr[17:16] == 2'b00 & addr[7:0] == 8'h0 & addr[15:8] < 8'h4 & A == 6'h4) rd_complete <= 1'b1;
			else if(addr[17:16] == 2'b01 & addr[7:0] == 8'h0 & addr[15:8] < 8'he & A == 6'h12) rd_complete <= 1'b1;
			else if(addr[17:16] == 2'b01 & addr[7:0] == 8'h0 & addr[15:8] > 8'hd & addr[15:8] < 8'h23 & A == 6'h27) rd_complete <= 1'b1;
			else if(addr[17:16] == 2'b10 & addr[7:0] == 8'h0 & addr[15:8] < 8'h2 & A == 6'h29) rd_complete <= 1'b1;
			else if(addr[7:0] != 0 & A_cnt == addr[7:0]) rd_complete <= 1'b1;
		end
	end
end
endmodule