module bus_cdc #( parameter WIDTH = 1)
(
    input clkDst,
    input [WIDTH-1:0] in,
    output [WIDTH-1:0] out
);
reg [WIDTH-1:0] sync [1:0];
always @(posedge clkDst)
begin
    sync[1] <= sync[0];
    sync[0] <= in;
end
assign out = sync[1];
endmodule