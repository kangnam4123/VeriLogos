module bs4_strong_FIR (p0,p1,p2,p3,q0,q1,q2,q3,p0_out,p1_out,p2_out,q0_out,q1_out,q2_out);
	input [7:0]  p0,p1,p2,p3,q0,q1,q2,q3;
	output [7:0] p0_out,p1_out,p2_out,q0_out,q1_out,q2_out;
	wire [8:0] sum_p2p3,sum_p1p2,sum_p0q0,sum_p1q1,sum_q1q2,sum_q2q3;
	assign sum_p2p3 = p2 + p3;
	assign sum_p1p2 = p1 + p2;
	assign sum_p0q0 = p0 + q0;
	assign sum_p1q1 = p1 + q1;
	assign sum_q1q2 = q1 + q2;
	assign sum_q2q3 = q2 + q3;
	wire [9:0] sum_p2p3_x2,sum_q2q3_x2;
	assign sum_p2p3_x2 = {sum_p2p3,1'b0};
	assign sum_q2q3_x2 = {sum_q2q3,1'b0};
	wire [9:0] sum_0,sum_1,sum_2;
	assign sum_0 = sum_p0q0 + sum_p1p2;
	assign sum_1 = sum_p0q0 + sum_p1q1;
	assign sum_2 = sum_p0q0 + sum_q1q2;
	wire [10:0] p0_tmp,p2_tmp,q0_tmp,q2_tmp;
	assign p0_tmp = sum_0 + sum_1;
	assign p2_tmp = sum_p2p3_x2 + sum_0;
	assign q0_tmp = sum_1 + sum_2;
	assign q2_tmp = sum_q2q3_x2 + sum_2;
	assign p0_out = (p0_tmp + 4) >> 3;
	assign p1_out = (sum_0  + 2) >> 2;
	assign p2_out = (p2_tmp + 4) >> 3;
	assign q0_out = (q0_tmp + 4) >> 3;
	assign q1_out = (sum_2  + 2) >> 2;
	assign q2_out = (q2_tmp + 4) >> 3;
endmodule