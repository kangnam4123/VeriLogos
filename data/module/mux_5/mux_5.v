module mux_5(ina, inb, out, sel);
	input [0:127] ina, inb;
	input sel;
	output [0:127] out;
	reg [0:127] out;
	always @ (ina or inb or sel)
		begin
		out<= sel ? ina : inb;
		end 
endmodule