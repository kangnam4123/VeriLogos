module sky130_fd_sc_ls__einvn (
    Z   ,
    A   ,
    TE_B
);
    output Z   ;
    input  A   ;
    input  TE_B;
    notif0 notif00 (Z     , A, TE_B        );
endmodule