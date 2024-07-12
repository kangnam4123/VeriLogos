module mux32_2to1(out, in0, in1, sel);
    output reg  [31:0] out;
    input [31:0] in0;
    input [31:0] in1;
	input sel;
  	always @(sel)
    begin
		case (sel)
			1'b0: out = in0;
			1'b1: out = in1;
		endcase
    end
endmodule