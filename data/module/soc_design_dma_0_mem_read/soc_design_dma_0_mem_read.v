module soc_design_dma_0_mem_read (
                                    clk,
                                    clk_en,
                                    go,
                                    p1_done_read,
                                    p1_fifo_full,
                                    read_waitrequest,
                                    reset_n,
                                    inc_read,
                                    mem_read_n
                                 )
;
  output           inc_read;
  output           mem_read_n;
  input            clk;
  input            clk_en;
  input            go;
  input            p1_done_read;
  input            p1_fifo_full;
  input            read_waitrequest;
  input            reset_n;
  wire             inc_read;
  wire             mem_read_n;
  wire             p1_read_select;
  reg              read_select;
  reg              soc_design_dma_0_mem_read_access;
  reg              soc_design_dma_0_mem_read_idle;
  assign mem_read_n = ~read_select;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          read_select <= 0;
      else if (clk_en)
          read_select <= p1_read_select;
    end
  assign inc_read = read_select & ~read_waitrequest;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          soc_design_dma_0_mem_read_idle <= 1;
      else if (clk_en)
          soc_design_dma_0_mem_read_idle <= ((soc_design_dma_0_mem_read_idle == 1) & (go == 0)) |
                    ((soc_design_dma_0_mem_read_idle == 1) & (p1_done_read == 1)) |
                    ((soc_design_dma_0_mem_read_idle == 1) & (p1_fifo_full == 1)) |
                    ((soc_design_dma_0_mem_read_access == 1) & (p1_fifo_full == 1) & (read_waitrequest == 0)) |
                    ((soc_design_dma_0_mem_read_access == 1) & (p1_done_read == 1) & (read_waitrequest == 0));
    end
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          soc_design_dma_0_mem_read_access <= 0;
      else if (clk_en)
          soc_design_dma_0_mem_read_access <= ((soc_design_dma_0_mem_read_idle == 1) & (p1_fifo_full == 0) & (p1_done_read == 0) & (go == 1)) |
                    ((soc_design_dma_0_mem_read_access == 1) & (read_waitrequest == 1)) |
                    ((soc_design_dma_0_mem_read_access == 1) & (p1_fifo_full == 0) & (p1_done_read == 0) & (read_waitrequest == 0));
    end
  assign p1_read_select = ({1 {((soc_design_dma_0_mem_read_access && (read_waitrequest == 1)))}} & 1) |
    ({1 {((soc_design_dma_0_mem_read_access && (p1_done_read == 0) && (p1_fifo_full == 0) && (read_waitrequest == 0)))}} & 1) |
    ({1 {((soc_design_dma_0_mem_read_idle && (go == 1) && (p1_done_read == 0) && (p1_fifo_full == 0)))}} & 1);
endmodule