module DIV8 #(parameter SIZE = 8)(input [SIZE-1:0] in1, in2, 
    output [SIZE-1:0] out, rem);
assign out = in1/in2;
assign rem = in1%in2;
endmodule