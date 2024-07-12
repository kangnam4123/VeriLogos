module onebitadder(x,y,sum,carryout,carryin);
input x,y,carryin;
output sum,carryout;
xor XOR1(p,x,y);
xor XOR2(sum,p,carryin);
and ANDp(q,p,carryin);
and ANDxy(r,x,y);
or ORing(carryout,q,r);
endmodule