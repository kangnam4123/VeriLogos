module RetimeShiftRegister
#(
    parameter WIDTH = 1,
    parameter STAGES = 1)
(
    input clock,
    input reset,
    input [WIDTH-1:0] in,
    output reg [WIDTH-1:0] out
);
  integer i;
  reg [WIDTH-1:0] sr[STAGES]; 
  always @(posedge clock) begin
    if (reset) begin
      for(i=0; i<STAGES; i=i+1) begin
        sr[i] <= {WIDTH{1'b0}};
      end
    end else begin
      sr[0] <= in;
      for(i=1; i<STAGES; i=i+1) begin
        sr[i] <= sr[i-1];
      end
    end
  end
  always @(*) begin
    out <= sr[STAGES-1];
  end
endmodule