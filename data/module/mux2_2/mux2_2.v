module mux2_2 #(
    parameter bits = 16
) (
    input sel,
    input [bits-1:0] d0, d1,
    output [bits-1:0] q
);
    assign q = sel ? d1 : d0;
endmodule