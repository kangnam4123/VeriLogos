module MULT18X18_1 (
    input signed [17:0] A,
    input signed [17:0] B,
    output signed [35:0] P
);
assign P = A * B;
endmodule