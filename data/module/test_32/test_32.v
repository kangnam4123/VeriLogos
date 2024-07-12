module test_32
  #(parameter pFOO = 7,
    parameter pBAR = 3,
    parameter pBAZ = ceiling(pFOO, pBAR)
    )
   (
    output [31:0] O_out
    );
   assign O_out = pBAZ;
   function integer ceiling;
      input [31:0] x, y;
      ceiling = ((x%y == 0) ? x/y : (x/y)+1) + 1;
   endfunction
endmodule