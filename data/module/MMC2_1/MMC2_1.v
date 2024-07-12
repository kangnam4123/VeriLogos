module MMC2_1(input clk, input ce, input reset,
            input [31:0] flags,
            input [15:0] prg_ain, output [21:0] prg_aout,
            input prg_read, prg_write,                   
            input [7:0] prg_din,
            output prg_allow,                            
            input chr_read, input [13:0] chr_ain, output [21:0] chr_aout,
            output chr_allow,                      
            output vram_a10,                             
            output vram_ce);                             
  reg [3:0] prg_bank;
  reg   [4:0] chr_bank_0a;
   reg [4:0] chr_bank_0b;
  reg [4:0] chr_bank_1a;
  reg [4:0] chr_bank_1b; 
  reg mirroring;
  reg latch_0, latch_1;
  always @(posedge clk) if (ce) begin
    if (prg_write && prg_ain[15]) begin
      case(prg_ain[14:12])
      2: prg_bank <= prg_din[3:0];     
      3: chr_bank_0a <= prg_din[4:0];  
      4: chr_bank_0b <= prg_din[4:0];  
      5: chr_bank_1a <= prg_din[4:0];  
      6: chr_bank_1b <= prg_din[4:0];  
      7: mirroring <=  prg_din[0];     
      endcase
    end
  end
  always @(posedge clk) if (ce && chr_read) begin
    latch_0 <= (chr_ain & 14'h3ff8) == 14'h0fd8 ? 0 : (chr_ain & 14'h3ff8) == 14'h0fe8 ? 1 : latch_0;
    latch_1 <= (chr_ain & 14'h3ff8) == 14'h1fd8 ? 0 : (chr_ain & 14'h3ff8) == 14'h1fe8 ? 1 : latch_1;
  end
  reg [3:0] prgsel;
  always @* begin
    casez(prg_ain[14:13])
    2'b00:   prgsel = prg_bank;
    default: prgsel = {2'b11, prg_ain[14:13]};
    endcase
  end
  assign prg_aout = {5'b00_000, prgsel, prg_ain[12:0]};
  reg [4:0] chrsel;
  always @* begin
    casez({chr_ain[12], latch_0, latch_1})
    3'b00?: chrsel = chr_bank_0a;
    3'b01?: chrsel = chr_bank_0b;
    3'b1?0: chrsel = chr_bank_1a;
    3'b1?1: chrsel = chr_bank_1b;
    endcase
  end
  assign chr_aout = {5'b100_00, chrsel, chr_ain[11:0]};
  assign vram_a10 = mirroring ? chr_ain[11] : chr_ain[10];
  assign vram_ce = chr_ain[13];
  assign prg_allow = prg_ain[15] && !prg_write;
  assign chr_allow = flags[15];
endmodule