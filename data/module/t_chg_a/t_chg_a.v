module t_chg_a (
   a_p1, b_p1, c_p1, d_p1,
   a, b, c, d
   );
   input [31:0] a;   output [31:0] a_p1;  wire [31:0] a_p1 = a + 1;
   input [31:0] b;   output [31:0] b_p1;  wire [31:0] b_p1 = b + 1;
   input [31:0] c;   output [31:0] c_p1;  wire [31:0] c_p1 = c + 1;
   input [31:0] d;   output [31:0] d_p1;  wire [31:0] d_p1 = d + 1;
endmodule