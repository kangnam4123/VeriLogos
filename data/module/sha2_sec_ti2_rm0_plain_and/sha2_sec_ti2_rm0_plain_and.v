module sha2_sec_ti2_rm0_plain_and(
    input wire a,
    input wire b,
    output reg q
    );
always @* q = a&b;
endmodule