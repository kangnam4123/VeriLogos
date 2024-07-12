module GF_MULS_SCL_2 ( A, ab, B, cd, Y );
    input [1:0] A;
    input ab;
    input [1:0] B;
    input cd;
    output [1:0] Y;
    wire t, p, q;
    assign t = ~(A[0] & B[0]); 
    assign p = (~(ab & cd)) ^ t;
    assign q = (~(A[1] & B[1])) ^ t;
    assign Y = { p, q };
endmodule