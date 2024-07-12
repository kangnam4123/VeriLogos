module ulight_fifo_data_flag_rx (
                                   address,
                                   clk,
                                   in_port,
                                   reset_n,
                                   readdata
                                )
;
  output  [ 31: 0] readdata;
  input   [  1: 0] address;
  input            clk;
  input   [  8: 0] in_port;
  input            reset_n;
wire             clk_en;
wire    [  8: 0] data_in;
wire    [  8: 0] read_mux_out;
reg     [ 31: 0] readdata;
  assign clk_en = 1;
  assign read_mux_out = {9 {(address == 0)}} & data_in;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          readdata <= 0;
      else if (clk_en)
          readdata <= {32'b0 | read_mux_out};
    end
  assign data_in = in_port;
endmodule