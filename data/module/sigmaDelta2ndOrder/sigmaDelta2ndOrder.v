module sigmaDelta2ndOrder
#(
    parameter WIDTH = 16,
    parameter GROWTH = 2
) (
    input clk,
    input rst,
    input en,
    input signed [WIDTH-1:0] in,
    output sdOut
);
localparam integer GAIN = 2.0**(WIDTH-1)*1.16;
reg signed [WIDTH+GROWTH-1:0] acc1 = 'd0;
reg signed [WIDTH+2*GROWTH-1:0] acc2 = 'd0;
always @(posedge clk) begin
    if (rst) begin
        acc1 = 'd0;
        acc2 = 'd0;
    end else if (en) begin
        acc1 = acc1 + in + ($signed({sdOut,1'b1})*GAIN);
        acc2 = acc2 + acc1 + ($signed({sdOut,1'b1}) <<< WIDTH);
    end
end
assign sdOut = ~acc2[WIDTH+2*GROWTH-1];
endmodule