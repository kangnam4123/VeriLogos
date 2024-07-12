module counter_behavioural #(
    parameter bits = 16
) (
    input clock, reset, enable, load,
    input [bits-1:0] init,
    output reg [bits-1:0] q
);
    always @(posedge clock, posedge reset)
        if (reset) 
            q <= 0;
        else if (enable) 
            if (load) q <= init;
            else q <= q + 1;
endmodule