module ALU_19 #(
    parameter WIDTH = 32
    ) (
    input wire [3:0] op,
    input wire [WIDTH - 1:0] inA,
    input wire [WIDTH - 1:0] inB,
    output reg [WIDTH - 1:0] out,
    output wire zero
    );
    always @(op, inA, inB) begin
        case(op)
             0 : out = inA & inB;
             1 : out = inA | inB;
             2 : out = inA + inB;
             6 : out = inA - inB;
             7 : out = (inA < inB) ? 1 : 0;
            12 : out = ~(inA | inB);
            default: out = 32'bx;
        endcase
    end  
    assign zero = (out == 0);
endmodule