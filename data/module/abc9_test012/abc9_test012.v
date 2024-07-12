module abc9_test012(inout io, input oe);
reg latch;
assign io = oe ? ~latch : 8'bz;
endmodule