module stratixgx_lvds_rx_fifo_sync_ram 
    (
    clk,
    datain,
    reset, 
    waddr,
    raddr,
    we,
    dataout
    );
    parameter ram_width = 10;
    input clk;
    input reset;
    input [ram_width - 1:0] datain;
    input [1:0] waddr;
    input [1:0] raddr;
    input we;
    output [ram_width - 1:0] dataout;
    reg [ram_width-1:0] dataout_tmp;
    reg [ram_width-1:0] ram_d0, ram_d1, ram_d2, ram_d3, 
                                ram_q0, ram_q1, ram_q2, ram_q3; 
    wire [ram_width-1:0] data_reg0, data_reg1, data_reg2, data_reg3;  
    initial
    begin
        dataout_tmp = 'b0;
        ram_q0 = 1'b0;
        ram_q1 = 1'b0;
        ram_q2 = 1'b0; 
        ram_q3 = 1'b0; 
    end
    always @(posedge clk or posedge reset) 
    begin
        if(reset == 1'b1)
        begin
            ram_q0 <= 1'b0;
            ram_q1 <= 1'b0;
            ram_q2 <= 1'b0; 
            ram_q3 <= 1'b0; 
        end
        else 
        begin
            ram_q0 <= ram_d0;
            ram_q1 <= ram_d1;
            ram_q2 <= ram_d2;
            ram_q3 <= ram_d3;
        end
    end
    always @(we or 
             data_reg0 or data_reg1 or 
             data_reg2 or data_reg3 or 
             ram_q0 or ram_q1 or
             ram_q2 or ram_q3)    
    begin
        if(we == 1'b1) 
        begin
            ram_d0 <= data_reg0;
            ram_d1 <= data_reg1;
            ram_d2 <= data_reg2;
            ram_d3 <= data_reg3;
       end
       else begin
            ram_d0 <= ram_q0;
            ram_d1 <= ram_q1;
            ram_d2 <= ram_q2;
            ram_d3 <= ram_q3;
       end
    end
    assign data_reg0 = ( waddr == 2'b00 ) ? datain : ram_q0;
    assign data_reg1 = ( waddr == 2'b01 ) ? datain : ram_q1;
    assign data_reg2 = ( waddr == 2'b10 ) ? datain : ram_q2;
    assign data_reg3 = ( waddr == 2'b11 ) ? datain : ram_q3;
    always @(ram_q0 or ram_q1 or ram_q2 or ram_q3 or we or waddr or raddr)
    begin
        case ( raddr )  
            2'b00 : dataout_tmp = ram_q0;
            2'b01 : dataout_tmp = ram_q1;
            2'b10 : dataout_tmp = ram_q2;
            2'b11 : dataout_tmp = ram_q3;
        endcase
    end
    assign dataout = dataout_tmp;
endmodule