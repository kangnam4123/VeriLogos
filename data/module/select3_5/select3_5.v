module select3_5(
input [4:0] in1,
input [4:0] in2,
input [4:0] in3,
input [1:0] choose,
output reg [4:0] out
);
always@(in1 or in2 or in3 or choose)
case(choose)
2'b00:out=in1;
2'b01:out=in2;
2'b10:out=in3;
default:out=5'b0;
endcase
endmodule