module mult_4_to_1(sel, a_in, b_in, c_in, d_in, out);
	parameter width = 'd16; 
	input wire [1:0] sel;
	input wire [width-1:0] a_in, b_in, c_in, d_in;
	output reg [width-1:0] out;
	always@(sel, a_in, b_in, c_in, d_in) begin
		case(sel) 
			2'b00: out [width-1:0] = a_in [width-1:0];
			2'b01: out [width-1:0] = b_in [width-1:0];
			2'b10: out [width-1:0] = c_in [width-1:0];
			2'b11: out [width-1:0] = d_in [width-1:0];
			default: out [width-1:0] = {width{1'b0}};
		endcase
	end
endmodule