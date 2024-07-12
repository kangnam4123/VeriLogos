module Pad
  (inout pad,
   input ena,
   input data);
   assign pad = ena ? data : 1'bz;
endmodule