module fltcpu_regfile(
                      input wire           clk,
                      input wire           reset_n,
                      input wire [4 : 0]   src0_addr,
                      output wire [31 : 0] src0_data,
                      input wire [4 : 0]   src1_addr,
                      output wire [31 : 0] src1_data,
                      input wire           dst_we,
                      input wire [4 : 0]   dst_addr,
                      input wire [31 : 0]  dst_wr_data,
                      output wire [31 : 0] dst_rd_data,
                      output wire          zero_flag,
                      input wire           inc,
                      input wire           ret,
                      output wire [31 : 0] pc
                     );
  localparam BOOT_VECTOR = 32'h00000000;
  reg [31 : 0] gp_reg [0 : 27];
  reg          gp_we;
  reg          zero_reg;
  reg          zero_we;
  reg          eq_reg;
  reg          eq_we;
  reg          carry_reg;
  reg          carry_we;
  reg [31 : 0] return_reg;
  reg          return_we;
  reg [31 : 0] ret_reg [0 : 15];
  reg [31 : 0] ret_new;
  reg          ret_we;
  reg [03 : 0] ret_ptr_reg;
  reg [03 : 0] ret_ptr_new;
  reg          ret_ptr_we;
  reg [31 : 0] pc_reg;
  reg [31 : 0] pc_new;
  reg          pc_we;
  reg [31 : 0] tmp_src0_data;
  reg [31 : 0] tmp_src1_data;
  reg [31 : 0] tmp_dst_rd_data;
  assign src0_data   = tmp_src0_data;
  assign src1_data   = tmp_src1_data;
  assign dst_rd_data = tmp_dst_rd_data;
  assign pc          = pc_reg;
  always @ (posedge clk or negedge reset_n)
    begin : reg_update
      integer i;
      if (!reset_n)
        begin
          for (i = 0 ; i < 28 ; i = i + 1)
            gp_reg[i]  <= 32'h0;
          for (i = 0 ; i < 16 ; i = i + 1)
            ret_reg[i] <= 32'h0;
          ret_ptr_reg <= 4'h0;
          pc_reg      <= BOOT_VECTOR;
        end
      else
        begin
          if (gp_we)
            gp_reg[dst_addr] <= dst_wr_data;
          if (pc_we)
            pc_reg <= pc_new;
          if (ret_we)
            ret_reg[ret_ptr_reg] <= ret_new;
          if (ret_ptr_we)
            ret_ptr_reg <= ret_ptr_new;
        end
    end 
  always @*
    begin : read_src0
      if (src0_addr == 0)
        tmp_src0_data = 32'h0;
      if (0 < src0_addr < 29)
        tmp_src0_data = gp_reg[(src0_addr - 1)];
      else if (src0_addr == 29)
        tmp_src0_data = {carry_reg, eq_reg, zero_reg};
      else if (src0_addr == 30)
        tmp_src0_data = ret_reg[ret_ptr_reg];
      else if (src0_addr == 31)
        tmp_src0_data = pc_reg;
    end 
  always @*
    begin : read_src1
      if (src1_addr == 0)
        tmp_src1_data = 32'h0;
      if (0 < src1_addr < 29)
        tmp_src1_data = gp_reg[(src1_addr - 1)];
      else if (src1_addr == 29)
        tmp_src1_data = {carry_reg, eq_reg, zero_reg};
      else if (src1_addr == 30)
        tmp_src1_data = ret_reg[ret_ptr_reg];
      else if (src1_addr == 31)
        tmp_src1_data = pc_reg;
    end 
  always @*
    begin : read_dst
      if (dst_addr == 0)
        tmp_dst_rd_data = 32'h0;
      if (0 < dst_addr < 29)
        tmp_dst_rd_data = gp_reg[(src1_addr - 1)];
      else if (dst_addr == 29)
        tmp_dst_rd_data = {carry_reg, eq_reg, zero_reg};
      else if (dst_addr == 30)
        tmp_dst_rd_data = ret_reg[ret_ptr_reg];
      else if (dst_addr == 31)
        tmp_dst_rd_data = pc_reg;
    end 
  always @*
    begin : pc_update
      return_we = 0;
      gp_we     = 0;
      pc_new    = 32'h0;
      pc_we     = 0;
      ret_ptr_new = 32'h0;
      ret_ptr_we  = 0;
      if (dst_we && (dst_addr < 30))
          gp_we = 1;
      if (dst_we && (dst_addr == 30))
        begin
          ret_new = dst_wr_data;
          ret_we = 1;
        end
      if (dst_we && (dst_addr == 31))
        begin
          ret_new     = pc_reg;
          ret_we      = 1;
          ret_ptr_new = ret_ptr_reg + 1;
          ret_ptr_we  = 1;
          pc_new      = dst_wr_data;
          pc_we       = 1;
        end
      else if (ret)
        begin
          ret_ptr_new = ret_ptr_reg - 1;
          ret_ptr_we  = 1;
          pc_new      = ret_reg[ret_ptr_reg];
          pc_we       = 1;
        end
      else if (inc)
        begin
          pc_new = pc_reg + 1;
          pc_we  = 1;
        end
    end 
endmodule