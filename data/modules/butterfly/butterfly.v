module butterfly (D0,D1,D2,D3,F0,F1,F2,F3,IsHadamard);
	input [15:0] D0,D1,D2,D3;
	input IsHadamard;
	output [15:0] F0,F1,F2,F3;
	wire [15:0] T0,T1,T2,T3;
	wire [15:0] D1_scale,D3_scale;
	assign D1_scale = (IsHadamard == 1'b1)? D1:{D1[15],D1[15:1]};
	assign D3_scale = (IsHadamard == 1'b1)? D3:{D3[15],D3[15:1]};
	assign T0 = D0 + D2;
	assign T1 = D0 - D2;
	assign T2 = D1_scale - D3;
	assign T3 = D1 + D3_scale;
	assign F0 = T0 + T3;
	assign F1 = T1 + T2;
	assign F2 = T1 - T2;
	assign F3 = T0 - T3;
endmodule