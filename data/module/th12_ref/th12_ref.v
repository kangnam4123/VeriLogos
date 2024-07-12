module th12_ref (y,a,b);
 output y;
 input a;
 input b;
 assign  #1 y =  a | b;
endmodule