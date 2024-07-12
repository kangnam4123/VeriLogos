module mux8 #(parameter WIDTH=32) (
    input [2:0] sel,
    input [WIDTH-1:0] in0,in1,in2,in3,in4,in5,in6,in7,
    output reg [WIDTH-1:0] out
    );
always @ (*)
    case (sel)
    3'b000: out = in0;
    3'b001: out = in1;
    3'b010: out = in2;
    3'b011: out = in3;
    3'b100: out = in4;
    3'b101: out = in5;
    3'b110: out = in6;
    3'b111: out = in7;
    endcase
endmodule