module sky130_fd_sc_hdll__muxb4to1 (
    Z,
    D,
    S
);
    output       Z;
    input  [3:0] D;
    input  [3:0] S;
    bufif1 bufif10 (Z     , !D[0], S[0]    );
    bufif1 bufif11 (Z     , !D[1], S[1]    );
    bufif1 bufif12 (Z     , !D[2], S[2]    );
    bufif1 bufif13 (Z     , !D[3], S[3]    );
endmodule