module select2_32(
input [31:0] in1,
input [31:0] in2,
input choose,
output reg [31:0] out
);
always@(in1 or in2 or choose)
case(choose)
1'b0:out=in1;
1'b1:out=in2;
default:out=32'b0;
endcase
endmodule