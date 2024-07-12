module Mux8_1(sel, i0, i1, i2, i3, i4, i5, i6, i7, o);
	parameter data_width = 8;
	input[2 : 0] sel;
	input[data_width - 1 : 0] i0;
	input[data_width - 1 : 0] i1;
	input[data_width - 1 : 0] i2;
	input[data_width - 1 : 0] i3;
	input[data_width - 1 : 0] i4;
	input[data_width - 1 : 0] i5;
	input[data_width - 1 : 0] i6;
	input[data_width - 1 : 0] i7;
	output[data_width - 1 : 0] o;
	reg[data_width - 1 : 0] reg_o;
	always @(*) begin
		case (sel)
			0 : reg_o <= i0;
			1 : reg_o <= i1;
			2 : reg_o <= i2;
			3 : reg_o <= i3;
			4 : reg_o <= i4;
			5 : reg_o <= i5;
			6 : reg_o <= i6;
			7 : reg_o <= i7;
			default : ;
		endcase
	end
	assign o = reg_o;
endmodule