module ext16_wb (op,din,dout);
   input         op;
   input [15:0]  din;
   output [31:0] dout;
   assign dout=(op==1'b0)?{16'h0000,din}:
               {{16{din[15]}},din};
endmodule