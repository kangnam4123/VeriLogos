module sky130_fd_sc_hd__xnor2_1 (
    Y,
    A,
    B
);
    output Y;
    input  A;
    input  B;
    wire xnor0_out_Y;
    xnor xnor0 (xnor0_out_Y, A, B           );
    buf  buf0  (Y          , xnor0_out_Y    );
endmodule