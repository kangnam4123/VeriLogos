module LUT_K #(
    parameter K = 6,
    parameter LUT_MASK={2**K{1'b0}}
) (
    input [K-1:0] in,
    output out
);
    assign out = LUT_MASK[in];
endmodule