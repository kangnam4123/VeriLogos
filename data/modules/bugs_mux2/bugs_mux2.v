module bugs_mux2 (
	input sel,
	input [7:0] a,
	input [7:0] b,
	output [7:0] out
);
 
    assign out = sel ? a : b;
	
endmodule
