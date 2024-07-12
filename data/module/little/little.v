module little (
   input clk
            );
   reg [0:7] i8; initial i8 = '0;
   reg [1:49] i48; initial i48 = '0;
   reg [63:190] i128; initial i128 = '0;
   always @ (posedge clk) begin
      i8 <= ~i8;
      i48 <= ~i48;
      i128 <= ~i128;
   end
endmodule