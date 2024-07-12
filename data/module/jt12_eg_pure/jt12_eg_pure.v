module jt12_eg_pure(
	input			attack,
	input			step,
	input [ 5:1]	rate,
	input [ 9:0]	eg_in,
	input 			ssg_en,	
	input 			sum_up,
	output reg  [9:0] eg_pure
);
reg [ 3:0] 	dr_sum;
reg [ 9:0]	dr_adj;
reg	[10:0]	dr_result;
always @(*) begin : dr_calculation
	case( rate[5:2] )
		4'b1100: dr_sum = { 2'b0, step, ~step }; 
		4'b1101: dr_sum = { 1'b0, step, ~step, 1'b0 }; 
		4'b1110: dr_sum = { step, ~step, 2'b0 }; 
		4'b1111: dr_sum = 4'd8;
		default: dr_sum = { 2'b0, step, 1'b0 };
	endcase
	dr_adj = ssg_en ? {4'd0, dr_sum, 2'd0} : {6'd0, dr_sum};
	dr_result = dr_adj + eg_in;
end
reg [ 7:0] ar_sum0;
reg [ 8:0] ar_sum1;
reg [10:0] ar_result;
reg [ 9:0] ar_sum;
always @(*) begin : ar_calculation
	casez( rate[5:2] )
		default: ar_sum0 = {2'd0, eg_in[9:4]};
		4'b1101: ar_sum0 = {1'd0, eg_in[9:3]};
		4'b111?: ar_sum0 = eg_in[9:2];
	endcase
	ar_sum1 = ar_sum0+9'd1;
	if( rate[5:4] == 2'b11 )
		ar_sum = step ? { ar_sum1, 1'b0 } : { 1'b0, ar_sum1 };
	else
		ar_sum = step ? { 1'b0, ar_sum1 } : 10'd0;
	ar_result = eg_in-ar_sum;
end
reg [9:0] eg_pre_fastar; 
always @(*) begin
	if(sum_up) begin
		if( attack  )
			eg_pre_fastar = ar_result[10] ? 10'd0: ar_result[9:0];
		else 
			eg_pre_fastar = dr_result[10] ? 10'h3FF : dr_result[9:0];
	end
	else eg_pre_fastar = eg_in;
	eg_pure = (attack&rate[5:1]==5'h1F) ? 10'd0 : eg_pre_fastar;
end
endmodule