module sky130_fd_sc_lp__ebufn_4 (
    Z   ,
    A   ,
    TE_B
);
    output Z   ;
    input  A   ;
    input  TE_B;
    bufif0 bufif00 (Z     , A, TE_B        );
endmodule