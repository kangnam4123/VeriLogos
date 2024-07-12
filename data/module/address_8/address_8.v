module address_8(
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
  input [4:0] sa1_bmaps_sbm,
  input  sa1_dma_cc1_en,
  input [11:0] sa1_xxb,
  input [3:0] sa1_xxb_en,
  output r213f_enable,
  output r2100_hit,
  output snescmd_enable,
  output nmicmd_enable,
  output return_vector_enable,
  output branch1_enable,
  output branch2_enable,
  output branch3_enable,
  output sa1_enable
);
parameter [2:0]
  FEAT_MSU1 = 3,
  FEAT_213F = 4,
  FEAT_2100 = 6
 ;
reg [23:0] ROM_MASK_r     = 0;
reg [23:0] SAVERAM_MASK_r = 0;
reg        iram_battery_r = 0;
always @(posedge CLK) begin
  ROM_MASK_r     <= ROM_MASK;
  SAVERAM_MASK_r <= SAVERAM_MASK;
  iram_battery_r <= ~SAVERAM_MASK_r[1] & SAVERAM_MASK_r[0];
end
wire [23:0] SRAM_SNES_ADDR;
wire [2:0] xxb[3:0];
assign {xxb[3], xxb[2], xxb[1], xxb[0]} = sa1_xxb;
wire [3:0] xxb_en = sa1_xxb_en;
assign IS_ROM = ~SNES_ROMSEL;
assign IS_SAVERAM = SAVERAM_MASK_r[0]
                    & ( 
                        ( ~SNES_ADDR[23]
                        &  SNES_ADDR[22]
                        & ~SNES_ADDR[21]
                        & ~SNES_ADDR[20]
                        & ~sa1_dma_cc1_en
                        )
                      | ( ~SNES_ADDR[22]
                        & ~SNES_ADDR[15]
                        & &SNES_ADDR[14:13]
                        )
                      | ( iram_battery_r
                        & ~SNES_ADDR[22]
                        & ~SNES_ADDR[15]
                        & ~SNES_ADDR[14]
                        &  SNES_ADDR[13]
                        &  SNES_ADDR[12]
                        & ~SNES_ADDR[11]
                        )
                      );
assign IS_WRITABLE = IS_SAVERAM;
assign SRAM_SNES_ADDR = (IS_SAVERAM
                         ? (24'hE00000 + (iram_battery_r ? SNES_ADDR[10:0] : ((SNES_ADDR[22] ? SNES_ADDR[19:0] : {sa1_bmaps_sbm,SNES_ADDR[12:0]}) & SAVERAM_MASK_r)))
                         : ((SNES_ADDR[22] ? {1'b0, xxb[SNES_ADDR[21:20]], SNES_ADDR[19:0]} : {1'b0, (xxb_en[{SNES_ADDR[23],SNES_ADDR[21]}] ? xxb[{SNES_ADDR[23],SNES_ADDR[21]}] : {1'b0,SNES_ADDR[23],SNES_ADDR[21]}), SNES_ADDR[20:16], SNES_ADDR[14:0]}) & ROM_MASK_r)
                         );
assign ROM_ADDR = SRAM_SNES_ADDR;
assign ROM_HIT = IS_ROM | IS_WRITABLE;
assign msu_enable = featurebits[FEAT_MSU1] & (!SNES_ADDR[22] && ((SNES_ADDR[15:0] & 16'hfff8) == 16'h2000));
assign r213f_enable = featurebits[FEAT_213F] & (SNES_PA == 8'h3f);
assign r2100_hit = (SNES_PA == 8'h00);
assign snescmd_enable = ({SNES_ADDR[22], SNES_ADDR[15:9]} == 8'b0_0010101);
assign nmicmd_enable = (SNES_ADDR == 24'h002BF2);
assign return_vector_enable = (SNES_ADDR == 24'h002A6C);
assign branch1_enable = (SNES_ADDR == 24'h002A1F);
assign branch2_enable = (SNES_ADDR == 24'h002A59);
assign branch3_enable = (SNES_ADDR == 24'h002A5E);
endmodule