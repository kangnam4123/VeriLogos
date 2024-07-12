module components_dff_en #(
    parameter WIDTH = 1
) (
    input clk,
    input en,
    input [WIDTH-1:0] d,
    output [WIDTH-1:0] q
);
    reg [WIDTH-1:0] contents;
    always @ (posedge clk) begin
        if (en == 1'b1)
            contents <= d;
    end
    assign q = contents;
endmodule