module ADD_FIX_POINT_FLOAT ( A, B, out );
parameter width = 16;
input  [width:1] A,B;
output [width:1] out;
assign out = A + B;
endmodule