module abc9_test009(inout io, input oe);
reg latch;
always @(io or oe)
    if (!oe)
        latch <= io;
assign io = oe ? ~latch : 1'bz;
endmodule