module altera_avalon_sysid_qsys #(
    parameter ID_VALUE   = 1,
    parameter TIMESTAMP  = 1
)(
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
  assign readdata = address ? TIMESTAMP : ID_VALUE;
endmodule