module mul16x16 (input [15:0]      a,
                 input [15:0]      b,
                 output [31:0] o);
   assign o = a * b;
endmodule