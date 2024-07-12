module Mapper13(input clk, input ce, input reset,
                input [31:0] flags,
                input [15:0] prg_ain, output [21:0] prg_aout,
                input prg_read, prg_write,                   
                input [7:0] prg_din,
                output prg_allow,                            
                input [13:0] chr_ain, output [21:0] chr_aout,
                output chr_allow,                      
                output vram_a10,                             
                output vram_ce);                             
  reg [1:0] chr_bank;
  always @(posedge clk) if (reset) begin
    chr_bank <= 0;
  end else if (ce) begin
    if (prg_ain[15] && prg_write)
      chr_bank <= prg_din[1:0];
  end
  assign prg_aout = {7'b00_0000_0, prg_ain[14:0]};
  assign prg_allow = prg_ain[15] && !prg_write;
  assign chr_allow = flags[15];
  assign chr_aout = {8'b01_0000_00, chr_ain[12] ? chr_bank : 2'b00, chr_ain[11:0]};
  assign vram_ce = chr_ain[13];
  assign vram_a10 = flags[14] ? chr_ain[10] : chr_ain[11];
endmodule