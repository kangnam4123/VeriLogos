module Mac #(
    parameter D_BITS = 8,
    parameter W_BITS = 8,
    parameter A_BITS = 16
) (
    input clock,
    input reset,
    input set_w,
    input stall,
    input [A_BITS-1:0] a_in,
    input [D_BITS-1:0] d_in,
    output reg [A_BITS-1:0] a_out,
    output reg [D_BITS-1:0] d_out
);
    reg [W_BITS-1:0] w;
    always @(posedge clock) begin
        if (reset) begin
            a_out <= {A_BITS{1'b0}};
            d_out <= {D_BITS{1'b0}};
        end else if (!stall) begin
            if (set_w) begin
                w     <= a_in;
                a_out <= a_in;
            end else begin
                a_out <= d_in * w + a_in;
                d_out <= d_in;
            end
        end
    end
endmodule