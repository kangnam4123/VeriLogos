module MUX4_1_5bit(Sel,S0,S1,S2,S3,out);
input [1:0] Sel;
input [4:0] S0,S1,S2,S3;
output [4:0]out;
assign out = (Sel[1]?(Sel[0]?S3:S2) : (Sel[0]?S1:S0));
endmodule