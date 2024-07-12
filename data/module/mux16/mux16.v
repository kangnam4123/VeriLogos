module mux16 #(parameter WIDTH=32) (
    input [3:0] sel,
    input [WIDTH-1:0] in00,in01,in02,in03,in04,in05,in06,in07,
    input [WIDTH-1:0] in08,in09,in10,in11,in12,in13,in14,in15,
    output reg [WIDTH-1:0] out
    );
always @ (*)
    case (sel)
    4'b0000: out = in00;
    4'b0001: out = in01;
    4'b0010: out = in02;
    4'b0011: out = in03;
    4'b0100: out = in04;
    4'b0101: out = in05;
    4'b0110: out = in06;
    4'b0111: out = in07;
    4'b1000: out = in08;
    4'b1001: out = in09;
    4'b1010: out = in10;
    4'b1011: out = in11;
    4'b1100: out = in12;
    4'b1101: out = in13;
    4'b1110: out = in14;
    4'b1111: out = in15;
    endcase
endmodule