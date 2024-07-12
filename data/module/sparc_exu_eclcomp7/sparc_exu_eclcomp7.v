module sparc_exu_eclcomp7 (
   out, 
   in1, in2
   ) ;
   input [6:0] in1;
   input [6:0] in2;
   output      out;
   wire [6:0]  in1xorin2;
   wire nor1out;
   wire nor2out;
   wire nor3out;
   wire nandout;
   assign in1xorin2 = in1 ^ in2;
   assign nor1out = ~(in1xorin2[0] | in1xorin2[1]);
   assign nor2out = ~(in1xorin2[2] | in1xorin2[3]);
   assign nor3out = ~(in1xorin2[4] | in1xorin2[5]);
   assign nandout = ~(nor1out & nor2out & nor3out);
   assign out = ~(in1xorin2[6] | nandout);
endmodule