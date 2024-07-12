module util_ccat (
  data_0,
  data_1,
  data_2,
  data_3,
  data_4,
  data_5,
  data_6,
  data_7,
  ccat_data);
  parameter   CH_DW     = 1;
  parameter   CH_CNT    = 8;
  localparam  CH_MCNT   = 8;
  input   [(CH_DW-1):0]             data_0;
  input   [(CH_DW-1):0]             data_1;
  input   [(CH_DW-1):0]             data_2;
  input   [(CH_DW-1):0]             data_3;
  input   [(CH_DW-1):0]             data_4;
  input   [(CH_DW-1):0]             data_5;
  input   [(CH_DW-1):0]             data_6;
  input   [(CH_DW-1):0]             data_7;
  output  [((CH_CNT*CH_DW)-1):0]    ccat_data;
  wire    [((CH_MCNT*CH_DW)-1):0]   data_s;
  assign data_s[((CH_DW*1)-1):(CH_DW*0)] = data_0;
  assign data_s[((CH_DW*2)-1):(CH_DW*1)] = data_1;
  assign data_s[((CH_DW*3)-1):(CH_DW*2)] = data_2;
  assign data_s[((CH_DW*4)-1):(CH_DW*3)] = data_3;
  assign data_s[((CH_DW*5)-1):(CH_DW*4)] = data_4;
  assign data_s[((CH_DW*6)-1):(CH_DW*5)] = data_5;
  assign data_s[((CH_DW*7)-1):(CH_DW*6)] = data_6;
  assign data_s[((CH_DW*8)-1):(CH_DW*7)] = data_7;
  assign ccat_data = data_s[((CH_CNT*CH_DW)-1):0];
endmodule