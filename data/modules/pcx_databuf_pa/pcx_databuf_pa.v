module pcx_databuf_pa(
   spc_pcx_data_buf_pa, spc_pcx_data_buf_rdy, 
   spc_pcx_data_pa, spc_pcx_data_rdy
   );
   output [123:0]spc_pcx_data_buf_pa;
   output        spc_pcx_data_buf_rdy;
   input [123:0]spc_pcx_data_pa;
   input        spc_pcx_data_rdy;
   assign spc_pcx_data_buf_pa = spc_pcx_data_pa;
   assign spc_pcx_data_buf_rdy  =  spc_pcx_data_rdy;
endmodule