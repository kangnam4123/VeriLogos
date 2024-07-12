module acl_fp_negate
#(
  parameter WIDTH=32
)
(
  input  [WIDTH-1:0] data,
  output [WIDTH-1:0] result
);
assign result = { ~data[WIDTH-1], data[WIDTH-2:0] };
endmodule