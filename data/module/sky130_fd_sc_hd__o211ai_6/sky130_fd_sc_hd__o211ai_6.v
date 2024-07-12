module sky130_fd_sc_hd__o211ai_6 (
    Y ,
    A1,
    A2,
    B1,
    C1
);
    output Y ;
    input  A1;
    input  A2;
    input  B1;
    input  C1;
    wire or0_out    ;
    wire nand0_out_Y;
    or   or0   (or0_out    , A2, A1         );
    nand nand0 (nand0_out_Y, C1, or0_out, B1);
    buf  buf0  (Y          , nand0_out_Y    );
endmodule