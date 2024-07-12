module axis_spi_slave #
(
    parameter DATA_WIDTH = 8
)
(
    input  wire                   clk,
    input  wire                   rst,
    input  wire [DATA_WIDTH-1:0]  input_axis_tdata,
    input  wire                   input_axis_tvalid,
    output wire                   input_axis_tready,
    input  wire                   input_axis_tlast,
    output wire [DATA_WIDTH-1:0]  output_axis_tdata,
    output wire                   output_axis_tvalid,
    input  wire                   output_axis_tready,
    output wire                   output_axis_tlast,
    input  wire                   cs,
    input  wire                   sck,
    input  wire                   mosi,
    output wire                   miso,
    output wire                   busy
);
localparam [1:0]
    STATE_IDLE = 2'd0,
    STATE_TRANSFER = 2'd1,
    STATE_WAIT = 2'd2;
reg [1:0] state_reg = STATE_IDLE, state_next;
reg [DATA_WIDTH-1:0] tx_data_reg = 0, tx_data_next;
reg [DATA_WIDTH-1:0] rx_data_reg = 0, rx_data_next;
reg [4:0] bit_cnt_reg = 0, bit_cnt_next;
reg input_axis_tready_reg = 0, input_axis_tready_next;
reg [DATA_WIDTH-1:0] output_axis_tdata_reg = 0, output_axis_tdata_next;
reg output_axis_tvalid_reg = 0, output_axis_tvalid_next;
reg output_axis_tlast_reg = 0, output_axis_tlast_next;
reg cs_reg = 1;
reg sck_reg = 0;
reg mosi_reg = 0;
reg miso_reg = 0, miso_next;
reg busy_reg = 0;
assign input_axis_tready = input_axis_tready_reg;
assign output_axis_tdata = output_axis_tdata_reg;
assign output_axis_tvalid = output_axis_tvalid_reg;
assign output_axis_tlast = output_axis_tlast_reg;
assign miso = miso_reg;
assign busy = busy_reg;
reg sck_last_reg = 0;
wire sck_posedge = sck_reg & !sck_last_reg;
wire sck_negedge = !sck_reg & sck_last_reg;
always @* begin
    state_next = 0;
    tx_data_next = tx_data_reg;
    rx_data_next = rx_data_reg;
    bit_cnt_next = bit_cnt_reg;
    input_axis_tready_next = 0;
    output_axis_tdata_next = output_axis_tdata_reg;
    output_axis_tvalid_next = output_axis_tvalid_reg & ~output_axis_tready;
    output_axis_tlast_next = output_axis_tlast_reg;
    miso_next = miso_reg;
    case (state_reg)
        STATE_IDLE: begin
            if (cs_reg) begin
                miso_next = 0;
                state_next = STATE_IDLE;
            end else begin
                if (input_axis_tvalid) begin
                    {miso_next, tx_data_next[DATA_WIDTH-1:1]} = input_axis_tdata;
                    input_axis_tready_next = 1;
                end else begin
                    miso_next = 0;
                    tx_data_next = 0;
                end
                rx_data_next = 0;
                bit_cnt_next = DATA_WIDTH-1;
                state_next = STATE_TRANSFER;
            end
        end
        STATE_TRANSFER: begin
            if (sck_posedge) begin
                rx_data_next = {rx_data_reg[DATA_WIDTH-2:0], mosi_reg};
                state_next = STATE_TRANSFER;
            end else if (sck_negedge) begin
                if (bit_cnt_reg > 0) begin
                    {miso_next, tx_data_next[DATA_WIDTH-1:1]} = tx_data_reg;
                    bit_cnt_next = bit_cnt_reg - 1;
                    state_next = STATE_TRANSFER;
                end else begin
                    if (input_axis_tvalid) begin
                        {miso_next, tx_data_next[DATA_WIDTH-1:1]} = input_axis_tdata;
                    end else begin
                        miso_next = 0;
                        tx_data_next = 0;
                    end
                    state_next = STATE_WAIT;
                end
            end else if (cs_reg) begin
                output_axis_tdata_next = 0;
                output_axis_tvalid_next = 1;
                output_axis_tlast_next = 1;
                state_next = STATE_IDLE;
            end else begin
                state_next = STATE_TRANSFER;
            end
        end
        STATE_WAIT: begin
            if (cs_reg) begin
                output_axis_tdata_next = rx_data_reg;
                output_axis_tvalid_next = 1;
                output_axis_tlast_next = 1;
                state_next = STATE_IDLE;
            end else if (sck_posedge) begin
                output_axis_tdata_next = rx_data_reg;
                output_axis_tvalid_next = 1;
                output_axis_tlast_next = 0;
                if (input_axis_tvalid) begin
                    {miso_next, tx_data_next[DATA_WIDTH-1:1]} = input_axis_tdata;
                    input_axis_tready_next = 1;
                end else begin
                    miso_next = 0;
                    tx_data_next = 0;
                end
                rx_data_next = mosi_reg;
                bit_cnt_next = DATA_WIDTH-1;
                state_next = STATE_TRANSFER;
            end else begin
                state_next = STATE_WAIT;
            end
        end
    endcase
end
always @(posedge clk or posedge rst) begin
    if (rst) begin
        state_reg <= STATE_IDLE;
        tx_data_reg <= 0;
        rx_data_reg <= 0;
        bit_cnt_reg <= 0;
        cs_reg <= 1;
        sck_reg <= 0;
        mosi_reg <= 0;
        sck_last_reg <= 0;
        input_axis_tready_reg <= 0;
        output_axis_tdata_reg <= 0;
        output_axis_tvalid_reg <= 0;
        output_axis_tlast_reg <= 0;
        miso_reg <= 0;
        busy_reg <= 0;
    end else begin
        state_reg <= state_next;
        tx_data_reg <= tx_data_next;
        rx_data_reg <= rx_data_next;
        bit_cnt_reg <= bit_cnt_next;
        cs_reg <= cs;
        sck_reg <= sck;
        mosi_reg <= mosi;
        sck_last_reg <= sck_reg;
        input_axis_tready_reg <= input_axis_tready_next;
        output_axis_tdata_reg <= output_axis_tdata_next;
        output_axis_tvalid_reg <= output_axis_tvalid_next;
        output_axis_tlast_reg <= output_axis_tlast_next;
        miso_reg <= miso_next;
        busy_reg <= state_next != STATE_IDLE;
    end
end
endmodule