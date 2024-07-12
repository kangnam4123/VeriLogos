module sha2_sec_ti2_rm0_xor_impl #(
		parameter WIDTH = 1,
		parameter NOTY = 0
	)(
    input wire [WIDTH-1:0] a,
    input wire [WIDTH-1:0] b,
    output reg [WIDTH-1:0] y
    );
always @* y = NOTY ^ a ^ b;
endmodule