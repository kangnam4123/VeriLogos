module ve500df_v9a2a06 (
 input [31:0] i,
 output [28:0] o1,
 output [2:0] o0
);
 assign o1 = i[31:3];
 assign o0 = i[2:0];
endmodule