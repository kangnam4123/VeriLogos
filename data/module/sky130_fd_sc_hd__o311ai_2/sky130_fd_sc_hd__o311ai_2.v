module sky130_fd_sc_hd__o311ai_2 (
    Y ,
    A1,
    A2,
    A3,
    B1,
    C1
);
    output Y ;
    input  A1;
    input  A2;
    input  A3;
    input  B1;
    input  C1;
    wire or0_out    ;
    wire nand0_out_Y;
    or   or0   (or0_out    , A2, A1, A3     );
    nand nand0 (nand0_out_Y, C1, or0_out, B1);
    buf  buf0  (Y          , nand0_out_Y    );
endmodule