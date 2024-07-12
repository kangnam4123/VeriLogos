module address_1(
  input CLK,
  input [15:0] featurebits, 
  input [2:0] MAPPER,       
  input [23:0] SNES_ADDR,   
  input [7:0] SNES_PA,      
  input SNES_ROMSEL,        
  output [23:0] ROM_ADDR,   
  output ROM_HIT,           
  output IS_SAVERAM,        
  output IS_ROM,            
  output IS_WRITABLE,       
  input [23:0] SAVERAM_MASK,
  input [23:0] ROM_MASK,
  output msu_enable,
  output r213f_enable,
  output r2100_hit,
  output snescmd_enable,
  output nmicmd_enable,
  output return_vector_enable,
  output branch1_enable,
  output branch2_enable,
  output branch3_enable,
  output obc1_enable
);
parameter [2:0]
  FEAT_MSU1 = 3,
  FEAT_213F = 4
;
wire [23:0] SRAM_SNES_ADDR;
assign IS_ROM = ~SNES_ROMSEL;
assign IS_SAVERAM = SAVERAM_MASK[0]
                    &(((MAPPER == 3'b000
                     || MAPPER == 3'b010)
                      ? (!SNES_ADDR[22]
                         & SNES_ADDR[21]
                         & &SNES_ADDR[14:13]
                         & !SNES_ADDR[15]
                        )
                      :(MAPPER == 3'b001)
                      ? (&SNES_ADDR[22:20]
                         & (~SNES_ROMSEL)
                         & (~SNES_ADDR[15] | ~ROM_MASK[21])
                        )
                      : 1'b0));
assign IS_WRITABLE = IS_SAVERAM;
assign SRAM_SNES_ADDR = ((MAPPER == 3'b000)
                          ?(IS_SAVERAM
                            ? 24'hE00000 + ({SNES_ADDR[20:16], SNES_ADDR[12:0]}
                                            & SAVERAM_MASK)
                            : ({1'b0, SNES_ADDR[22:0]} & ROM_MASK))
                        :(MAPPER == 3'b001)
                          ?(IS_SAVERAM
                            ? 24'hE00000 + ({SNES_ADDR[20:16], SNES_ADDR[14:0]}
                                            & SAVERAM_MASK)
                            : ({2'b00, SNES_ADDR[22:16], SNES_ADDR[14:0]}
                               & ROM_MASK))
                        :(MAPPER == 3'b010)
                          ?(IS_SAVERAM
                            ? 24'hE00000 + ({SNES_ADDR[20:16], SNES_ADDR[12:0]}
                                            & SAVERAM_MASK)
                            : ({1'b0, !SNES_ADDR[23], SNES_ADDR[21:0]}
                               & ROM_MASK))
                        : 24'b0);
assign ROM_ADDR = SRAM_SNES_ADDR;
assign ROM_SEL = 1'b0;
assign ROM_HIT = IS_ROM | IS_WRITABLE;
assign msu_enable = featurebits[FEAT_MSU1] & (!SNES_ADDR[22] && ((SNES_ADDR[15:0] & 16'hfff8) == 16'h2000));
assign r213f_enable = featurebits[FEAT_213F] & (SNES_PA == 8'h3f);
assign r2100_hit = (SNES_PA == 8'h00);
assign obc1_enable = (~SNES_ADDR[22]) & (SNES_ADDR[15:11] == 5'b01111);
assign snescmd_enable = ({SNES_ADDR[22], SNES_ADDR[15:9]} == 8'b0_0010101);
assign nmicmd_enable = (SNES_ADDR == 24'h002BF2);
assign return_vector_enable = (SNES_ADDR == 24'h002A6C);
assign branch1_enable = (SNES_ADDR == 24'h002A1F);
assign branch2_enable = (SNES_ADDR == 24'h002A59);
assign branch3_enable = (SNES_ADDR == 24'h002A5E);
endmodule