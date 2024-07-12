module mult_20x18 (
    input  wire [19:0] A,
    input  wire [17:0] B,
    output wire [37:0] Z
);
    assign Z = A * B;
endmodule