module bw_io_schmitt(
    out,
   in, 
   vddo );
output	out;
input	in;
inout	vddo;
wire out = in;
endmodule