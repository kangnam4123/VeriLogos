module mult_16x16 (
    input  wire [15:0] A,
    input  wire [15:0] B,
    output wire [31:0] Z
);
    assign Z = A * B;
endmodule