module sctag_retbuf(
   retdp_data_c7, retdp_ecc_c7, 
   retdp_data_c7_buf, retdp_ecc_c7_buf
   );
output  [127:0]  retdp_data_c7;
output  [ 27:0]  retdp_ecc_c7;
input  [127:0]  retdp_data_c7_buf;
input  [ 27:0]  retdp_ecc_c7_buf;
assign	retdp_data_c7 = retdp_data_c7_buf ;
assign	retdp_ecc_c7 = retdp_ecc_c7_buf ;
endmodule