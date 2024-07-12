module abc9_test010(inout [7:0] io, input oe);
reg [7:0] latch;
always @(io or oe)
    if (!oe)
        latch <= io;
assign io = oe ? ~latch : 8'bz;
endmodule