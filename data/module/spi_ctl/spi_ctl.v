module spi_ctl(
    input            nss,
                     mosi,
                     sck,
    output           miso,
    output reg [6:0] address_bus,
    inout      [7:0] data_bus,
    output reg       read_n,
    output reg       write_n);
    reg [8:0] count;
	reg mosi_sample;
    reg [7:0] write_data_bus;
    assign data_bus = (~(write_n | ~read_n)) ? write_data_bus : 8'bz;
	reg [7:0] r_reg;
	wire [7:0] r_next;
	assign r_next = {r_reg[6:0], mosi_sample};
    assign miso = r_reg[7];
    reg start;
    always @(negedge nss, posedge sck) begin
        if (sck)
            start <= 1'b0;
        else
            start <= 1'b1;
    end
    always @(posedge sck, posedge nss) begin
        count <= 1;
        if (nss) begin
            read_n <= 1'b1; 
        end else begin
            mosi_sample <= mosi;
            if (start) begin
                count  <= 1;
                read_n <= 1'b1; 
            end else begin
                count       <= count + 1;
            end
            if (7 == count) begin
                address_bus <= {r_reg[5:0], mosi};
                if (r_reg[6] == 1'b1)
                    read_n <= 1'b0; 
            end else if (15 == count && read_n == 1'b1) begin
                write_data_bus <= {r_reg[6:0], mosi};
            end
        end
    end
    always @(negedge sck, posedge nss) begin
        r_reg <= 8'h00;
        if (nss) begin
            write_n <= 1'b1; 
        end else begin
            r_reg <= r_next;
            if (1 == count) begin
                write_n <= 1'b1; 
            end else if (8 == count) begin
                if (1'b0 == read_n)
                    r_reg <= data_bus;
            end else if (16 == count) begin
                if (read_n == 1'b1)
                    write_n <= 1'b0; 
            end
        end
    end
endmodule