module hardcaml_lib_mux2 #(parameter b=1) 
(
    input sel,
    input [b-1:0] d0,
    input [b-1:0] d1,
    output [b-1:0] o
);
    assign o = sel ? d1 : d0;
endmodule