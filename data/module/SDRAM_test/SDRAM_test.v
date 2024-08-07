module SDRAM_test(
    input wire clock,
    input wire reset_n,
    output reg [28:0] address,
    output wire [7:0] burstcount,
    input wire waitrequest,
    input wire [63:0] readdata,
    input wire readdatavalid,
    output reg read,
    output reg [63:0] writedata,
    output wire [7:0] byteenable,
    output reg write,
    output wire [31:0] debug_value0,
    output wire [31:0] debug_value1
);
localparam STATE_INIT = 4'h0;
localparam STATE_WRITE_START = 4'h1;
localparam STATE_WRITE_WAIT = 4'h2;
localparam STATE_READ_START = 4'h3;
localparam STATE_READ_WAIT = 4'h4;
localparam STATE_DONE = 4'h5;
reg [3:0] state;
assign burstcount = 8'h01;
assign byteenable = 8'hFF;
reg [63:0] data;
localparam TEST_ADDRESS = 29'h0700_0000;
assign debug_value0 = { 3'b0, waitrequest, 3'b0, readdatavalid, 3'b0, read, 3'b0, write, 12'b0, state };
assign debug_value1 = data[47:16];
always @(posedge clock or negedge reset_n) begin
    if (!reset_n) begin
        state <= STATE_INIT;
        address <= 29'h0;
        read <= 1'b0;
        writedata <= 64'h0;
        write <= 1'b0;
    end else begin
        case (state)
            STATE_INIT: begin
                state <= STATE_WRITE_START;
                data <= 64'h2357_1113_1719_2329;
            end
            STATE_WRITE_START: begin
                address <= TEST_ADDRESS;
                writedata <= 64'hDEAD_BEEF_CAFE_BABE;
                write <= 1;
                state <= STATE_WRITE_WAIT;
            end
            STATE_WRITE_WAIT: begin
                if (!waitrequest) begin
                    address <= 29'h0;
                    writedata <= 64'h0;
                    write <= 1'b0;
                    state <= STATE_READ_START;
                end
            end
            STATE_READ_START: begin
                address <= TEST_ADDRESS;
                read <= 1'b1;
                state <= STATE_READ_WAIT;
            end
            STATE_READ_WAIT: begin
                if (!waitrequest) begin
                    address <= 29'h0;
                    read <= 1'b0;
                end
                if (readdatavalid) begin
                    data <= readdata;
                    state <= STATE_DONE;
                end
            end
            STATE_DONE: begin
            end
            default: begin
                state <= STATE_INIT;
            end
        endcase
    end
end
endmodule