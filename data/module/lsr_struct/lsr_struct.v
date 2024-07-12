module lsr_struct
#( 
  parameter CTRL=5, 
  parameter WIDTH=2**CTRL
)
( 
  input   [WIDTH-1:0] in,
  input   [ CTRL-1:0] shift,
  output  [WIDTH:0] out 
);
  wire sign = 1'b0;
  wire [WIDTH:0] tmp [CTRL:0];
  assign tmp[CTRL] = {in[0], in};
  assign out = tmp[0];
  genvar i;
  generate
    for (i = 0; i < CTRL; i = i + 1) begin: mux
      assign tmp[i] = shift[i] ? {tmp[i+1][(2**i)-1], {(2**i){sign}}, tmp[i+1][WIDTH-1:(2**i)]} : tmp[i+1];
    end
  endgenerate
endmodule