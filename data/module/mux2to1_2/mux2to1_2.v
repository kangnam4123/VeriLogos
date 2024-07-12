module mux2to1_2 #(
    parameter WIDTH = 1
    ) (
    input wire [WIDTH - 1:0] inA,
    input wire [WIDTH - 1:0] inB,
    input wire select,
    output reg [WIDTH - 1:0] out
    );
    always @(inA, inB, select) begin
        case(select)
             0 : out = inA;
             1 : out = inB;
             default: out = inA;
        endcase
    end  
endmodule