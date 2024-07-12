module FourToSeven (
    ByteIn,
    Enable,
    Polarity,
    SegOut
);
input [3:0] ByteIn;
input Enable;
input Polarity;
output [6:0] SegOut;
reg [6:0] SegOut;
always @(Polarity, ByteIn, Enable) begin: FOURTOSEVEN_COMB
    reg [7-1:0] SegBuf;
    SegBuf = 7'h0;
    if ((Enable == 1)) begin
        case (ByteIn)
            0: SegBuf = 63;
            1: SegBuf = 6;
            2: SegBuf = 91;
            3: SegBuf = 79;
            4: SegBuf = 102;
            5: SegBuf = 109;
            6: SegBuf = 125;
            7: SegBuf = 7;
            8: SegBuf = 127;
            9: SegBuf = 111;
            10: SegBuf = 119;
            11: SegBuf = 124;
            12: SegBuf = 57;
            13: SegBuf = 94;
            14: SegBuf = 121;
            default: SegBuf = 113;
        endcase
    end
    if ((Polarity == 0)) begin
        SegBuf = (~SegBuf);
    end
    SegOut = SegBuf;
end
endmodule