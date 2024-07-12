module generic_iobuf (
output O, 
inout  IO, 
input  I, 
input  T        
);
assign O  = IO;
assign IO = T ? 1'bz : I;
endmodule