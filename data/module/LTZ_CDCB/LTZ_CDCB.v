module LTZ_CDCB #(
    parameter                WIDTH   = 1,
    parameter  [WIDTH -1:0]  INITVAL = {WIDTH{1'b0}}
) (
    input                    rst_n ,
    input                    clk   ,
    input      [WIDTH -1:0]  din   ,
    output reg [WIDTH -1:0]  dout
);
reg  [WIDTH -1:0]  buff;
always @(posedge clk or negedge rst_n)
  if (!rst_n)
    {dout, buff} <= {INITVAL, INITVAL};
  else
    {dout, buff} <= {buff, din};
endmodule