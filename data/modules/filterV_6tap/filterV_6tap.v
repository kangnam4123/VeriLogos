module filterV_6tap(A,B,C,D,E,F,Is_jfqik,round_out);
	input [14:0] A,B,C,D,E,F;
	input Is_jfqik;
	output [7:0] round_out;
	wire [15:0] sum_AF;
	wire [15:0] sum_BE;
	wire [15:0] sum_CD;
	wire [17:0] sum_4CD;
	wire [17:0] sum_1;
	wire [17:0] sum_2;
	wire [19:0] sum_3;
	wire [19:0] raw_out;
	wire [19:0] sum_round;
	wire [9:0] round_tmp;
	assign sum_AF = {A[14],A} + {F[14],F};
	assign sum_BE = {B[14],B} + {E[14],E};
	assign sum_CD = {C[14],C} + {D[14],D};
	assign sum_4CD = {sum_CD,2'b0};
	assign sum_1 = sum_4CD + {~sum_BE[15],~sum_BE[15],~sum_BE} + 1;
	assign sum_2 = {{2{sum_AF[15]}},sum_AF} + sum_1;
	assign sum_3 = {sum_1,2'b0};
	assign raw_out = {{2{sum_2[17]}},sum_2} + sum_3;
	assign sum_round = (Is_jfqik)? (raw_out + 512):(raw_out + 16);
	assign round_tmp = (Is_jfqik)? sum_round[19:10]:sum_round[14:5];
	assign round_out = (round_tmp[9])? 8'd0:((round_tmp[8])? 8'd255:round_tmp[7:0]);
endmodule