module bug34575;
   wire a,b,c,d;
   assign #(0,0)         a = 1;
   assign #(0:1:2)       b = 1;
   assign #(0:1:2,0:1:2) c = 1;
   assign #(0:1:2,0)     d = 1;
endmodule