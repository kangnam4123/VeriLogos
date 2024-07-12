module altor32_wb_fetch
( 
    input                       clk_i ,
    input                       rst_i ,
    input                       fetch_i ,
    input                       burst_i ,
    input [31:0]                address_i ,
    output [31:0]               resp_addr_o ,
    output [31:0]               data_o ,
    output                      valid_o ,
    output                      final_o ,
    output reg [31:0]           wbm_addr_o ,
    input [31:0]                wbm_dat_i ,
    output reg [2:0]            wbm_cti_o ,
    output reg                  wbm_cyc_o ,
    output reg                  wbm_stb_o ,
    input                       wbm_stall_i,
    input                       wbm_ack_i
);
parameter FETCH_WORDS_W             = 3; 
parameter FETCH_BYTES_W             = FETCH_WORDS_W + 2;
parameter WB_CTI_BURST              = 3'b010;
parameter WB_CTI_FINAL              = 3'b111;
reg [FETCH_WORDS_W-1:0]  fetch_word_q;
reg [FETCH_WORDS_W-1:0]  resp_word_q;
wire [FETCH_WORDS_W-1:0] next_word_w  = fetch_word_q + 1;
wire penultimate_word_w  = (fetch_word_q == ({FETCH_WORDS_W{1'b1}}-1));
wire final_resp_w        = ((resp_word_q  == {FETCH_WORDS_W{1'b1}}) | ~burst_i);
always @ (posedge rst_i or posedge clk_i )
begin
   if (rst_i == 1'b1)
   begin
        wbm_addr_o      <= 32'h00000000;
        wbm_cti_o       <= 3'b0;
        wbm_stb_o       <= 1'b0;
        wbm_cyc_o       <= 1'b0;
        fetch_word_q    <= {FETCH_WORDS_W{1'b0}};
        resp_word_q     <= {FETCH_WORDS_W{1'b0}};
   end
   else
   begin
        if (!wbm_cyc_o)
        begin
            if (fetch_i)
            begin
                if (burst_i)
                begin
                    wbm_addr_o      <= {address_i[31:FETCH_BYTES_W], {FETCH_BYTES_W{1'b0}}};
                    fetch_word_q    <= {FETCH_WORDS_W{1'b0}};
                    resp_word_q     <= {FETCH_WORDS_W{1'b0}};
                    wbm_cti_o       <= WB_CTI_BURST;
                end
                else
                begin                    
                    wbm_addr_o      <= address_i;
                    resp_word_q     <= address_i[FETCH_BYTES_W-1:2];
                    wbm_cti_o       <= WB_CTI_FINAL;                    
                end
                wbm_stb_o           <= 1'b1;
                wbm_cyc_o           <= 1'b1;                        
            end
        end
        else
        begin
            if (~wbm_stall_i)
            begin
                if (wbm_cti_o != WB_CTI_FINAL)
                begin
                    wbm_addr_o      <= {wbm_addr_o[31:FETCH_BYTES_W], next_word_w, 2'b0};
                    fetch_word_q    <= next_word_w;
                    if (penultimate_word_w)
                        wbm_cti_o   <= WB_CTI_FINAL;
                end
                else
                    wbm_stb_o       <= 1'b0;
            end
            if (wbm_ack_i)
                resp_word_q         <= resp_word_q + 1;
            if (final_o)
                wbm_cyc_o           <= 1'b0;
        end
   end
end
assign data_o       = wbm_dat_i;
assign valid_o      = wbm_ack_i;
assign final_o      = final_resp_w & wbm_ack_i;
assign resp_addr_o  = {address_i[31:FETCH_BYTES_W], resp_word_q, 2'b0};
endmodule