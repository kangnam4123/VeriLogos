module prim(output reg Q, input D, C);
   always @(posedge C)
     Q <= D;
endmodule