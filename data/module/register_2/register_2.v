module register_2 #(
    parameter bits = 16
) (
    input clock, reset, enable, 
    input [bits-1:0] d,
    output reg [bits-1:0] q
);
    always @(posedge clock, posedge reset)
        if (reset) 
            q <= 0;
        else if (enable) 
            q <= d;
endmodule