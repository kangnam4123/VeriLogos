module fmlarb_1 #(
	parameter fml_depth = 26
) (
	input sys_clk,
	input sys_rst,
	input [fml_depth-1:0] m0_adr,
	input m0_stb,
	input m0_we,
	output m0_ack,
	input [7:0] m0_sel,
	input [63:0] m0_di,
	output [63:0] m0_do,
	input [fml_depth-1:0] m1_adr,
	input m1_stb,
	input m1_we,
	output m1_ack,
	input [7:0] m1_sel,
	input [63:0] m1_di,
	output [63:0] m1_do,
	input [fml_depth-1:0] m2_adr,
	input m2_stb,
	input m2_we,
	output m2_ack,
	input [7:0] m2_sel,
	input [63:0] m2_di,
	output [63:0] m2_do,
	input [fml_depth-1:0] m3_adr,
	input m3_stb,
	input m3_we,
	output m3_ack,
	input [7:0] m3_sel,
	input [63:0] m3_di,
	output [63:0] m3_do,
	input [fml_depth-1:0] m4_adr,
	input m4_stb,
	input m4_we,
	output m4_ack,
	input [7:0] m4_sel,
	input [63:0] m4_di,
	output [63:0] m4_do,
	output reg [fml_depth-1:0] s_adr,
	output reg s_stb,
	output reg s_we,
	input s_ack,
	output reg [7:0] s_sel,
	input [63:0] s_di,
	output reg [63:0] s_do
);
assign m0_do = s_di;
assign m1_do = s_di;
assign m2_do = s_di;
assign m3_do = s_di;
assign m4_do = s_di;
reg [2:0] master;
reg [2:0] next_master;
always @(posedge sys_clk) begin
	if(sys_rst)
		master <= 3'd0;
	else
		master <= next_master;
end
always @(*) begin
	next_master = master;
	case(master)
		3'd0: if(~m0_stb | s_ack) begin
			if(m1_stb) next_master = 3'd1;
			else if(m2_stb) next_master = 3'd2;
			else if(m3_stb) next_master = 3'd3;
			else if(m4_stb) next_master = 3'd4;
		end
		3'd1: if(~m1_stb | s_ack) begin
			if(m0_stb) next_master = 3'd0;
			else if(m3_stb) next_master = 3'd3;
			else if(m4_stb) next_master = 3'd4;
			else if(m2_stb) next_master = 3'd2;
		end
		3'd2: if(~m2_stb | s_ack) begin
			if(m0_stb) next_master = 3'd0;
			else if(m3_stb) next_master = 3'd3;
			else if(m4_stb) next_master = 3'd4;
			else if(m1_stb) next_master = 3'd1;
		end
		3'd3: if(~m3_stb | s_ack) begin
			if(m0_stb) next_master = 3'd0;
			else if(m4_stb) next_master = 3'd4;
			else if(m1_stb) next_master = 3'd1;
			else if(m2_stb) next_master = 3'd2;
		end
		default: if(~m4_stb | s_ack) begin 
			if(m0_stb) next_master = 3'd0;
			else if(m1_stb) next_master = 3'd1;
			else if(m2_stb) next_master = 3'd2;
			else if(m3_stb) next_master = 3'd3;
		end
	endcase
end
assign m0_ack = (master == 3'd0) & s_ack;
assign m1_ack = (master == 3'd1) & s_ack;
assign m2_ack = (master == 3'd2) & s_ack;
assign m3_ack = (master == 3'd3) & s_ack;
assign m4_ack = (master == 3'd4) & s_ack;
always @(*) begin
	case(master)
		3'd0: begin
			s_adr = m0_adr;
			s_stb = m0_stb;
			s_we = m0_we;
		end
		3'd1: begin
			s_adr = m1_adr;
			s_stb = m1_stb;
			s_we = m1_we;
		end
		3'd2: begin
			s_adr = m2_adr;
			s_stb = m2_stb;
			s_we = m2_we;
		end
		3'd3: begin
			s_adr = m3_adr;
			s_stb = m3_stb;
			s_we = m3_we;
		end
		default: begin 
			s_adr = m4_adr;
			s_stb = m4_stb;
			s_we = m4_we;
		end
	endcase
end
wire write_burst_start = s_we & s_ack;
reg [2:0] wmaster;
reg [1:0] burst_counter;
always @(posedge sys_clk) begin
	if(sys_rst) begin
		wmaster <= 3'd0;
		burst_counter <= 2'd0;
	end else begin
		if(|burst_counter)
			burst_counter <= burst_counter - 2'd1;
		if(write_burst_start)
			burst_counter <= 2'd2;
		if(~write_burst_start & ~(|burst_counter))
			wmaster <= next_master;
	end
end
always @(*) begin
	case(wmaster)
		3'd0: begin
			s_do = m0_di;
			s_sel = m0_sel;
		end
		3'd1: begin
			s_do = m1_di;
			s_sel = m1_sel;
		end
		3'd2: begin
			s_do = m2_di;
			s_sel = m2_sel;
		end
		3'd3: begin
			s_do = m3_di;
			s_sel = m3_sel;
		end
		default: begin 
			s_do = m4_di;
			s_sel = m4_sel;
		end
	endcase
end
endmodule