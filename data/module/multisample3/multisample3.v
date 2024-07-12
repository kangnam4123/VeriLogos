module multisample3(
    input clk,
    input in,
    output reg out
    );
reg[2:0] r;
always @(r) begin
    case (r)
        3'b000: out = 1'b0;
        3'b001: out = 1'b0;
        3'b010: out = 1'b0;
        3'b011: out = 1'b1;
        3'b100: out = 1'b0;
        3'b101: out = 1'b1;
        3'b110: out = 1'b1;
        3'b111: out = 1'b1;
    endcase
end
always @(posedge clk) begin
    r <= { r[1:0], in };
end
endmodule