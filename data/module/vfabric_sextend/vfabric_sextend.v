module vfabric_sextend(clock, resetn, 
    i_datain, i_datain_valid, o_datain_stall, 
    o_dataout, i_dataout_stall, o_dataout_valid);
parameter DATAIN_WIDTH = 32;
parameter DATAOUT_WIDTH = 64;
  input clock, resetn;
  input [DATAIN_WIDTH-1:0] i_datain;
  input i_datain_valid;
  output o_datain_stall;
  output [DATAOUT_WIDTH-1:0] o_dataout;
  input i_dataout_stall;
  output o_dataout_valid;
  assign o_dataout = {{DATAOUT_WIDTH{i_datain[DATAIN_WIDTH-1]}}, i_datain[DATAIN_WIDTH-1:0]};
  assign o_datain_stall = i_dataout_stall;
  assign o_dataout_valid = i_datain_valid;
endmodule