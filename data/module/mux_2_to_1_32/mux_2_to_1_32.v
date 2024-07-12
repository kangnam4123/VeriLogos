module mux_2_to_1_32(
    input [31:0] A,B,
    input enable,
    output reg[31:0] O
);
    always @* begin
        if (enable) O <= B;
        else O <= A;
    end
endmodule