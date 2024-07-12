module uart_tx_26 #
(
    parameter DATA_WIDTH = 8
)
(
    input  wire                   clk,
    input  wire                   rst,
    input  wire [DATA_WIDTH-1:0]  input_axis_tdata,
    input  wire                   input_axis_tvalid,
    output wire                   input_axis_tready,
    output wire                   txd,
    output wire                   busy,
    input  wire [3:0]            uart_data_width,
    input  wire [1:0]            uart_bits,
    input  wire [1:0]            uart_parity,
	input  wire [1:0]            uart_stopbit,
    input  wire [15:0]            prescale
);
reg input_axis_tready_reg = 0;
reg txd_reg = 1;
reg busy_reg = 0;
reg [DATA_WIDTH+2:0] data_reg = 0;
reg [18:0] prescale_reg = 0;
reg [3:0] bit_cnt = 0;
assign input_axis_tready = input_axis_tready_reg;
assign txd = txd_reg;
assign busy = busy_reg;
genvar idx;
wire parity;
wire [DATA_WIDTH-1:0] bitmask_parity;
wire [DATA_WIDTH-1:0] bitmask_parity_reversed;
assign bitmask_parity = ~((1<<uart_bits) - 1);
generate
    for(idx = 0; idx < DATA_WIDTH; idx = idx + 1) begin : PROCESS_REVERSE_BITS
        assign bitmask_parity_reversed[idx] = bitmask_parity[DATA_WIDTH-idx-1];
    end
endgenerate
assign parity = (^(input_axis_tdata & bitmask_parity_reversed)) ^ uart_parity[1];
always @(posedge clk) begin
    if (rst) begin
        input_axis_tready_reg <= 0;
        txd_reg <= 1;
        prescale_reg <= 0;
        bit_cnt <= 0;
        busy_reg <= 0;
    end else begin
        if (prescale_reg > 0) begin
            input_axis_tready_reg <= 0;
            prescale_reg <= prescale_reg - 1;
        end else if (bit_cnt == 0) begin
            input_axis_tready_reg <= 1;
            busy_reg <= 0;
            if (input_axis_tvalid) begin
                input_axis_tready_reg <= ~input_axis_tready_reg;
                prescale_reg <= (prescale << 3)-1;
                bit_cnt <= uart_data_width+(uart_stopbit?2:1);
				if(uart_parity == 2'b00)
				case(uart_bits)
					2'b00: data_reg <= {3'b111, input_axis_tdata};
					2'b01: data_reg <= {4'b1111, input_axis_tdata[DATA_WIDTH-2:0]};
					2'b10: data_reg <= {5'b11111, input_axis_tdata[DATA_WIDTH-3:0]};
					2'b11: data_reg <= {6'b111111, input_axis_tdata[DATA_WIDTH-4:0]};
				endcase
				else
				case(uart_bits)
					2'b00: data_reg <= {2'b11, parity, input_axis_tdata};
					2'b01: data_reg <= {3'b111, parity, input_axis_tdata[DATA_WIDTH-2:0]};
					2'b10: data_reg <= {4'b1111, parity, input_axis_tdata[DATA_WIDTH-3:0]};
					2'b11: data_reg <= {5'b11111, parity, input_axis_tdata[DATA_WIDTH-4:0]};
				endcase
                txd_reg <= 0;
                busy_reg <= 1;
            end
        end else begin
            if (bit_cnt > 1) begin
                bit_cnt <= bit_cnt - 1;
                if (bit_cnt == 2 && uart_stopbit[1] == 1'b1) prescale_reg <= (prescale << 2)-1;
				else prescale_reg <= (prescale << 3)-1;
                {data_reg, txd_reg} <= {1'b0, data_reg};
            end else if (bit_cnt == 1) begin
                bit_cnt <= bit_cnt - 1;
                prescale_reg <= (prescale << 3);
                txd_reg <= 1;
            end
        end
    end
end
endmodule