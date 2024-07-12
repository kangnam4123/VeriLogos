module mux_3(out,in1,in2,s);
output out;
input in1,in2;
input s;
wire w11,w12,w13;
not(w11,s);
and(w12,w11,in1);
and(w13,s,in2);
or(out,w12,w13);
endmodule