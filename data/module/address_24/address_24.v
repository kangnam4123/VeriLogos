module address_24(
  input CLK,
  input SNES_ROMSEL,
  input [23:0] SNES_ADDR,   
  output [23:0] ram0_addr,
  output [7:0] PA_addr,
  output [12:0] bram_addr,
  input ram0_linear,
  output ram0_enable,
  output PA_enable,
  output bram_enable,
  output irq_enable,
  output linear_enable,
  output linear_enable2
);
wire [23:0] SRAM_SNES_ADDR;
assign ram0bank0_enable =  (SNES_ADDR[15] | ~SNES_ROMSEL); 
assign ram0linear_enable = ram0_linear & (SNES_ADDR[22] | SNES_ADDR[15] | ~SNES_ROMSEL);
assign ram0_enable = ram0linear_enable | ram0bank0_enable; 
assign PA_enable = ~ram0linear_enable & (SNES_ADDR[10:8] == 3'b110); 
assign bram_enable = ~ram0linear_enable & (SNES_ADDR[10:5] == 6'b111_000); 
wire irq_enable_ = ~ram0linear_enable & (SNES_ADDR[10:0] == 11'h722); 
wire linear_enable_ = (SNES_ADDR[10:0] == 11'h733); 
wire linear_enable2_ = (SNES_ADDR[10:0] == 11'h734); 
reg [2:0] irq_enable_r;
reg [2:0] linear_enable_r;
reg [2:0] linear_enable2_r;
always @(posedge CLK) begin
  irq_enable_r <= {irq_enable_r[1:0], irq_enable_};
  linear_enable_r <= {linear_enable_r[1:0], linear_enable_};
  linear_enable2_r <= {linear_enable2_r[1:0], linear_enable2_};
end
assign irq_enable = irq_enable_r[2];
assign linear_enable = linear_enable_r[2];
assign linear_enable2 = linear_enable2_r[2];
assign ram0_addr = ram0_linear ? SNES_ADDR
                 : {13'b0,SNES_ADDR[10:0]};
assign PA_addr = SNES_ADDR[7:0];
assign bram_addr = SNES_ADDR[4:0];
endmodule