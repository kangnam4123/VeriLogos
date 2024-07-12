module sky130_fd_sc_ms__einvp_4 (
    Z ,
    A ,
    TE
);
    output Z ;
    input  A ;
    input  TE;
    notif1 notif10 (Z     , A, TE          );
endmodule