module convolution(outr,outi,a,b);
    input [15:0] a, b;
    output [17:0] outr, outi;
    wire signed [7:0] a_rea, a_ima, b_rea, b_ima;
    assign a_rea = a[15:8]; assign a_ima = a[7:0];
    assign b_rea = b[15:8]; assign b_ima = b[7:0];
    assign outr = a_rea*b_rea - a_ima*b_ima;
    assign outi = a_rea*b_ima + a_ima*b_rea;
endmodule