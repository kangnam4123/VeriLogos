module mux_2_to_1_1(
    input A,B,
    input enable,
    output reg O
);
    always @* begin
        if (enable) O <= B;
        else O <= A;
    end
endmodule