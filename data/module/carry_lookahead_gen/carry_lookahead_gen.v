module carry_lookahead_gen 
    (
        input   wire[3:0]   g,
        input   wire[3:0]   p,
        input   wire        cin,
        output  wire[3:0]   cout
    );
    wire    and_out_1;
    wire    and_out_2;
    wire    and_out_3;
    wire    and_out_4;
    wire    and_out_5;
    wire    and_out_6;
    wire    or_out_1;
    wire    or_out_2;
    wire    or_out_3;
    assign  cout = {or_out_3, or_out_2, or_out_1, cin};
    and     A1 (and_out_1, p[0], cin);
    or      O1 (or_out_1, g[0], and_out_1);
    and     A2 (and_out_2, p[1], g[0]);
    and     A3 (and_out_3, p[1], p[0], cin);
    or      O2 (or_out_2, g[1], and_out_3, and_out_2);
    and     A4 (and_out_4, p[2], g[1]);
    and     A5 (and_out_5, p[2], p[1], g[0]);
    and     A6 (and_out_6, p[2], p[1], p[0], cin);
    or      O3 (or_out_3, g[2], and_out_6, and_out_5, and_out_4);
endmodule