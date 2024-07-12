module pipeline_stall_1 #(
  parameter WIDTH = 1,
  parameter DELAY = 1
)(
  input  wire             clk,
  input  wire             reset,
  input  wire [WIDTH-1:0] datain,
  output wire [WIDTH-1:0] dataout
);
  reg [(WIDTH*DELAY)-1:0] dly_datain = 0;
  assign dataout = dly_datain[(WIDTH*DELAY)-1 : WIDTH*(DELAY-1)];
  always @ (posedge clk, posedge reset)
  if (reset) dly_datain <= 0;
  else       dly_datain <= {dly_datain, datain};
endmodule