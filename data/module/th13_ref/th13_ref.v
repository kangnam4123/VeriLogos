module th13_ref (y,a,b,c);
 output y;
 input a;
 input b;
 input c;
 assign  #1 y =  a | b | c;
endmodule