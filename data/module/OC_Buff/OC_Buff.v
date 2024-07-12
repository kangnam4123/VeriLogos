module OC_Buff(in, out);
input in;
output out;
assign out = in ? 1'bz : 1'b0;
endmodule