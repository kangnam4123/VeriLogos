module axi_traffic_gen_v2_0_7_addrram_wrap #
(
parameter C_FAMILY = "virtex7",
parameter C_RAMINIT_ADDRRAM0_F = "NONE" ,
parameter C_S_AXI_DATA_WIDTH = 32,
parameter C_M_AXI_DATA_WIDTH = 32,
parameter C_M_AXI_ADDR_WIDTH = 32,
parameter C_ATG_BASIC_AXI4 = 0
) (
   input                 Clk                           ,
   input                 rst_l                         ,
   input [15:0]          aw_agen_addr                  ,
   input                 aw_agen_valid                 ,
   input [15:0]          ar_agen_addr                  ,
   input                 ar_agen_valid                 ,
   input                 wfifo_valid                   ,
   input [C_S_AXI_DATA_WIDTH*9/8+1-1:0]    wfifo_out   ,
   output [31:0]         mr_ext_addr                   ,
   output [31:0]         mw_ext_addr                   ,
   output [31:0]         rd_ext_addr                   ,
   input [9:0]           mar_ptr_new_ff                , 
   input [9:0]           maw_ptr_new_ff                 
);
generate if(C_M_AXI_ADDR_WIDTH > 32 ) begin : EXT_ADDR_ON
   wire [31:0] addrram_rd_data_a;
   wire [3:0]  addrram_we_b       = 4'b0 ;   
   wire [8:0]  addrram_addr_b     = {1'b1,maw_ptr_new_ff[7:0]};   
   wire [31:0] addrram_wr_data_b  = 32'h00000000;  
   wire [31:0] addrram_rd_data_b;
   wire addr_ram_we               = aw_agen_valid && (aw_agen_addr[15:11] == 5'b00100);
   reg         addr_ram_we_ff;
   wire [8:0]   addr_ram_addr_ff;
   assign addr_ram_addr_ff =  (rst_l) ? ((addr_ram_we) ? aw_agen_addr[10:2] : addr_ram_addr_ff) : 9'h0 ;
   wire [3:0] addrram_we_a       = (wfifo_valid && addr_ram_we)  ? 4'hf : 4'h0 ;  
   wire [8:0] addrram_addr_a     = (wfifo_valid && addr_ram_we)  ? addr_ram_addr_ff : (ar_agen_valid && ar_agen_addr[15:11] == 5'b00100) ? ar_agen_addr[10:2] : {1'b0,mar_ptr_new_ff[7:0]};
   wire [31:0] addrram_wr_data_a;
   assign rd_ext_addr             = addrram_rd_data_a;
   assign mr_ext_addr             = addrram_rd_data_a;
   assign mw_ext_addr             = addrram_rd_data_b;
   always @(posedge Clk) begin 
      addr_ram_we_ff <=  (rst_l) ? ((addr_ram_we) ? 1'h1 : ((wfifo_valid) ? 1'h0 : addr_ram_we_ff)) : 1'h0 ;
   end
   if(C_S_AXI_DATA_WIDTH == 64) begin: EXT_ADDR_64_GEN
      assign addrram_wr_data_a  =  (addr_ram_addr_ff[0]) ? wfifo_out[63:32]: wfifo_out[31:0];   
   end 
   if(C_S_AXI_DATA_WIDTH == 32) begin: EXT_ADDR_32_GEN
      assign addrram_wr_data_a  =  wfifo_out[31:0];   
   end 
axi_traffic_gen_v2_0_7_slvram_v7 #(
            .C_FAMILY    (C_FAMILY             ),
            .C_DATAWIDTH (32                   ),
            .C_SIZE      (512                  ),
            .C_ADDR_WIDTH(9                    ),
            .C_INITRAM_F (C_RAMINIT_ADDRRAM0_F )
) addrram (
      .clk_a    (Clk              ),
      .we_a     (addrram_we_a     ),
      .addr_a   (addrram_addr_a   ),
      .wr_data_a(addrram_wr_data_a),
      .rd_data_a(addrram_rd_data_a),
      .clk_b    (Clk              ),
      .we_b     (addrram_we_b     ),
      .addr_b   (addrram_addr_b   ),
      .wr_data_b(addrram_wr_data_b),
      .rd_data_b(addrram_rd_data_b)
      );
end
endgenerate
endmodule