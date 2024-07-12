module mux4to1_2 #(
    parameter WIDTH = 1
    ) (
    input wire [WIDTH - 1:0] inA,
    input wire [WIDTH - 1:0] inB,
    input wire [WIDTH - 1:0] inC,
    input wire [WIDTH - 1:0] inD,
    input wire [1:0] select,
    output reg [WIDTH - 1:0] out
    );
    always @(inA, inB, inC, inD, select) begin
        case(select)
             0 : out = inA;
             1 : out = inB;
             2 : out = inC;
             3 : out = inD;
             default: out = inA;
        endcase
    end  
endmodule