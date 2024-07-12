module nios_system_nios2_qsys_0_nios2_oci_pib_1 (
                                                 tw,
                                                 tr_data
                                              )
;
  output  [ 35: 0] tr_data;
  input   [ 35: 0] tw;
  wire    [ 35: 0] tr_data;
  assign tr_data = 0 ? tw : 0;
endmodule