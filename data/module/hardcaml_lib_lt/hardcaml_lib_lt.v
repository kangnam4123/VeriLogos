module hardcaml_lib_lt #(parameter b=1) 
(
    input [b-1:0] i0,
    input [b-1:0] i1,
    output o
);
    assign o = i0 < i1;
endmodule