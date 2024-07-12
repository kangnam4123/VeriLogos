module DFF_8(output reg Q, input D, input C);
   always @(posedge C)
     Q <= D;
endmodule