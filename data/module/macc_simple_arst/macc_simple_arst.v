module macc_simple_arst (
    input  wire        clk,
    input  wire        rst,
    input  wire [ 7:0] A,
    input  wire [ 7:0] B,
    output reg  [15:0] Z
);
    always @(posedge clk or posedge rst)
        if (rst) Z <= 0;
        else     Z <= Z + (A * B);
endmodule