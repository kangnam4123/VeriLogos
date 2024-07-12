module io3inv(in, out1, out2);
input   in;
output  out1;
output  out2;
buf g0(out1, in);
buf g1(out2, in);
endmodule