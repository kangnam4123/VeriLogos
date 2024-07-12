module mult_8x8 (
    input  wire [ 7:0] A,
    input  wire [ 7:0] B,
    output wire [15:0] Z
);
    assign Z = A * B;
endmodule