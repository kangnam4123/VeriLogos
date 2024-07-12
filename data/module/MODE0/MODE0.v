module MODE0(outR, outI, a, b);
input [15:0] a, b;
output signed [17:0] outR, outI;
wire signed [7:0] aR, aI;
wire signed [7:0] bR, bI;
wire signed [17:0] r1, r2;
wire signed [17:0] i1, i2;
assign aR = a[15:8]; assign aI = a[7:0];
assign bR = b[15:8]; assign bI = b[7:0];
assign r1 = aR*bR; assign r2 = aI*bI;
assign i1 = aR*bI; assign i2 = aI*bR;
assign outR = r1 - r2;
assign outI = i1 + i2;
endmodule