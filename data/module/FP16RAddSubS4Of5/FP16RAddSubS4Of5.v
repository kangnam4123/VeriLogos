module FP16RAddSubS4Of5(
 input 	       clk,
 input 	       rst,
 input [20:0]  arg_0,
 input 	       arg_1,
 input 	       arg_2,
 input [4:0]   arg_3,
 input 	       arg_4,
 input 	       arg_5,
 input 	       arg_6,
 output [15:0] ret_0);
   wire [21:0] r;
   wire        xs;
   wire        ys;
   wire [4:0]  e;
   wire [4:0]  e_final;
   wire [5:0]  e_l0adjust;
   wire        underflow;
   wire [4:0]  e_adjust;
   wire        neg;
   wire        xn;
   wire        yn;
   wire [10:0] rr;
   wire [9:0] r_final;
   wire [21:0] r8;
   wire [21:0] r4;
   wire [21:0] r2;
   wire [21:0] r1;
   wire [3:0]  l0count;
   wire        s;
   assign r = arg_0;
   assign xs = arg_1;
   assign ys = arg_2;
   assign e = arg_3;
   assign neg = arg_4;
   assign xn = arg_5;
   assign yn = arg_6;
   assign s = (xn == yn) ? xs : (yn ? (neg ^ xs): (neg ^ ys));
   assign r8 = (r[20:13] == 0) ? {r[12:0], 8'b0} : r;
   assign r4 = (r8[20:17] == 0) ? {r8[16:0], 4'b0} : r8;
   assign r2 = (r4[20:19] == 0) ? {r4[18:0], 2'b0} : r4;
   assign r1 = (r2[20:20] == 0) ? {r2[19:0], 1'b0} : r2;
   assign l0count = {r[20:13] == 0, r8[20:17] == 0, r4[20:19] == 0, r2[20:20] == 0};
   assign rr = (xn == yn) ? r[20:10] : r1;
   assign e_l0adjust = e - l0count;
   assign underflow = e_l0adjust[5:5];
   assign e_adjust = underflow ? 0 : e_l0adjust[4:0];
   assign e_final = (xn == yn) ? e : e_adjust[4:0];
   assign r_final = underflow ? 0 : rr[9:0];
   assign ret_0 = {s, e_final, r_final};
endmodule