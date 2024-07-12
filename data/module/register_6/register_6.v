module register_6 #(parameter WIDTH=32) (
    input clk,
    input en,
    input [WIDTH-1:0] din,
    output [WIDTH-1:0] dout
    );
reg [WIDTH-1:0] data;
initial data = 0;
always @ (posedge clk)
    if (en)
        data <= din;
assign dout = data;
endmodule