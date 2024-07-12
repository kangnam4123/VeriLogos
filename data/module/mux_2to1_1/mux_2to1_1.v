module mux_2to1_1(OUT,IN0,IN1,S0);
    output OUT;
    input IN0,IN1,S0;
    wire S0_not;
    not(S0_not,S0);
    bufif0 b0(OUT,IN0,S0_not);
    bufif1 b1(OUT, IN1,S0);
endmodule