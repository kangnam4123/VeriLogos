module FP16BAddSubS3Of5(
 input 	       clk,
 input 	       rst,
 input [15:0]  arg_0,
 input 	       arg_1,
 input 	       arg_2,
 input [7:0]   arg_3,
 input 	       arg_4,
 input 	       arg_5,
 output [14:0] ret_0,
 output        ret_1,
 output        ret_2,
 output [7:0]  ret_3,
 output        ret_4,
 output        ret_5,
 output        ret_6);
   wire [15:0] r;
   wire        xs;
   wire        ys;
   wire [7:0]  e;
   wire        xn;
   wire        yn;
   wire        diff_sign;
   wire        with_carry;
   wire        neg;
   wire [14:0] neg_r;
   wire [14:0] half_r;
   wire [14:0] r_diff;
   wire [14:0] r_same;
   wire [14:0] r_final;
   wire [7:0]  eplus;
   wire [7:0]  e_final;
   assign r = arg_0;
   assign xs = arg_1;
   assign ys = arg_2;
   assign e = arg_3;
   assign xn = arg_4;
   assign yn = arg_5;
   assign diff_sign = (xn != yn);
   assign with_carry = r[15:15];
   assign neg_r = (~r) + 1;
   assign half_r = r[15:1];
   assign neg = diff_sign & !with_carry;
   assign eplus = e + 1;
   assign r_diff = with_carry ? r[14:0] : neg_r;
   assign r_same = with_carry ? half_r : r[14:0];
   assign r_final = diff_sign ? r_diff : r_same;
   assign e_final = (!diff_sign && with_carry) ? eplus : e;
   assign ret_0 = r_final;
   assign ret_1 = xs;
   assign ret_2 = ys;
   assign ret_3 = e_final;
   assign ret_4 = neg;
   assign ret_5 = xn;
   assign ret_6 = yn;
endmodule