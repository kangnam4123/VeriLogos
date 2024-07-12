module v468a05_v9a2a06 (
 input [31:0] i,
 output [7:0] o3,
 output [7:0] o2,
 output [7:0] o1,
 output [7:0] o0
);
 assign o3 = i[32:24];
 assign o2 = i[23:16];
 assign o1 = i[15:8];
 assign o0 = i[7:0];
endmodule