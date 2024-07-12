module child_2(input sel, input A, inout Z);
  assign Z = (sel) ? A : 1'bz;
endmodule