module soc_system_sysid_qsys_3 (
                address,
                clock,
                reset_n,
                readdata
             )
;
  output  [ 31: 0] readdata;
  input            address;
  input            clock;
  input            reset_n;
  wire    [ 31: 0] readdata;
  assign readdata = address ? 1481413105 : 2899645186;
endmodule