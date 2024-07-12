module stratixiv_lvds_rx_fifo_sync_ram (
                                    clk,
                                    datain,
                                    write_reset,
                                    waddr,
                                    raddr,
                                    we,
                                    dataout
                                   );
    input clk;
    input write_reset;
    input datain;
    input [2:0]  waddr;
    input [2:0]  raddr;
    input we;
    output dataout;
    reg dataout_tmp;
    reg [0:5] ram_d;
    reg [0:5] ram_q;
    wire [0:5] data_reg;
    integer i;
    initial
    begin
        dataout_tmp = 0;
        for (i=0; i<= 5; i=i+1)
            ram_q[i] <= 1'b0;
    end
    always @(posedge clk or posedge write_reset)
    begin
        if(write_reset == 1'b1)
        begin
            for (i=0; i<= 5; i=i+1)
                ram_q[i] <= 1'b0;
        end
        else begin
        for (i=0; i<= 5; i=i+1)
            ram_q[i] <= ram_d[i];
        end
    end
    always @(we or data_reg or ram_q)
    begin
        if(we === 1'b1)
        begin
            ram_d <= data_reg;
        end
        else begin
            ram_d <= ram_q;
        end
    end
    assign data_reg[0] = ( waddr == 3'b000 ) ? datain : ram_q[0];
    assign data_reg[1] = ( waddr == 3'b001 ) ? datain : ram_q[1];
    assign data_reg[2] = ( waddr == 3'b010 ) ? datain : ram_q[2];
    assign data_reg[3] = ( waddr == 3'b011 ) ? datain : ram_q[3];
    assign data_reg[4] = ( waddr == 3'b100 ) ? datain : ram_q[4];
    assign data_reg[5] = ( waddr == 3'b101 ) ? datain : ram_q[5];
    always @(ram_q or we or waddr or raddr)
    begin
        case ( raddr )
            3'b000 : dataout_tmp = ram_q[0];
            3'b001 : dataout_tmp = ram_q[1];
            3'b010 : dataout_tmp = ram_q[2];
            3'b011 : dataout_tmp = ram_q[3];
            3'b100 : dataout_tmp = ram_q[4];
            3'b101 : dataout_tmp = ram_q[5];
            default : dataout_tmp = 0;
        endcase
    end
    assign dataout = dataout_tmp;
endmodule