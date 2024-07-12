module display_cnt_3bit(input reset, input display_clk,
                        output  reg [2:0] display_cnt_3bit_num);
    always @(  posedge reset or posedge display_clk) begin
        if ( reset) display_cnt_3bit_num <= 0;
        else  display_cnt_3bit_num <= display_cnt_3bit_num + 1;
    end 
endmodule