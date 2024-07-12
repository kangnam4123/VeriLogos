module abc9_test012_sub(inout [7:0] io, input oe);
reg [7:0] latch;
always @(io or oe)
    if (!oe)
        latch[3:0] <= io;
    else
        latch[7:4] <= io;
assign io[3:0] = oe ? ~latch[3:0] : 4'bz;
assign io[7:4] = !oe ? {latch[4], latch[7:3]} : 4'bz;
endmodule