module M_uxa_ps2_shfreg(
    input ps2_d_i,
    input ps2_c_i,
    output [7:0] d_o,
    output frame_o,
    input reset_i,
    input sys_clk_i
);
	reg [10:0] data;
	reg curr_ps2_c;
	reg prev_ps2_c;
	wire sample_evt = curr_ps2_c & ~prev_ps2_c;
	assign d_o = data[8:1];
	reg frame;
	assign frame_o = frame;
	always @(posedge sys_clk_i) begin
		if(!reset_i) begin
			prev_ps2_c <= curr_ps2_c;
			curr_ps2_c <= ps2_c_i;
			if(sample_evt)	data <= {ps2_d_i, data[10:1]};
			else				data <= data;
			frame <= data[10] & (~data[0]);
		end else begin
			data <= 11'h7FF;
			frame <= 0;
			prev_ps2_c <= 1;
			curr_ps2_c <= 1;
		end
	end
endmodule