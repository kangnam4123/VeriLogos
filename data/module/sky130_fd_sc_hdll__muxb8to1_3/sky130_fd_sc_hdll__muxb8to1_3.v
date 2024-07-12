module sky130_fd_sc_hdll__muxb8to1_3 (
    Z,
    D,
    S
);
    output       Z;
    input  [7:0] D;
    input  [7:0] S;
    bufif1 bufif10 (Z     , !D[0], S[0]    );
    bufif1 bufif11 (Z     , !D[1], S[1]    );
    bufif1 bufif12 (Z     , !D[2], S[2]    );
    bufif1 bufif13 (Z     , !D[3], S[3]    );
    bufif1 bufif14 (Z     , !D[4], S[4]    );
    bufif1 bufif15 (Z     , !D[5], S[5]    );
    bufif1 bufif16 (Z     , !D[6], S[6]    );
    bufif1 bufif17 (Z     , !D[7], S[7]    );
endmodule