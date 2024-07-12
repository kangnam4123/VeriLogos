module wb_mcb_8
(
    input  wire        clk,
    input  wire        rst,
    input  wire [31:0] wb_adr_i,     
    input  wire [7:0]  wb_dat_i,     
    output wire [7:0]  wb_dat_o,     
    input  wire        wb_we_i,      
    input  wire        wb_stb_i,     
    output wire        wb_ack_o,     
    input  wire        wb_cyc_i,     
    output wire        mcb_cmd_clk,
    output wire        mcb_cmd_en,
    output wire [2:0]  mcb_cmd_instr,
    output wire [5:0]  mcb_cmd_bl,
    output wire [31:0] mcb_cmd_byte_addr,
    input  wire        mcb_cmd_empty,
    input  wire        mcb_cmd_full,
    output wire        mcb_wr_clk,
    output wire        mcb_wr_en,
    output wire [3:0]  mcb_wr_mask,
    output wire [31:0] mcb_wr_data,
    input  wire        mcb_wr_empty,
    input  wire        mcb_wr_full,
    input  wire        mcb_wr_underrun,
    input  wire [6:0]  mcb_wr_count,
    input  wire        mcb_wr_error,
    output wire        mcb_rd_clk,
    output wire        mcb_rd_en,
    input  wire [31:0] mcb_rd_data,
    input  wire        mcb_rd_empty,
    input  wire        mcb_rd_full,
    input  wire        mcb_rd_overflow,
    input  wire [6:0]  mcb_rd_count,
    input  wire        mcb_rd_error
);
reg cycle_reg = 0;
reg [7:0] wb_dat_reg = 0;
reg wb_ack_reg = 0;
reg mcb_cmd_en_reg = 0;
reg mcb_cmd_instr_reg = 0;
reg mcb_wr_en_reg = 0;
reg [3:0] mcb_wr_mask_reg = 0;
assign wb_dat_o = wb_dat_reg;
assign wb_ack_o = wb_ack_reg;
assign mcb_cmd_clk = clk;
assign mcb_cmd_en = mcb_cmd_en_reg;
assign mcb_cmd_instr = mcb_cmd_instr_reg;
assign mcb_cmd_bl = 0;
assign mcb_cmd_byte_addr = wb_adr_i & 32'hFFFFFFFC;
assign mcb_wr_clk = clk;
assign mcb_wr_en = mcb_wr_en_reg;
assign mcb_wr_mask = mcb_wr_mask_reg;
assign mcb_wr_data = {wb_dat_i, wb_dat_i, wb_dat_i, wb_dat_i};
assign mcb_rd_clk = clk;
assign mcb_rd_en = 1;
always @(posedge clk) begin
    if (rst) begin
        cycle_reg <= 0;
        mcb_cmd_en_reg <= 0;
        mcb_cmd_instr_reg <= 0;
        mcb_wr_en_reg <= 0;
    end else begin
        wb_ack_reg <= 0;
        mcb_cmd_en_reg <= 0;
        mcb_cmd_instr_reg <= 0;
        mcb_wr_en_reg <= 0;
        if (cycle_reg) begin
            if (~mcb_rd_empty) begin
                cycle_reg <= 0;
                wb_dat_reg <= mcb_rd_data[8*(wb_adr_i & 3) +: 8];
                wb_ack_reg <= 1;
            end
        end else if (wb_cyc_i & wb_stb_i & ~wb_ack_o) begin
            if (wb_we_i) begin
                mcb_cmd_instr_reg <= 3'b000;
                mcb_cmd_en_reg <= 1;
                mcb_wr_en_reg <= 1;
                mcb_wr_mask_reg <= ~(1 << (wb_adr_i & 3));
                wb_ack_reg <= 1;
            end else begin
                mcb_cmd_instr_reg <= 3'b001;
                mcb_cmd_en_reg <= 1;
                cycle_reg <= 1;
            end
        end
    end
end
endmodule