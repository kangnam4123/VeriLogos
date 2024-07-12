module soc_design_SystemID_15 (
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
  assign readdata = address ? 1504770410 : 255;
endmodule