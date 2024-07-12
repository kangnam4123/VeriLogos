module fj_latch_e(Q, G, D);
output Q; 
input  G, D;
       reg Q;
always @ (G or D) begin
       if (G==1)     Q <= #1 D;
end
endmodule