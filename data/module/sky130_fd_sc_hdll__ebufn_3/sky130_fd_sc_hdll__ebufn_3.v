module sky130_fd_sc_hdll__ebufn_3 (
    Z   ,
    A   ,
    TE_B
);
    output Z   ;
    input  A   ;
    input  TE_B;
    bufif0 bufif00 (Z     , A, TE_B        );
endmodule