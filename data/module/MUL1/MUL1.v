module MUL1 #(parameter SIZE = 1)(input in1, in2, output [2*SIZE-1:0] out);
assign out = in1*in2;
endmodule