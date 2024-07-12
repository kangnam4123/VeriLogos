module has_ports_1 (output reg [8:0] o,
		  input wire [7:0] a,
		  input wire [7:0] b);
   always @* o <= a + b;
endmodule