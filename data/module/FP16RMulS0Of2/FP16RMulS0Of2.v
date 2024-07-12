module FP16RMulS0Of2(
 input 	       clk,
 input 	       rst,
 input [15:0]  arg_0,
 input [15:0]  arg_1,
 output        ret_0,
 output [4:0]  ret_1,
 output [4:0]  ret_2,
 output [11:0] ret_3);
   wire        s0;
   wire        s1;
   wire [4:0]  e0;
   wire [4:0]  e1;
   wire [9:0]  f0;
   wire [9:0]  f1;
   wire [10:0] ff0;
   wire [10:0] ff1;
   wire [21:0] z;
   wire [11:0] zz;
   assign s0 = arg_0[15:15];
   assign s1 = arg_1[15:15];
   assign e0 = arg_0[14:10];
   assign e1 = arg_1[14:10];
   assign f0 = arg_0[9:0];
   assign f1 = arg_1[9:0];
   assign ret_0 = s0 ^ s1;
   assign ret_1 = e0;
   assign ret_2 = e1;
   assign ff0 = {(e0 == 0 ? 1'b0 : 1'b1), f0};
   assign ff1 = {(e1 == 0 ? 1'b0 : 1'b1), f1};
   assign z = ff0 * ff1;
   assign zz = z[21:10];
   assign ret_3 = zz;
endmodule