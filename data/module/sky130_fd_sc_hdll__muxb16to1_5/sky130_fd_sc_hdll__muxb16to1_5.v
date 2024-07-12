module sky130_fd_sc_hdll__muxb16to1_5 (
    Z,
    D,
    S
);
    output        Z;
    input  [15:0] D;
    input  [15:0] S;
    bufif1 bufif10  (Z     , !D[0], S[0]    );
    bufif1 bufif11  (Z     , !D[1], S[1]    );
    bufif1 bufif12  (Z     , !D[2], S[2]    );
    bufif1 bufif13  (Z     , !D[3], S[3]    );
    bufif1 bufif14  (Z     , !D[4], S[4]    );
    bufif1 bufif15  (Z     , !D[5], S[5]    );
    bufif1 bufif16  (Z     , !D[6], S[6]    );
    bufif1 bufif17  (Z     , !D[7], S[7]    );
    bufif1 bufif18  (Z     , !D[8], S[8]    );
    bufif1 bufif19  (Z     , !D[9], S[9]    );
    bufif1 bufif110 (Z     , !D[10], S[10]  );
    bufif1 bufif111 (Z     , !D[11], S[11]  );
    bufif1 bufif112 (Z     , !D[12], S[12]  );
    bufif1 bufif113 (Z     , !D[13], S[13]  );
    bufif1 bufif114 (Z     , !D[14], S[14]  );
    bufif1 bufif115 (Z     , !D[15], S[15]  );
endmodule