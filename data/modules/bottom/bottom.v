module bottom(a, b);
parameter c = 4;
parameter d = 3;
input[3:0] a;
output[5:0] b;
assign b = (a * c) + d;
endmodule