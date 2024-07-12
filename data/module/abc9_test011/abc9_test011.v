module abc9_test011(inout io, input oe);
reg latch;
always @(io or oe)
    if (!oe)
        latch <= io;
endmodule