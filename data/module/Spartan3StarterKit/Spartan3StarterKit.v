module Spartan3StarterKit(
    CLK50MHZ,
    SOCKET,
    SRAM_A,
    SRAM_WE_X,
    SRAM_OE_X,
    SRAM_IO_A,
    SRAM_CE_A_X,
    SRAM_LB_A_X,
    SRAM_UB_A_X,
    SRAM_IO_B,
    SRAM_CE_B_X,
    SRAM_LB_B_X,
    SRAM_UB_B_X,
    LED_AN,
    LED_A,
    LED_B,
    LED_C,
    LED_D,
    LED_E,
    LED_F,
    LED_G,
    LED_DP,
    SW,
    BTN,
    LD,
    VGA_R,
    VGA_G,
    VGA_B,
    VGA_HS,
    VGA_VS,
    PS2C,
    PS2D,
    RXD,
    TXD,
    RXDA,
    TXDA,
    DIN,
    INIT_B,
    RCLK);
  input         CLK50MHZ;
  input         SOCKET;
  output [17:0] SRAM_A;
  output        SRAM_WE_X;
  output        SRAM_OE_X;
  inout  [15:0] SRAM_IO_A;
  output        SRAM_CE_A_X;
  output        SRAM_LB_A_X;
  output        SRAM_UB_A_X;
  inout  [15:0] SRAM_IO_B;
  output        SRAM_CE_B_X;
  output        SRAM_LB_B_X;
  output        SRAM_UB_B_X;
  output [ 3:0] LED_AN;
  output        LED_A;
  output        LED_B;
  output        LED_C;
  output        LED_D;
  output        LED_E;
  output        LED_F;
  output        LED_G;
  output        LED_DP;
  input  [ 7:0] SW;
  input  [ 3:0] BTN;
  output [ 7:0] LD;
  output        VGA_R;
  output        VGA_G;
  output        VGA_B;
  output        VGA_HS;
  output        VGA_VS;
  input         PS2C;
  input         PS2D;
  input         RXD;
  output        TXD;
  input         RXDA;
  output        TXDA;
  input         DIN;
  output        INIT_B;
  output        RCLK;
  assign SRAM_A      = 18'h00000;
  assign SRAM_WE_X   = 1'b0;
  assign SRAM_OE_X   = 1'b1;
  assign SRAM_IO_A   = 16'hffff;
  assign SRAM_CE_A_X = 1'b1;
  assign SRAM_LB_A_X = 1'b1;
  assign SRAM_UB_A_X = 1'b1;
  assign SRAM_IO_B   = 16'hffff;
  assign SRAM_CE_B_X = 1'b1;
  assign SRAM_LB_B_X = 1'b1;
  assign SRAM_UB_B_X = 1'b1;
  assign LED_AN      = 4'b1111;
  assign LED_A       = 1'b1;
  assign LED_B       = 1'b1;
  assign LED_C       = 1'b1;
  assign LED_D       = 1'b1;
  assign LED_E       = 1'b1;
  assign LED_F       = 1'b1;
  assign LED_G       = 1'b1;
  assign LED_DP      = 1'b1;
  assign LD          = SW | { 1'b0, BTN, PS2D, PS2C, SOCKET };
  assign VGA_R       = 1'b0;
  assign VGA_G       = 1'b0;
  assign VGA_B       = 1'b0;
  assign VGA_HS      = 1'b1;
  assign VGA_VS      = 1'b1;
  assign TXD         = RXD;
  assign TXDA        = RXDA;
  assign INIT_B      = DIN;
  assign RCLK        = DIN;
endmodule