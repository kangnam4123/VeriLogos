module sky130_fd_sc_lp__einvn_6 (
    Z   ,
    A   ,
    TE_B
);
    output Z   ;
    input  A   ;
    input  TE_B;
    notif0 notif00 (Z     , A, TE_B        );
endmodule