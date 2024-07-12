module cf_fir_24_16_16_8 (clock_c, i1, i2, i3, i4, i5, i6, o1, o2);
input  clock_c;
input  i1;
input  i2;
input  [34:0] i3;
input  [34:0] i4;
input  [34:0] i5;
input  [34:0] i6;
output [35:0] o1;
output [35:0] o2;
wire   n1;
wire   [35:0] n2;
wire   n3;
wire   [35:0] n4;
wire   [35:0] n5;
reg    [35:0] n6;
wire   n7;
wire   [35:0] n8;
wire   n9;
wire   [35:0] n10;
wire   [35:0] n11;
reg    [35:0] n12;
assign n1 = i3[34];
assign n2 = {n1, i3};
assign n3 = i4[34];
assign n4 = {n3, i4};
assign n5 = n2 + n4;
always @ (posedge clock_c)
begin
  if (i2 == 1'b1)
    n6 <= 36'b000000000000000000000000000000000000;
  else if (i1 == 1'b1)
    n6 <= n5;
  if (i2 == 1'b1)
    n12 <= 36'b000000000000000000000000000000000000;
  else if (i1 == 1'b1)
    n12 <= n11;
end
assign n7 = i5[34];
assign n8 = {n7, i5};
assign n9 = i6[34];
assign n10 = {n9, i6};
assign n11 = n8 + n10;
assign o2 = n12;
assign o1 = n6;
endmodule