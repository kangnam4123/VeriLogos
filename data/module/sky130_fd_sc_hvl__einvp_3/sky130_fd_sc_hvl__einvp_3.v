module sky130_fd_sc_hvl__einvp_3 (
    Z ,
    A ,
    TE
);
    output Z ;
    input  A ;
    input  TE;
    notif1 notif10 (Z     , A, TE          );
endmodule