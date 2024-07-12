module mult_8x8_s (
    input  wire signed [ 7:0] A,
    input  wire signed [ 7:0] B,
    output wire signed [15:0] Z
);
    assign Z = A * B;
endmodule