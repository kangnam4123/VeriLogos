module mux_if_unbal_4_1 #(parameter N=4, parameter W=1) (input [N*W-1:0] i, input [$clog2(N)-1:0] s, output reg [W-1:0] o);
always @*
    if (s == 0) o <= i[0*W+:W];
    else if (s == 1) o <= i[1*W+:W];
    else if (s == 2) o <= i[2*W+:W];
    else if (s == 3) o <= i[3*W+:W];
    else o <= {W{1'bx}};
endmodule