module soc_design_SystemID_7 (
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
  assign readdata = address ? 1501038747 : 255;
endmodule