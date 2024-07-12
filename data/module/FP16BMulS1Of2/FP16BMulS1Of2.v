module FP16BMulS1Of2(
 input 	       clk,
 input 	       rst,
 input 	       arg_0,
 input [7:0]   arg_1,
 input [7:0]   arg_2,
 input [8:0]  arg_3,
 output [15:0] ret_0);
   wire        s;
   wire        c;
   wire [6:0] fc;
   wire [6:0] uc;
   wire [9:0]  e10;
   wire [7:0]  e;
   wire        underflow;
   wire        overflow;
   wire        infinput;
   assign s = arg_0;
   assign c = arg_3[8:8];
   assign e10 = arg_1 + arg_2 - 127 + c;
   assign fc = c ? arg_3[7:1] : arg_3[6:0];
   assign infinput = (arg_1 == 255) || (arg_2 == 255);
   assign underflow = e10[9:9];
   assign overflow = !underflow && (e10[8:8] || e10[7:0] == 255 || infinput);
   assign e = underflow ? 0 : (overflow ? 255 : e10[7:0]);
   assign uc = (underflow || e10[7:0] == 0) ? 0 : fc;
   assign ret_0 = {s, e, uc};
endmodule