module Mapper41(input clk, input ce, input reset,
                input [31:0] flags,
                input [15:0] prg_ain, output [21:0] prg_aout,
                input prg_read, prg_write,                   
                input [7:0] prg_din,
                output prg_allow,                            
                input [13:0] chr_ain, output [21:0] chr_aout,
                output chr_allow,                      
                output vram_a10,                             
                output vram_ce);                             
  reg [2:0] prg_bank;
  reg [1:0] chr_outer_bank, chr_inner_bank;
  reg mirroring;
  always @(posedge clk) if (reset) begin
    prg_bank <= 0;
    chr_outer_bank <= 0;
    chr_inner_bank <= 0;
    mirroring <= 0;
  end else if (ce && prg_write) begin
    if (prg_ain[15:11] == 5'b01100) begin
      {mirroring, chr_outer_bank, prg_bank} <= prg_ain[5:0];
    end else if (prg_ain[15] && prg_bank[2]) begin
      chr_inner_bank <= prg_din[1:0];
    end
  end
  assign prg_aout = {4'b00_00, prg_bank, prg_ain[14:0]};
  assign chr_allow = flags[15];
  assign chr_aout = {5'b10_000, chr_outer_bank, chr_inner_bank, chr_ain[12:0]};
  assign vram_ce = chr_ain[13];
  assign vram_a10 = mirroring ? chr_ain[11] : chr_ain[10];
  assign prg_allow = prg_ain[15] && !prg_write;
endmodule