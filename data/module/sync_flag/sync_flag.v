module sync_flag(
	input rstn,
	input in_clk,
	input in_flag,
	input [DATA_WIDTH-1:0] in_data,
	output in_busy,
	input out_clk,
	output out_flag,
	output [DATA_WIDTH-1:0] out_data
);
parameter CLK_ASYNC = 1;
parameter DATA_WIDTH = 1;
parameter IN_HOLD = 0;
parameter OUT_HOLD = 0;
reg [DATA_WIDTH-1:0] out_data_hold = 'h0;
wire [DATA_WIDTH-1:0] out_data_s;
reg out_flag_d1 = 'h0;
wire out_flag_s;
generate if (CLK_ASYNC) begin
reg in_toggle = 1'b0;
reg [DATA_WIDTH-1:0] in_data_hold = 'h0;
always @(posedge in_clk)
begin
	if (rstn == 1'b0) begin
		in_toggle <= 1'b0;
	end else begin
		if (in_flag == 1'b1)
			in_toggle <= ~in_toggle;
	end
end
reg [2:0] out_toggle = 'h0;
assign out_flag_s = out_toggle[2] ^ out_toggle[1];
always @(posedge out_clk)
begin
	if (rstn == 1'b0) begin
		out_toggle <= 3'b0;
	end else begin
		out_toggle[0] <= in_toggle;
		out_toggle[2:1] <= out_toggle[1:0];
	end
end
reg [1:0] in_toggle_ret = 'h0;
assign in_busy = in_toggle ^ in_toggle_ret[1];
always @(posedge in_clk)
begin
	if (rstn == 1'b0) begin
		in_toggle_ret <= 2'b0;
	end else begin
		in_toggle_ret[0] <= out_toggle[2];
		in_toggle_ret[1] <= in_toggle_ret[0];
	end
end
always @(posedge in_clk)
begin
	if (rstn == 1'b0) begin
		in_data_hold <= 'h0;
	end else begin
		if (in_flag == 1'b1)
			in_data_hold <= in_data;
	end
end
assign out_data_s = IN_HOLD == 1'b1 ? in_data_hold : in_data;
end else begin
assign in_busy = 1'b0;
assign out_flag_s = in_flag;
assign out_data_s = in_data;
end endgenerate
always @(posedge out_clk)
begin
	if (rstn == 1'b0) begin
		out_data_hold <= 'h0;
		out_flag_d1 <= 'h0;
	end else begin
		if (out_flag_s == 1'b1)
			out_data_hold <= out_data_s;
		out_flag_d1 <= out_flag_s;
	end
end
assign out_data = OUT_HOLD == 1'b1 ? out_data_hold : out_data_s;
assign out_flag = OUT_HOLD == 1'b1 ? out_flag_d1 : out_flag_s;
endmodule