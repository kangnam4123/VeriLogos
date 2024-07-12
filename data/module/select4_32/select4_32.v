module select4_32(
input [31:0] in1,
input [31:0] in2,
input [31:0] in3,
input [31:0] in4,
input [1:0] choose,
output reg [31:0] out
);
always@(in1 or in2 or in3 or in4 or choose)
case(choose)
2'b00:out=in1;
2'b01:out=in2;
2'b10:out=in3;
2'b11:out=in4;
default:out=32'b0;
endcase
endmodule