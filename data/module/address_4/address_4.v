module address_4(
  input CLK,
  input [7:0] featurebits,  
  input [2:0] MAPPER,       
  input [23:0] SNES_ADDR,   
  input [7:0] SNES_PA,      
  input SNES_ROMSEL,        
  output [23:0] MAPPED_ADDR,
  output SRAM0_HIT,         
  output SRAM1_HIT,         
  output IS_SAVERAM,        
  output IS_GAMEPAKRAM,     
  output IS_ROM,            
  output IS_WRITABLE,       
  input [23:0] SAVERAM_MASK,
  input [23:0] ROM_MASK,
  output msu_enable,
  output gsu_enable,
  output r213f_enable,
  output snescmd_enable,
  output nmicmd_enable,
  output return_vector_enable,
  output branch1_enable,
  output branch2_enable
);
parameter [2:0]
  FEAT_MSU1 = 3,
  FEAT_213F = 4
;
wire [23:0] SRAM_SNES_ADDR;
assign IS_ROM = ((~|SNES_ADDR[23:22] & SNES_ADDR[15])
                 |(!SNES_ADDR[23] & SNES_ADDR[22] & !SNES_ADDR[21]));
assign IS_SAVERAM = SAVERAM_MASK[0] & (!SNES_ADDR[23] & &SNES_ADDR[22:20] & SNES_ADDR[19] & ~|SNES_ADDR[18:17]);
assign IS_GAMEPAKRAM = ((~|SNES_ADDR[22:20] & (SNES_ADDR[15:13] == 3'b011))
                        |(&SNES_ADDR[22:20] & ~|SNES_ADDR[19:17]));
assign IS_WRITABLE = IS_SAVERAM | IS_GAMEPAKRAM;
assign SRAM_SNES_ADDR = IS_SAVERAM
                        ? (24'hE00000 | SNES_ADDR[16:0] & SAVERAM_MASK)
                        : (IS_ROM
                           ? (~|SNES_ADDR[23:22] & SNES_ADDR[15])
                              ? 
                                ({3'b000, SNES_ADDR[21:16], SNES_ADDR[14:0]} & ROM_MASK)
                              : 
                                ({3'b000, SNES_ADDR[20:0]} & ROM_MASK)
                           : (IS_GAMEPAKRAM
                              ? (~|SNES_ADDR[22:20] & (SNES_ADDR[15:13] == 3'b011))
                                 ? 
                                   ({7'b1100000, SNES_ADDR[19:16], SNES_ADDR[12:0]})
                                 : 
                                   ({7'b1100000, SNES_ADDR[16:0]})
                              : SNES_ADDR));
assign MAPPED_ADDR = SRAM_SNES_ADDR;
assign SRAM0_HIT = IS_ROM | (!IS_GAMEPAKRAM & IS_WRITABLE);
assign SRAM1_HIT = IS_GAMEPAKRAM;
assign msu_enable = featurebits[FEAT_MSU1] & (!SNES_ADDR[22] && ((SNES_ADDR[15:0] & 16'hfff8) == 16'h2000));
wire gsu_enable_w = (!SNES_ADDR[22] & (SNES_ADDR[15:10] == 6'b001100) & (!SNES_ADDR[9] | !SNES_ADDR[8]));
assign gsu_enable = gsu_enable_w;
assign r213f_enable = featurebits[FEAT_213F] & (SNES_PA == 8'h3f);
assign snescmd_enable = ({SNES_ADDR[22], SNES_ADDR[15:9]} == 8'b0_0010101);
assign nmicmd_enable = (SNES_ADDR == 24'h002BF2);
assign return_vector_enable = (SNES_ADDR == 24'h002A5A);
assign branch1_enable = (SNES_ADDR == 24'h002A13);
assign branch2_enable = (SNES_ADDR == 24'h002A4D);
endmodule