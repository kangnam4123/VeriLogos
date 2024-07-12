module soc_design_dma_0_fifo_module_fifo_ram_module (
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
  output  [ 31: 0] q;
  input            clk;
  input   [ 31: 0] data;
  input   [  9: 0] rdaddress;
  input            rdclken;
  input            reset_n;
  input   [  9: 0] wraddress;
  input            wrclock;
  input            wren;
  reg     [ 31: 0] mem_array [1023: 0];
  wire    [ 31: 0] q;
  reg     [  9: 0] read_address;
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