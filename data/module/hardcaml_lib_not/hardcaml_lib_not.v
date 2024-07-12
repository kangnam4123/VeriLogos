module hardcaml_lib_not #(parameter b=1) 
(
    input [b-1:0] i,
    output [b-1:0] o
);
    assign o = ~ i;
endmodule