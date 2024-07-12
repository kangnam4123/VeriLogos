module edistrib (
   ems_dir_rd_wait, ems_dir_wr_wait, emwr_wr_data, emwr_wr_en,
   emrq_wr_data, emrq_wr_en, emrr_wr_data, emrr_wr_en,
   rxlclk, ems_dir_access, ems_dir_write, ems_dir_datamode,
   ems_dir_ctrlmode, ems_dir_dstaddr, ems_dir_srcaddr, ems_dir_data,
   ems_mmu_access, ems_mmu_write, ems_mmu_datamode, ems_mmu_ctrlmode,
   ems_mmu_dstaddr, ems_mmu_srcaddr, ems_mmu_data, emwr_full,
   emwr_prog_full, emrq_full, emrq_prog_full, emrr_full,
   emrr_prog_full, ecfg_rx_enable, ecfg_rx_mmu_mode
   );
   parameter [11:0]  C_READ_TAG_ADDR = 12'h810;
   parameter         C_REMAP_BITS = 7;
   parameter [31:0]  C_REMAP_ADDR = 32'h3E000000;
   input         rxlclk;
   input         ems_dir_access;
   input         ems_dir_write;
   input [1:0]   ems_dir_datamode;
   input [3:0]   ems_dir_ctrlmode;
   input [31:0]  ems_dir_dstaddr;
   input [31:0]  ems_dir_srcaddr;
   input [31:0]  ems_dir_data;
   output        ems_dir_rd_wait;
   output        ems_dir_wr_wait;
   input         ems_mmu_access;
   input         ems_mmu_write;
   input [1:0]   ems_mmu_datamode;
   input [3:0]   ems_mmu_ctrlmode;
   input [31:0]  ems_mmu_dstaddr;
   input [31:0]  ems_mmu_srcaddr;
   input [31:0]  ems_mmu_data;
   output [102:0] emwr_wr_data;
   output         emwr_wr_en;
   input          emwr_full;       
   input          emwr_prog_full;
   output [102:0] emrq_wr_data;
   output         emrq_wr_en;
   input          emrq_full;
   input          emrq_prog_full;
   output [102:0] emrr_wr_data;
   output         emrr_wr_en;
   input          emrr_full;
   input          emrr_prog_full;
   input          ecfg_rx_enable;
   input          ecfg_rx_mmu_mode;
   reg [1:0]      rxmmu_sync;
   wire           rxmmu = rxmmu_sync[0];
   reg            in_write;
   reg [1:0]      in_datamode;
   reg [3:0]      in_ctrlmode;
   reg [31:0]     in_dstaddr;
   reg [31:0]     in_srcaddr;
   reg [31:0]     in_data;
   reg            emwr_wr_en;
   reg            emrq_wr_en;
   reg            emrr_wr_en;
   wire [102:0]   fifo_din;
   wire [102:0]   emwr_wr_data;
   wire [102:0]   emrq_wr_data;
   wire [102:0]   emrr_wr_data;
   always @ (posedge rxlclk) begin
      rxmmu_sync <= {ecfg_rx_mmu_mode, rxmmu_sync[1]};
      if(rxmmu) begin
         in_write    <= ems_mmu_write;
         in_datamode <= ems_mmu_datamode;
         in_ctrlmode <= ems_mmu_ctrlmode;
         in_dstaddr  <= ems_mmu_dstaddr;
         in_srcaddr  <= ems_mmu_srcaddr;
         in_data     <= ems_mmu_data;
         if(ems_mmu_access) begin
            emrq_wr_en <= ~ems_mmu_write;
            emrr_wr_en <= ems_mmu_write & (ems_mmu_dstaddr[31:20] == C_READ_TAG_ADDR);
            emwr_wr_en <= ems_mmu_write & (ems_mmu_dstaddr[31:20] != C_READ_TAG_ADDR);
         end else begin
            emrq_wr_en <= 1'b0;
            emrr_wr_en <= 1'b0;
            emwr_wr_en <= 1'b0;
         end
      end else begin
         in_write    <= ems_dir_write;
         in_datamode <= ems_dir_datamode;
         in_ctrlmode <= ems_dir_ctrlmode;
         in_dstaddr  <= {C_REMAP_ADDR[31:(32-C_REMAP_BITS)], 
                         ems_dir_dstaddr[(31-C_REMAP_BITS):0]};
         in_srcaddr  <= ems_dir_srcaddr;
         in_data     <= ems_dir_data;
         if(ems_dir_access) begin
            emrq_wr_en <= ~ems_dir_write;
            emrr_wr_en <= ems_dir_write & (ems_dir_dstaddr[31:20] == C_READ_TAG_ADDR);
            emwr_wr_en <= ems_dir_write & (ems_dir_dstaddr[31:20] != C_READ_TAG_ADDR);
         end else begin
            emrq_wr_en <= 1'b0;
            emrr_wr_en <= 1'b0;
            emwr_wr_en <= 1'b0;
         end
      end 
   end 
   assign fifo_din = 
         {in_write,
          in_datamode,
          in_ctrlmode,
          in_dstaddr,
          in_srcaddr,
          in_data};
   assign emwr_wr_data = fifo_din;
   assign emrq_wr_data = fifo_din;
   assign emrr_wr_data = fifo_din;
   assign        ems_dir_rd_wait = emrq_prog_full;
   assign        ems_dir_wr_wait = emwr_prog_full | emrr_prog_full;
endmodule