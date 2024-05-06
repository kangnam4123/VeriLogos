module cla_logic (cout, p, g);
output cout;
input [3:0] p, g;
wire [4:0] sum = p + g;
assign cout = sum[4];
endmodule