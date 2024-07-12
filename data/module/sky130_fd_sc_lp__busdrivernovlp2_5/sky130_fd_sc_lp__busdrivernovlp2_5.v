module sky130_fd_sc_lp__busdrivernovlp2_5 (
    Z   ,
    A   ,
    TE_B
);
    output Z   ;
    input  A   ;
    input  TE_B;
    bufif0 bufif00 (Z     , A, TE_B        );
endmodule