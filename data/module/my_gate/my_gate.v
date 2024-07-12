module my_gate (
    input  wire A,
    output wire Y
);
    assign Y = ~A;
endmodule