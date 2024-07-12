module mux_4_to_1_32(
    input [31:0] A,B,C,D,
    input [1:0] enable,
    output reg[31:0] O
);
    always @* begin
        case (enable) 
            2'b00 : begin
                O <= A;
            end
            2'b01 : begin
                O <= B;
            end
            2'b10 : begin
                O <= C;
            end
            2'b11 : begin
                O <= D;
            end
        endcase
    end
endmodule