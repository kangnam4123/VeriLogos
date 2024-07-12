module soc_system_sysid_qsys_6 (
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
  assign readdata = address ? 1494168071 : 2899645186;
endmodule