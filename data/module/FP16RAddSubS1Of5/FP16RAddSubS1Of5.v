module FP16RAddSubS1Of5(
 input 	       clk,
 input 	       rst,
 input [15:0]  arg_0,
 input [15:0]  arg_1,
 input 	       arg_2,
 input 	       arg_3,
 output        ret_0,
 output        ret_1,
 output [20:0] ret_2,
 output [20:0] ret_3,
 output [4:0]  ret_4,
 output        ret_5,
 output        ret_6);
   wire [15:0] x;
   wire [15:0] y;
   wire        xn;
   wire        yn;
   wire [4:0]  xe;
   wire [4:0]  ye;
   wire        x1;
   wire        y1;
   wire [9:0]  xf;
   wire [9:0]  yf;
   wire [20:0] xr;
   wire [20:0] xrn;
   wire [20:0] yr10;
   wire [4:0]  d;
   wire [20:0] yr1;
   wire [20:0] yr2;
   wire [20:0] yr4;
   wire [20:0] yr8;
   wire [20:0] yr16;   
   wire [20:0] yrn;
   assign x = arg_0;
   assign y = arg_1;
   assign xn = arg_2;
   assign yn = arg_3;
   assign xe = x[14:10];
   assign ye = y[14:10];
   assign xf = x[9:0];
   assign yf = y[9:0];
   assign x1 = xe > 0;
   assign y1 = ye > 0;
   assign xr = {x1, xf, 10'b0};
   assign xrn = xn ? ~xr : xr;
   assign yr10 = {y1, yf, 10'b0};
   assign d = xe - ye;
   assign yr1 = d[0:0] ? {1'b0, yr10[20:1]} : yr10;
   assign yr2 = d[1:1] ? {2'b0, yr1[20:2]} : yr1;
   assign yr4 = d[2:2] ? {4'b0, yr2[20:4]} : yr2;
   assign yr8 = d[3:3] ? {8'b0, yr4[20:8]} : yr4;
   assign yr16 = d[4:4] ? {16'b0, yr8[20:16]} : yr8;
   assign yrn = yn ? ~yr16 : yr16;
   assign ret_0 = x[15];
   assign ret_1 = y[15];
   assign ret_2 = xrn;
   assign ret_3 = yrn;
   assign ret_4 = xe;
   assign ret_5 = xn;
   assign ret_6 = yn;
endmodule