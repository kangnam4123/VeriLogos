module hardcaml_tristate_buffer
#(
    parameter b=1
) 
(
    input en,
    input [b-1:0] i,
    output [b-1:0] o,
    inout [b-1:0] io
);
    assign io = en ? i : {b{1'bz}};
    assign o = io;
endmodule