module TwoInRow(
    input [2:0] Xin,
    input [2:0] Yin,
    output wire [2:0] cout
    );
    assign cout[0] = ~Yin[0] & ~Xin[0] & Xin[1] & Xin[2];
    assign cout[1] = ~Yin[1] & Xin[0] & ~Xin[1] & Xin[2];
    assign cout[2] = ~Yin[2] & Xin[0] & Xin[1] & ~Xin[2];
endmodule