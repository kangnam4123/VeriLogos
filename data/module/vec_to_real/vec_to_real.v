module vec_to_real (output wire [3:0] out, input wire in);
  reg [3:0] rval = 0;
  assign out = rval;
  always @(posedge in) rval = rval + 1;
endmodule