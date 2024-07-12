module nios_tester_pio_1 (
                            address,
                            chipselect,
                            clk,
                            in_port,
                            reset_n,
                            write_n,
                            writedata,
                            out_port,
                            readdata
                         )
;
  output  [ 31: 0] out_port;
  output  [ 31: 0] readdata;
  input   [  2: 0] address;
  input            chipselect;
  input            clk;
  input   [ 31: 0] in_port;
  input            reset_n;
  input            write_n;
  input   [ 31: 0] writedata;
wire             clk_en;
wire    [ 31: 0] data_in;
reg     [ 31: 0] data_out;
wire    [ 31: 0] out_port;
wire    [ 31: 0] read_mux_out;
reg     [ 31: 0] readdata;
wire             wr_strobe;
  assign clk_en = 1;
  assign read_mux_out = {32 {(address == 0)}} & data_in;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          readdata <= 0;
      else if (clk_en)
          readdata <= {32'b0 | read_mux_out};
    end
  assign wr_strobe = chipselect && ~write_n;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_out <= 0;
      else if (clk_en)
          if (wr_strobe)
              data_out <= (address == 5)? data_out & ~writedata[31 : 0]: (address == 4)? data_out | writedata[31 : 0]: (address == 0)? writedata[31 : 0]: data_out;
    end
  assign out_port = data_out;
  assign data_in = in_port;
endmodule