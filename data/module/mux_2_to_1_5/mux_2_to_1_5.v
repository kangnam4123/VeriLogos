module mux_2_to_1_5(
    input [4:0] A,B,
    input enable,
    output reg[4:0] O
);
    always @* begin
        if (enable) O <= B;
        else O <= A;
    end
endmodule