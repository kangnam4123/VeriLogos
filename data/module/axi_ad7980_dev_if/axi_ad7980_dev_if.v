module axi_ad7980_dev_if
(
    input               fpga_clk_i,      
    input               adc_clk_i,       
    input               reset_i,       
    output     [15:0]   data_o,          
    output reg          data_rd_ready_o, 
    output reg          adc_status_o,
    input               adc_sdo,        
    input               adc_sdi,        
    output              adc_sclk_o,     
    output              adc_cnv_o       
);
reg [ 3:0]  adc_state;      
reg [ 3:0]  adc_next_state; 
reg [ 3:0]  adc_state_m1;   
reg [ 6:0]  adc_tcycle_cnt; 
reg [ 6:0]  adc_tcnv_cnt;   
reg [ 4:0]  sclk_clk_cnt;   
reg         adc_clk_en;     
reg         adc_cnv_s;      
reg [15:0]  adc_data_s;     
wire        adc_sclk_s;     
parameter ADC_IDLE_STATE            = 4'b0001;
parameter ADC_START_CNV_STATE       = 4'b0010;
parameter ADC_END_CNV_STATE         = 4'b0100;
parameter ADC_READ_CNV_RESULT       = 4'b1000;
parameter real FPGA_CLOCK_FREQ  = 100000000;    
parameter real ADC_CYCLE_TIME   = 0.000001000;  
parameter real ADC_CONV_TIME    = 0.000000670;  
parameter [6:0] ADC_CYCLE_CNT   = FPGA_CLOCK_FREQ * ADC_CYCLE_TIME - 1;
parameter [6:0] ADC_CNV_CNT     = FPGA_CLOCK_FREQ * ADC_CONV_TIME;
parameter ADC_SCLK_PERIODS  = 5'd15; 
assign adc_cnv_o      = adc_cnv_s;
assign adc_sclk_s     = adc_clk_i & adc_clk_en;
assign adc_sclk_o     = adc_sclk_s;
assign data_o         = adc_data_s;
always @(posedge fpga_clk_i)
begin
    if(reset_i == 1'b1)
    begin
        adc_tcycle_cnt  <= 0;
        adc_tcnv_cnt    <= ADC_CNV_CNT;
    end
    else
    begin
        if(adc_tcycle_cnt != 0)
        begin
            adc_tcycle_cnt <= adc_tcycle_cnt - 1;
        end
        else if(adc_state == ADC_IDLE_STATE)
        begin
            adc_tcycle_cnt <= ADC_CYCLE_CNT;
        end
        if(adc_state == ADC_START_CNV_STATE)
        begin
            adc_tcnv_cnt <= adc_tcnv_cnt - 1;
        end
        else
        begin
           adc_tcnv_cnt <= ADC_CNV_CNT;
        end
    end
end
always @(negedge adc_clk_i)
begin
    if(adc_clk_en == 1'b1)
    begin
        adc_data_s   <= {adc_data_s[14:0], adc_sdo};
        sclk_clk_cnt <= sclk_clk_cnt - 1;
    end
    else
    begin
        sclk_clk_cnt <= ADC_SCLK_PERIODS;
    end
end
always @(negedge adc_clk_i)
begin
    adc_state_m1 <= adc_state;
    adc_clk_en   <= ((adc_state_m1 == ADC_END_CNV_STATE) || (adc_state_m1 == ADC_READ_CNV_RESULT) && (sclk_clk_cnt != 0)) ? 1'b1 : 1'b0;
end
always @(posedge fpga_clk_i)
begin
    if(reset_i == 1'b1)
    begin
        adc_state <= ADC_IDLE_STATE;
        adc_status_o <= 1'b0;
    end
    else
    begin
        adc_state <= adc_next_state;
        case (adc_state)
            ADC_IDLE_STATE:
            begin
                adc_cnv_s       <= 1'b0;
                data_rd_ready_o <= 1'b0;
            end
            ADC_START_CNV_STATE:
            begin
                adc_cnv_s       <= 1'b1;
                data_rd_ready_o <= 1'b0;
            end
            ADC_END_CNV_STATE:
            begin
                adc_cnv_s       <= 1'b0;
                data_rd_ready_o <= 1'b1;
            end
                ADC_READ_CNV_RESULT:
            begin
                adc_cnv_s       <= 1'b0;
                data_rd_ready_o <= 1'b0;
                adc_status_o    <= 1'b1;
            end
        endcase
    end
end
always @(adc_state, adc_tcycle_cnt, adc_tcnv_cnt, sclk_clk_cnt)
begin
    adc_next_state <= adc_state;
    case (adc_state)
        ADC_IDLE_STATE:
        begin
            if(adc_tcycle_cnt == 0)
                begin
                    adc_next_state <= ADC_START_CNV_STATE;
                end
        end
        ADC_START_CNV_STATE:
        begin
            if(adc_tcnv_cnt == 0)
            begin
                adc_next_state <= ADC_END_CNV_STATE;
            end
        end
        ADC_END_CNV_STATE:
        begin
            adc_next_state <= ADC_READ_CNV_RESULT;
        end
        ADC_READ_CNV_RESULT:
        begin
            if(sclk_clk_cnt == 1)
            begin
                adc_next_state <= ADC_IDLE_STATE;
            end
        end
        default:
        begin
            adc_next_state <= ADC_IDLE_STATE;
        end
    endcase
end
endmodule