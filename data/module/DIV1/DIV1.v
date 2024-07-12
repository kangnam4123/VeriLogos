module DIV1 #(parameter SIZE = 1)(input in1, in2, output out, rem);
assign out = in1/in2;
assign rem = in1%in2;
endmodule