module slice_typeuint8_4_1__3_1__xl0_xh1_yl0_yh0(input CLK, input process_CE, input [95:0] inp, output [63:0] process_output);
parameter INSTANCE_NAME="INST";
  assign process_output = {({inp[63:32]}),({inp[31:0]})};
endmodule