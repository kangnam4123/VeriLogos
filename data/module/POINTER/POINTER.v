module POINTER
    #(parameter DEPTH = 5 )
    (input                clk, reset_b, incr,
    output reg [DEPTH:0] ptr);
    always@(posedge clk, negedge reset_b)
        if (~reset_b) ptr <= 0;
        else if (incr) ptr <= ptr + 1;
endmodule