module register_bank_3
#(
   parameter DATA_WIDTH = 32,
   parameter ADDRESS_WIDTH = 5
)
(
   input clk,
   input rst_n,
   input en,
   input [ADDRESS_WIDTH-1:0] rd_reg1_addr,
   input [ADDRESS_WIDTH-1:0] rd_reg2_addr,
   input [ADDRESS_WIDTH-1:0] reg_a_wr_addr,
   input [ADDRESS_WIDTH-1:0] reg_b_wr_addr,
   input [DATA_WIDTH-1:0] reg_a_wr_data,
   input [DATA_WIDTH-1:0] reg_b_wr_data,
   input reg_a_wr_en,
   input reg_b_wr_en,
   output [DATA_WIDTH-1:0] rd_reg1_data_out,
   output [DATA_WIDTH-1:0] rd_reg2_data_out
);
   reg [DATA_WIDTH-1:0] reg_file [0:(2**ADDRESS_WIDTH)-1];
   integer i;
   always @(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
         for (i = 0; i < 2**ADDRESS_WIDTH; i = i + 1) begin:reset_memory
            reg_file[i] <= {DATA_WIDTH{1'b0}};
         end
      end
      else if(en) begin
         if (reg_a_wr_en)
            reg_file[reg_a_wr_addr] <= reg_a_wr_data;
         if (reg_b_wr_en)
            reg_file[reg_b_wr_addr] <= reg_b_wr_data;
      end
   end
   assign rd_reg2_data_out = (reg_a_wr_en&(reg_a_wr_addr==rd_reg2_addr))?
                             reg_a_wr_data: (reg_b_wr_en&(reg_b_wr_addr==rd_reg2_addr))?
			     reg_b_wr_data:reg_file[rd_reg2_addr];
   assign rd_reg1_data_out = (reg_a_wr_en&(reg_a_wr_addr==rd_reg1_addr))?
                             reg_a_wr_data: (reg_b_wr_en&(reg_b_wr_addr==rd_reg1_addr))?
			     reg_b_wr_data:reg_file[rd_reg1_addr];
endmodule