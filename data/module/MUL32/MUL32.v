module MUL32 #(parameter SIZE = 32)(input [SIZE-1:0] in1, in2, output [2*SIZE-1:0] out);
assign out = in1*in2;
endmodule