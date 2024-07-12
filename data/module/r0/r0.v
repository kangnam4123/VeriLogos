module r0 (
	input clk_sys,
	input strob1b,
	input [0:15] w,
	input zs, s_1, s0, carry, vl, vg, exy, exx,
	input ust_z, ust_v, ust_mc, ust_y, ust_x, cleg,
	input w_zmvc, w_legy, lrp,
	input _0_v,
	input zer,
	output reg [0:15] r0
);
	wire c0 = ust_z & strob1b;
	wire c1 = ust_mc & strob1b;
	wire c2 = ust_v & strob1b;
	wire c7 = ust_y & strob1b;
	wire c8 = ust_x & strob1b;
	always @ (posedge clk_sys, posedge zer) begin
		if (zer) r0[0:15] <= 16'b0;
		else begin
			if (w_zmvc) {r0[0:1], r0[3]} <= {w[0:1], w[3]};
			else begin
				if (c0) r0[0] <= zs;
				if (c1) {r0[1], r0[3]} <= {s_1, carry};
			end
			if (_0_v) r0[2] <= 1'b0;
			else if (w_zmvc) r0[2] <= w[2];
			else if (c2 & (s0 ^ s_1)) r0[2] <= 1'b1;
			if (w_legy) r0[4:7] <= w[4:7];
			else begin
				if (cleg) r0[4:6] <= {vl, zs, vg};
				if (c7) r0[7] <= exy;
			end
			if (lrp) r0[8:15] <= w[8:15];
			else if (c8) r0[8] <= exx;
		end
	end
endmodule