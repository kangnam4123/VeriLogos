module wb_sram16 #(
        parameter                  adr_width = 19,   
        parameter                  latency   = 0    
) (
        input                      clk,
        input                      reset,
        input                      wb_stb_i,
        input                      wb_cyc_i,
        input                      wb_tga_i,
        output reg                 wb_ack_o,
        input                      wb_we_i,
        input               [18:0] wb_adr_i,
        input                [1:0] wb_sel_i,
        input               [15:0] wb_dat_i,
        output reg          [15:0] wb_dat_o,
        output reg [adr_width-1:0] sram_adr,
        inout               [15:0] sram_dat,
        output reg           [1:0] sram_be_n,    
        output reg                 sram_ce_n,    
        output reg                 sram_oe_n,    
        output reg                 sram_we_n     
);
wire wb_rd = wb_stb_i & wb_cyc_i & ~wb_we_i & ~wb_ack_o;
wire wb_wr = wb_stb_i & wb_cyc_i &  wb_we_i & ~wb_ack_o;
wire [adr_width-1:0] adr = wb_adr_i[adr_width-1:0];
reg [15:0] wdat;
reg        wdat_oe;
assign sram_dat = wdat_oe ? wdat : 16'bz;
reg  [2:0] lcount;
parameter s_idle   = 0;
parameter s_read   = 1;
parameter s_write  = 2;
reg [2:0] state;
always @(posedge clk)
begin
        if (reset) begin
                state    <= s_idle;
                lcount   <= 0;
                wb_ack_o <= 0;
        end else begin
                case (state)
                s_idle: begin
                        wb_ack_o <= 0;
                        if (wb_rd) begin
                                sram_ce_n  <=  0;
                                sram_oe_n  <=  0;
                                sram_we_n  <=  1;
                                sram_adr   <=  adr;
                                sram_be_n  <=  2'b00;
                                wdat_oe    <=  0;
                                lcount     <=  latency;
                                state      <=  s_read;
                        end else if (wb_wr) begin
                                sram_ce_n  <=  0;
                                sram_oe_n  <=  1;
                                sram_we_n  <=  0;
                                sram_adr   <=  adr;
                                sram_be_n  <= ~wb_sel_i;
                                wdat       <=  wb_dat_i;
                                wdat_oe    <=  1;
                                lcount     <=  latency;
                                state      <=  s_write;
                        end else begin
                                sram_ce_n  <=  1;
                                sram_oe_n  <=  1;
                                sram_we_n  <=  1;
                                wdat_oe    <=  0;
                        end
                end
                s_read: begin
                        if (lcount != 0) begin
                                lcount     <= lcount - 1;
                        end else begin
                                sram_ce_n  <=  1;
                                sram_oe_n  <=  1;
                                sram_we_n  <=  1;
                                wb_dat_o   <=  sram_dat;
                                wb_ack_o   <=  1;
                                state      <=  s_idle;
                        end
                end
                s_write: begin
                        if (lcount != 0) begin
                                lcount     <= lcount - 1;
                        end else begin
                                sram_ce_n  <=  1;
                                sram_oe_n  <=  1;
                                sram_we_n  <=  1;
                                wb_ack_o   <=  1;       
                                state      <=  s_idle;  
                        end
                end
                endcase
        end
end
endmodule