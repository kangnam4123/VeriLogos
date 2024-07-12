module SUB64 #(parameter SIZE = 64)(input [SIZE-1:0] in1, in2, 
    input cin, output [SIZE-1:0] out, output cout);
assign {cout, out} = in1 - in2 - cin;
endmodule