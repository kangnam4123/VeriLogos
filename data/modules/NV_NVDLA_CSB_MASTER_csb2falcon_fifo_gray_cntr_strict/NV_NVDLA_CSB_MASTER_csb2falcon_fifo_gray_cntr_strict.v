module NV_NVDLA_CSB_MASTER_csb2falcon_fifo_gray_cntr_strict (
`ifdef NV_FPGA_FIFOGEN
      inc ,
`endif
      gray
    , gray_next
    );
`ifdef NV_FPGA_FIFOGEN
input inc;
`endif
input [1:0] gray;
output [1:0] gray_next;
wire polarity; 
assign polarity = gray[0] ^ gray[1];
assign gray_next =
`ifdef NV_FPGA_FIFOGEN
 (~inc) ? gray :
`endif
                         { gray[1]^(polarity ),
                         gray[0]^(~polarity) };
endmodule