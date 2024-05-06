module div6 (qp,div);
	input [5:0] qp;
	output [3:0] div;
	reg [3:0] div;
	always @ (qp)
		case (qp)
			0, 1, 2, 3, 4, 5 :div <= 4'b0000;
			6, 7, 8, 9, 10,11:div <= 4'b0001;
			12,13,14,15,16,17:div <= 4'b0010;
			18,19,20,21,22,23:div <= 4'b0011;
			24,25,26,27,28,29:div <= 4'b0100;
			30,31,32,33,34,35:div <= 4'b0101;
			36,37,38,39,40,41:div <= 4'b0110;
			42,43,44,45,46,47:div <= 4'b0111;
			48,49,50,51      :div <= 4'b1000;
			default          :div <= 0;
		endcase
endmodule