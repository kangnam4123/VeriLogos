module signed_operators(
    sel,
    a, b,
    c,
    mux_uu, mux_us, mux_su, mux_ss,
    eql_uu, eql_us, eql_su, eql_ss,
    neq_uu, neq_us, neq_su, neq_ss,
    sgn_u,  sgn_s,
    add_uu, add_us, add_su, add_ss,
    sub_uu, sub_us, sub_su, sub_ss,
    mul_uu, mul_us, mul_su, mul_ss,
    ltn_uu, ltn_us, ltn_su, ltn_ss,
    leq_uu, leq_us, leq_su, leq_ss
    );
input         sel;
input   [7:0] a, b;
input   [5:0] c;
output [15:0] mux_uu, mux_us, mux_su, mux_ss;
output        eql_uu, eql_us, eql_su, eql_ss;
output        neq_uu, neq_us, neq_su, neq_ss;
output [15:0] sgn_u,  sgn_s;
output [15:0] add_uu, add_us, add_su, add_ss;
output [15:0] sub_uu, sub_us, sub_su, sub_ss;
output [15:0] mul_uu, mul_us, mul_su, mul_ss;
output        ltn_uu, ltn_us, ltn_su, ltn_ss;
output        leq_uu, leq_us, leq_su, leq_ss;
assign mux_uu = sel ?         a  :         b ;
assign mux_us = sel ?         a  : $signed(b);
assign mux_su = sel ? $signed(a) :         b ;
assign mux_ss = sel ? $signed(a) : $signed(b);
assign eql_uu =         a  ==         c ;
assign eql_us =         a  == $signed(c);
assign eql_su = $signed(a) ==         c ;
assign eql_ss = $signed(a) == $signed(c);
assign neq_uu =         a  !=         c ;
assign neq_us =         a  != $signed(c);
assign neq_su = $signed(a) !=         c ;
assign neq_ss = $signed(a) != $signed(c);
assign sgn_u = ~$unsigned(c) ;
assign sgn_s = ~$signed(c) ;
assign add_uu =         a  +         c ;
assign add_us =         a  + $signed(c);
assign add_su = $signed(a) +         c ;
assign add_ss = $signed(a) + $signed(c);
assign sub_uu =         a  -         c ;
assign sub_us =         a  - $signed(c);
assign sub_su = $signed(a) -         c ;
assign sub_ss = $signed(a) - $signed(c);
assign mul_uu =         a  *         c ;
assign mul_us =         a  * $signed(c);
assign mul_su = $signed(a) *         c ;
assign mul_ss = $signed(a) * $signed(c);
assign ltn_uu =         a  <         c ;
assign ltn_us =         a  < $signed(c);
assign ltn_su = $signed(a) <         c ;
assign ltn_ss = $signed(a) < $signed(c);
assign leq_uu =         a  <=         c ;
assign leq_us =         a  <= $signed(c);
assign leq_su = $signed(a) <=         c ;
assign leq_ss = $signed(a) <= $signed(c);
endmodule