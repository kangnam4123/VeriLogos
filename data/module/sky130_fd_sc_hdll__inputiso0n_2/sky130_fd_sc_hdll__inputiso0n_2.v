module sky130_fd_sc_hdll__inputiso0n_2 (
    X      ,
    A      ,
    SLEEP_B
);
    output X      ;
    input  A      ;
    input  SLEEP_B;
    and and0 (X     , A, SLEEP_B     );
endmodule