module vector100r (
	input [99:0] in,
	output reg [99:0] out
);

  integer i;

  always@(*) begin
    for (i=0; i<$bits(out); i++)
      out[i] = in[$bits(out)-i-1];
  end

endmodule
