module mux(select,x,y,z);
input select,x,y;
output z;
assign z=(x & ~select) | (y & select);
endmodule