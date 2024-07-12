module FP16RMulS1Of2(
 input 	       clk,
 input 	       rst,
 input 	       arg_0,
 input [4:0]   arg_1,
 input [4:0]   arg_2,
 input [11:0]  arg_3,
 output [15:0] ret_0);
   wire        s;
   wire        c;
   wire [9:0] fc;
   wire [9:0] uc;
   wire [6:0]  e7;
   wire [4:0]  e;
   wire        underflow;
   wire        overflow;
   wire        infinput;
   assign s = arg_0;
   assign c = arg_3[11:11];
   assign e7 = arg_1 + arg_2 - 15 + c;
   assign fc = c ? arg_3[10:1] : arg_3[9:0];
   assign infinput = (arg_1 == 31) || (arg_2 == 31);
   assign underflow = e7[6:6];
   assign overflow = !underflow && (e7[5:5] || e7[4:0] == 31 || infinput);
   assign e = underflow ? 0 : (overflow ? 31 : e7[4:0]);
   assign uc = (underflow || e7[4:0] == 0) ? 0 : fc;
   assign ret_0 = {s, e, uc};
endmodule