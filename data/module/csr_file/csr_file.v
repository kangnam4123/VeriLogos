module csr_file(
    input  wire                             clk,
    input  wire                             reset_n,
    output wire                             spl_reset, 
    output reg                              csr_spl_dsm_base_valid,
    output reg  [31:0]                      csr_spl_dsm_base,
    input  wire                             csr_spl_dsm_base_done,
    output reg                              csr_afu_dsm_base_valid,
    output reg  [31:0]                      csr_afu_dsm_base,
    input  wire                             csr_afu_dsm_base_done,
    output reg                              csr_ctx_base_valid,
    output reg  [31:0]                      csr_ctx_base,
    input  wire                             csr_ctx_base_done,
    input  wire                             io_rx_csr_valid,
    input  wire [13:0]                      io_rx_csr_addr,
    input  wire [31:0]                      io_rx_csr_data
);
    localparam [5:0]
        SPL_CSR_DSR_BASEL          = 6'b00_0000,   
        SPL_CSR_DSR_BASEH          = 6'b00_0001,   
        SPL_CSR_CTX_BASELL         = 6'b00_0010,   
        SPL_CSR_CTX_BASELH         = 6'b00_0011,   
        SPL_CSR_CTRL               = 6'b00_0100,   
        SPL_CSR_SCRATCH            = 6'b11_1111;   
    localparam [5:0]
        AFU_CSR_DSR_BASEL          = 6'b00_0000,   
        AFU_CSR_DSR_BASEH          = 6'b00_0001,   
        AFU_CSR_CTX_BASEL          = 6'b00_0010,   
        AFU_CSR_CTX_BASEH          = 6'b00_0011,   
        AFU_CSR_SCRATCH            = 6'b11_1111,   
        AFU_CSR_CMD_OPCODE         = 6'b00_1111; 
    reg  [5:0]                     spl_dsr_base_hi;
    reg  [5:0]                     afu_dsr_base_hi;
    reg                            csr_reset = 0;
    reg                            csr_enable = 0;
    assign spl_reset  = csr_reset;
    always @(posedge clk) begin
        if (~reset_n) begin
            csr_spl_dsm_base_valid <= 1'b0;
            csr_afu_dsm_base_valid <= 1'b0;
            csr_ctx_base_valid     <= 1'b0;
            spl_dsr_base_hi        <= 0;
            afu_dsr_base_hi        <= 0;
            csr_reset              <= 0;
            csr_enable             <= 0;
        end 
        else begin             
            csr_reset     <= 1'b0;   
            csr_enable    <= 0;
            if ( csr_ctx_base_done )      csr_ctx_base_valid     <= 1'b0;
            if ( csr_spl_dsm_base_done )  csr_spl_dsm_base_valid <= 1'b0;  
            if ( csr_afu_dsm_base_done )  csr_afu_dsm_base_valid <= 1'b0; 
            if ( csr_spl_dsm_base_done )  spl_dsr_base_hi        <= 0;  
            if ( csr_afu_dsm_base_done )  afu_dsr_base_hi        <= 0;                
            if (io_rx_csr_valid) begin
                if (io_rx_csr_addr[13:6] == 8'h10) begin
                    case (io_rx_csr_addr[5:0]) 
                        SPL_CSR_DSR_BASEH : begin                
                            spl_dsr_base_hi <= io_rx_csr_data[5:0];                                                         
                        end
                        SPL_CSR_DSR_BASEL : begin                
                            csr_spl_dsm_base_valid <= 1'b1;
                            csr_spl_dsm_base       <= {spl_dsr_base_hi, io_rx_csr_data[31:6]};                           
                        end
                        SPL_CSR_CTX_BASELH : begin                
                            csr_ctx_base[31:26] <= io_rx_csr_data[5:0];                          
                        end
                        SPL_CSR_CTX_BASELL : begin                
                            csr_ctx_base[25:0] <= io_rx_csr_data[31:6];                            
                            csr_ctx_base_valid <= 1'b1;
                        end
                        SPL_CSR_CTRL : begin                
                            csr_reset  <= io_rx_csr_data[0];
                            csr_enable <= io_rx_csr_data[1];
                        end  								
                    endcase
                end
                else if (io_rx_csr_addr[13:6] == 8'h8a) begin
                    case (io_rx_csr_addr[5:0]) 
                        AFU_CSR_DSR_BASEH : begin                
                            afu_dsr_base_hi <= io_rx_csr_data[5:0];                               
                        end
                        AFU_CSR_DSR_BASEL : begin                
                            csr_afu_dsm_base_valid <= 1'b1;                            
                            csr_afu_dsm_base       <= {afu_dsr_base_hi, io_rx_csr_data[31:6]};                                            
                        end 
                    endcase
                end
            end
        end
    end 
endmodule