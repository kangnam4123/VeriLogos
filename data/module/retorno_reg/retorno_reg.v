module retorno_reg #(parameter WIDTH = 10)
              (input  wire             swe, reset,
               input  wire [WIDTH-1:0] d, 
               output reg  [WIDTH-1:0] q);
  always @(posedge swe, posedge reset)
    if (reset) q <= 0;
    else       q <= d;
endmodule