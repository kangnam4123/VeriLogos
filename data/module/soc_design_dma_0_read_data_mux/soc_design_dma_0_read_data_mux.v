module soc_design_dma_0_read_data_mux (
                                         byte_access,
                                         clk,
                                         clk_en,
                                         dma_ctl_address,
                                         dma_ctl_chipselect,
                                         dma_ctl_write_n,
                                         dma_ctl_writedata,
                                         hw,
                                         read_readdata,
                                         read_readdatavalid,
                                         readaddress,
                                         readaddress_inc,
                                         reset_n,
                                         word,
                                         fifo_wr_data
                                      )
;
  output  [ 31: 0] fifo_wr_data;
  input            byte_access;
  input            clk;
  input            clk_en;
  input   [  2: 0] dma_ctl_address;
  input            dma_ctl_chipselect;
  input            dma_ctl_write_n;
  input   [ 14: 0] dma_ctl_writedata;
  input            hw;
  input   [ 31: 0] read_readdata;
  input            read_readdatavalid;
  input   [ 10: 0] readaddress;
  input   [  4: 0] readaddress_inc;
  input            reset_n;
  input            word;
  wire             control_write;
  wire    [ 31: 0] fifo_wr_data;
  wire             length_write;
  wire    [  1: 0] read_data_mux_input;
  reg     [  1: 0] readdata_mux_select;
  assign control_write = dma_ctl_chipselect & ~dma_ctl_write_n & ((dma_ctl_address == 6) || (dma_ctl_address == 7));
  assign length_write = dma_ctl_chipselect & ~dma_ctl_write_n & (dma_ctl_address == 3);
  assign read_data_mux_input = ((control_write && dma_ctl_writedata[3] || length_write))? readaddress[1 : 0] :
    (read_readdatavalid)? (readdata_mux_select + readaddress_inc) :
    readdata_mux_select;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          readdata_mux_select <= 0;
      else if (clk_en)
          readdata_mux_select <= read_data_mux_input[1 : 0];
    end
  assign fifo_wr_data[31 : 16] = read_readdata[31 : 16];
  assign fifo_wr_data[15 : 8] = ({8 {(hw & (readdata_mux_select[1] == 0))}} & read_readdata[15 : 8]) |
    ({8 {(hw & (readdata_mux_select[1] == 1))}} & read_readdata[31 : 24]) |
    ({8 {word}} & read_readdata[15 : 8]);
  assign fifo_wr_data[7 : 0] = ({8 {(byte_access & (readdata_mux_select[1 : 0] == 0))}} & read_readdata[7 : 0]) |
    ({8 {(byte_access & (readdata_mux_select[1 : 0] == 1))}} & read_readdata[15 : 8]) |
    ({8 {(byte_access & (readdata_mux_select[1 : 0] == 2))}} & read_readdata[23 : 16]) |
    ({8 {(byte_access & (readdata_mux_select[1 : 0] == 3))}} & read_readdata[31 : 24]) |
    ({8 {(hw & (readdata_mux_select[1] == 0))}} & read_readdata[7 : 0]) |
    ({8 {(hw & (readdata_mux_select[1] == 1))}} & read_readdata[23 : 16]) |
    ({8 {word}} & read_readdata[7 : 0]);
endmodule