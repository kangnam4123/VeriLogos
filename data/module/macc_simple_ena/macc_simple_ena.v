module macc_simple_ena (
    input  wire        clk,
    input  wire        ena,
    input  wire [ 7:0] A,
    input  wire [ 7:0] B,
    output reg  [15:0] Z
);
    always @(posedge clk)
        if (ena) Z <= Z + (A * B);
endmodule