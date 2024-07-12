module soc_design_General_DMA_fifo_module_fifo_ram_module (
                                                             clk,
                                                             data,
                                                             rdaddress,
                                                             rdclken,
                                                             reset_n,
                                                             wraddress,
                                                             wrclock,
                                                             wren,
                                                             q
                                                          )
;
  output  [ 15: 0] q;
  input            clk;
  input   [ 15: 0] data;
  input   [  8: 0] rdaddress;
  input            rdclken;
  input            reset_n;
  input   [  8: 0] wraddress;
  input            wrclock;
  input            wren;
  reg     [ 15: 0] mem_array [511: 0];
  wire    [ 15: 0] q;
  reg     [  8: 0] read_address;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          read_address <= 0;
      else if (rdclken)
          read_address <= rdaddress;
    end
  assign q = mem_array[read_address];
  always @(posedge wrclock)
    begin
      if (wren)
          mem_array[wraddress] <= data;
    end
endmodule