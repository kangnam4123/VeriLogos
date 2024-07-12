module hardcaml_lib_concat2 
#(
    parameter w0=1, 
    parameter w1=1
) 
(
    input [w0-1:0] i0,
    input [w1-1:0] i1,
    output [w0+w1-1:0] o
);
    assign o = {i0,i1};
endmodule