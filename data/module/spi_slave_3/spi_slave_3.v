module spi_slave_3 #(
    parameter                              SLAVE_ID         = 0
) (
    input                               clk_in,
    input                               data_in,
    input                               slave_select_in,
    output reg                          data_out,
    input                               rst_in    
);
    localparam BYTE_SIZE = 8; 
    localparam BYTE_INDEX_SIZE = $clog2(BYTE_SIZE); 
    reg [BYTE_SIZE-1:0] data_recv;
    reg [BYTE_SIZE-1:0] data_send;
    reg [BYTE_INDEX_SIZE-1:0] send_iterator;
    reg [BYTE_INDEX_SIZE-1:0] recv_iterator;
    reg transferring;
    reg transferred;
    always @(posedge clk_in or posedge rst_in) begin
        if(rst_in == 1'b1) begin
            data_recv <= 0;
            data_send <= 8'hAA;
            send_iterator <= 1;
            recv_iterator <= 0;
            data_out <= 1'bz;
            transferring <= 1;
            transferred <= 0;
        end
        else begin
            if (transferring == 1'b0) begin
                data_out <= data_send[send_iterator];
                if (!transferred) begin
                    data_recv[recv_iterator] <= data_in;
                    recv_iterator <= recv_iterator + 1;
                end
                else
                    data_send <= data_recv;
                 if (send_iterator < BYTE_SIZE - 1) begin
                    send_iterator <= send_iterator + 1;
                 end
                 if (recv_iterator >= BYTE_SIZE - 1) begin
                    transferred <= 1;
                 end
            end
            else begin
                if (slave_select_in == 1'b0) begin
                    data_out <= data_send[0];
                    transferred <= 0;
                    send_iterator <= 1;
                    recv_iterator <= 0;
                end
                else begin
                    data_out <= 1'bz;
                end
            end
            transferring <= slave_select_in;
        end
    end
endmodule