module sky130_fd_sc_hdll__a222oi_6 (
    Y ,
    A1,
    A2,
    B1,
    B2,
    C1,
    C2
);
    output Y ;
    input  A1;
    input  A2;
    input  B1;
    input  B2;
    input  C1;
    input  C2;
    wire nand0_out ;
    wire nand1_out ;
    wire nand2_out ;
    wire and0_out_Y;
    nand nand0 (nand0_out , A2, A1                         );
    nand nand1 (nand1_out , B2, B1                         );
    nand nand2 (nand2_out , C2, C1                         );
    and  and0  (and0_out_Y, nand0_out, nand1_out, nand2_out);
    buf  buf0  (Y         , and0_out_Y                     );
endmodule