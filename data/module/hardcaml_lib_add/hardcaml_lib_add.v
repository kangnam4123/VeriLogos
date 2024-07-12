module hardcaml_lib_add #(parameter b=1) 
(
    input [b-1:0] i0,
    input [b-1:0] i1,
    output [b-1:0] o
);
    assign o = i0 + i1;
endmodule