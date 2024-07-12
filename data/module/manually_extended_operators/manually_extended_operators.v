module manually_extended_operators(
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
assign mux_uu = sel ? {{8{1'b0}}, a} : {{8{1'b0}}, b};
assign mux_us = sel ? {{8{1'b0}}, a} : {{8{1'b0}}, b};
assign mux_su = sel ? {{8{1'b0}}, a} : {{8{1'b0}}, b};
assign mux_ss = sel ? {{8{a[7]}}, a} : {{8{b[7]}}, b};
assign eql_uu = {a} == {{2{1'b0}}, c};
assign eql_us = {a} == {{2{1'b0}}, c};
assign eql_su = {a} == {{2{1'b0}}, c};
assign eql_ss = {a} == {{2{c[5]}}, c};
assign neq_uu = {a} != {{2{1'b0}}, c};
assign neq_us = {a} != {{2{1'b0}}, c};
assign neq_su = {a} != {{2{1'b0}}, c};
assign neq_ss = {a} != {{2{c[5]}}, c};
assign sgn_u = ~{{10{1'b0}}, c} ;
assign sgn_s = ~{{10{c[5]}}, c} ;
assign add_uu = {{8{1'b0}}, a} + {{10{1'b0}}, c};
assign add_us = {{8{1'b0}}, a} + {{10{1'b0}}, c};
assign add_su = {{8{1'b0}}, a} + {{10{1'b0}}, c};
assign add_ss = {{8{a[7]}}, a} + {{10{c[5]}}, c};
assign sub_uu = {{8{1'b0}}, a} - {{10{1'b0}}, c};
assign sub_us = {{8{1'b0}}, a} - {{10{1'b0}}, c};
assign sub_su = {{8{1'b0}}, a} - {{10{1'b0}}, c};
assign sub_ss = {{8{a[7]}}, a} - {{10{c[5]}}, c};
assign mul_uu = {{8{1'b0}}, a} * {{10{1'b0}}, c};
assign mul_us = {{8{1'b0}}, a} * {{10{1'b0}}, c};
assign mul_su = {{8{1'b0}}, a} * {{10{1'b0}}, c};
assign mul_ss = {{8{a[7]}}, a} * {{10{c[5]}}, c};
assign ltn_uu = {{8{1'b0}}, a} < {{10{1'b0}}, c};
assign ltn_us = {{8{1'b0}}, a} < {{10{1'b0}}, c};
assign ltn_su = {{8{1'b0}}, a} < {{10{1'b0}}, c};
assign ltn_ss = {c[5],{7{a[7]}}, a} < {a[7],{9{c[5]}}, c};
assign leq_uu = {{8{1'b0}}, a} <= {{10{1'b0}}, c};
assign leq_us = {{8{1'b0}}, a} <= {{10{1'b0}}, c};
assign leq_su = {{8{1'b0}}, a} <= {{10{1'b0}}, c};
assign leq_ss = {c[5],{7{a[7]}}, a} <= {a[7],{9{c[5]}}, c};
endmodule