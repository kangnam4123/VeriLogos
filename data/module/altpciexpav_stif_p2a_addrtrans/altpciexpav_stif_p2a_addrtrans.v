module altpciexpav_stif_p2a_addrtrans (  
                        k_bar_i,
                        cb_p2a_avalon_addr_b0_i,
                        cb_p2a_avalon_addr_b1_i,
                        cb_p2a_avalon_addr_b2_i,
                        cb_p2a_avalon_addr_b3_i,
                        cb_p2a_avalon_addr_b4_i,
                        cb_p2a_avalon_addr_b5_i,
                        cb_p2a_avalon_addr_b6_i,
                        PCIeAddr_i,
                        BarHit_i,
                        AvlAddr_o
                       );
input [227:0] k_bar_i;
input [31:0] cb_p2a_avalon_addr_b0_i;
input [31:0] cb_p2a_avalon_addr_b1_i;
input [31:0] cb_p2a_avalon_addr_b2_i;
input [31:0] cb_p2a_avalon_addr_b3_i;
input [31:0] cb_p2a_avalon_addr_b4_i;
input [31:0] cb_p2a_avalon_addr_b5_i;
input [31:0] cb_p2a_avalon_addr_b6_i;
input [31:0] PCIeAddr_i;
input [6:0] BarHit_i;
output [31:0] AvlAddr_o;
reg [31:0] bar_parameter;
reg [31:0] avl_addr;
wire [31:0] bar0;   
wire [31:0] bar1; 
wire [31:0] bar2; 
wire [31:0] bar3; 
wire [31:0] bar4; 
wire [31:0] bar5; 
wire [31:0] exp_rom_bar; 
assign bar0 = k_bar_i[31:0];       
assign bar1 = k_bar_i[63:32]; 
assign bar2 = k_bar_i[95:64]; 
assign bar3 = k_bar_i[127:96]; 
assign bar4 = k_bar_i[159:128]; 
assign bar5 = k_bar_i[191:160]; 
assign exp_rom_bar = k_bar_i[223:192]; 
always  @(BarHit_i or bar0 or bar1 or bar2 or bar3 or bar4 or bar5 or exp_rom_bar)
begin
  case (BarHit_i)
    7'b0000001 : bar_parameter = bar0;
    7'b0000010 : bar_parameter = bar1;
    7'b0000100 : bar_parameter = bar2;
    7'b0001000 : bar_parameter = bar3;
    7'b0010000 : bar_parameter = bar4;
    7'b0100000 : bar_parameter = bar5;
    7'b1000000 : bar_parameter = exp_rom_bar;
    default    : bar_parameter = 32'h00000000;
  endcase
end
always  @(BarHit_i or cb_p2a_avalon_addr_b0_i or cb_p2a_avalon_addr_b1_i or
        cb_p2a_avalon_addr_b2_i or cb_p2a_avalon_addr_b3_i or
        cb_p2a_avalon_addr_b4_i or cb_p2a_avalon_addr_b5_i or
        cb_p2a_avalon_addr_b6_i)
begin
  case (BarHit_i )
    7'b0000001 : avl_addr = cb_p2a_avalon_addr_b0_i;
    7'b0000010 : avl_addr = cb_p2a_avalon_addr_b1_i;
    7'b0000100 : avl_addr = cb_p2a_avalon_addr_b2_i;
    7'b0001000 : avl_addr = cb_p2a_avalon_addr_b3_i;
    7'b0010000 : avl_addr = cb_p2a_avalon_addr_b4_i;
    7'b0100000 : avl_addr = cb_p2a_avalon_addr_b5_i;
    7'b1000000 : avl_addr = cb_p2a_avalon_addr_b6_i;
    default    : avl_addr = 32'h00000000;
  endcase
end
assign AvlAddr_o = (PCIeAddr_i & ~({bar_parameter[31:4], 4'b0000})) |
                   (avl_addr & ({bar_parameter[31:4], 4'b0000})) ;
endmodule