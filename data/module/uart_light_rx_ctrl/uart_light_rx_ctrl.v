module uart_light_rx_ctrl
#(
	 parameter STATE_COUNT = 3,
	 parameter IDLE = 3'b001,
	 parameter STARTING = 3'b010,
	 parameter RECEIVING = 3'b100
)(
	input  wire reset,
	input  wire clk_rx,
	input  wire read_ready,
	output wire fifo_rx_full,
	output wire fifo_rx_empty,
	input  wire bit_eq_0,
	input  wire sc_halb,
	input  wire sc_full,
	input  wire frame_done,
	output reg  sc_inc,
	output reg  sc_clr,
	output reg  bc_inc,
	output reg  bc_clr,
	output reg  shift,
	output reg  fifo_write_enable,
	input  wire fifo_full,
	input  wire fifo_empty,
	output wire fifo_read_enable
    );
	 reg [STATE_COUNT-1:0] state_cur, state_next;
	 reg err_recover, err_recover_next;
	 assign fifo_rx_full     = fifo_full;
	 assign fifo_rx_empty    = fifo_empty;
	 assign fifo_read_enable = read_ready & (~fifo_empty);
	 always @(state_cur, bit_eq_0, sc_halb, sc_full, frame_done) begin
		sc_inc = 1'b0;
		sc_clr = 1'b0;
		bc_inc = 1'b0;
		bc_clr = 1'b0;
		shift  = 1'b0;
		fifo_write_enable = 1'b0;
		state_next = IDLE;
		err_recover_next = err_recover;
		case(state_cur)
			IDLE:
				if(bit_eq_0 == 1'b1) begin
					state_next = STARTING;
				end
			STARTING:
				if(bit_eq_0 == 1'b0) begin
					sc_clr = 1'b1;
					state_next = IDLE;
				end
				else if(sc_halb == 1'b1) begin
					sc_clr = 1'b1;
					state_next = RECEIVING;
				end
				else begin
					sc_inc = 1'b1;
					state_next = STARTING;
				end
			RECEIVING:
                            if (err_recover) begin
                                state_next = IDLE;
                                err_recover_next = 1'b0;
                            end else begin
				if(sc_full == 1'b1) begin
					sc_clr = 1'b1;
					if(frame_done) begin
						bc_clr = 1'b1;
						state_next = IDLE;						
						if (!bit_eq_0) begin
                                                    fifo_write_enable = 1'b1;
						end else begin
						    err_recover_next = 1'b1;
						end
					end
					else begin
						shift  = 1'b1;
						bc_inc = 1'b1;
						state_next = RECEIVING;
					end
				end
				else begin
					sc_inc = 1'b1;
					state_next = RECEIVING;
				end
                            end
			default: state_next = IDLE;
		endcase
	 end
	 always @(posedge clk_rx, posedge reset) begin
		if(reset) begin
			state_cur <= IDLE;
			err_recover <= 1'b0;
		end
		else begin 
			state_cur <= state_next;
			err_recover <= err_recover_next;
		end
	 end
endmodule