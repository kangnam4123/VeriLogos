module address_27(
  input CLK,
  input [7:0] featurebits,
  input [2:0] MAPPER,       
  input [23:0] SNES_ADDR,   
  input [7:0] SNES_PA,      
  output [23:0] ROM_ADDR,   
  output ROM_HIT,           
  output IS_SAVERAM,        
  output IS_ROM,            
  output IS_WRITABLE,       
  input [23:0] SAVERAM_MASK,
  input [23:0] ROM_MASK,
  output msu_enable,
  output cx4_enable,
  output cx4_vect_enable,
  output r213f_enable,
  output snescmd_enable
);
parameter [2:0]
  FEAT_MSU1 = 3,
  FEAT_213F = 4
;
wire [23:0] SRAM_SNES_ADDR;
assign IS_ROM = ((!SNES_ADDR[22] & SNES_ADDR[15])
                 |(SNES_ADDR[22]));
assign IS_SAVERAM = |SAVERAM_MASK & (&SNES_ADDR[22:20] & ~SNES_ADDR[15] & (SNES_ADDR[19:16] < 4'b1110));
assign SRAM_SNES_ADDR = IS_SAVERAM
                        ? (24'hE00000 | ({SNES_ADDR[19:16], SNES_ADDR[14:0]} 
                         & SAVERAM_MASK))
                        : ({2'b00, SNES_ADDR[22:16], SNES_ADDR[14:0]}
                         & ROM_MASK);
assign ROM_ADDR = SRAM_SNES_ADDR;
assign IS_WRITABLE = IS_SAVERAM;
assign ROM_HIT = IS_ROM | IS_WRITABLE;
wire msu_enable_w = featurebits[FEAT_MSU1] & (!SNES_ADDR[22] && ((SNES_ADDR[15:0] & 16'hfff8) == 16'h2000));
assign msu_enable = msu_enable_w;
wire cx4_enable_w = (!SNES_ADDR[22] && (SNES_ADDR[15:13] == 3'b011));
assign cx4_enable = cx4_enable_w;
assign cx4_vect_enable = &SNES_ADDR[15:5];
assign r213f_enable = featurebits[FEAT_213F] & (SNES_PA == 9'h3f);
assign snescmd_enable = ({SNES_ADDR[22], SNES_ADDR[15:9]} == 8'b0_0010101);
endmodule