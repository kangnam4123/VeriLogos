module cpx_databuf_ca(
   sctag_cpx_data_buf_pa, 
   sctag_cpx_data_pa
   );
   output [144:0]  sctag_cpx_data_buf_pa;
   input  [144:0]  sctag_cpx_data_pa;
   assign sctag_cpx_data_buf_pa = sctag_cpx_data_pa;
endmodule