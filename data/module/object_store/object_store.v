module object_store(
	input wire mclk,
	input wire stall,
	input wire reset,
	output reg[31:0] mem_address = 0,
	output reg[31:0] mem_din,
	input wire[31:0] mem_dout,
	output reg mem_re = 0,
	output reg mem_we = 0,
	input wire [4:0] slot_index,
	output wire[31:0] slot_value,
	output reg initialized = 0
);
parameter state_reset = 2'b00;
parameter state_load_ptr = 2'b01;
parameter state_load_regs = 2'b10;
parameter state_complete = 2'b11;
reg[1:0] state = state_reset;
parameter last_slot = 5'd26;
reg[4:0] store_index = 0;
reg[31:0] slots[0:26];
wire has_control = !stall && !mem_re && !mem_we;
assign slot_value = slots[slot_index];
always @ (posedge mclk) begin
	if(reset) begin
		state <= state_reset;
	end else begin
		if(has_control) begin
			case(state)
				state_reset: begin
					mem_address <= 31'b0;
					mem_re <= 1;
					state <= state_load_ptr;
					store_index <= 0;
					initialized <= 0;
				end
				state_load_ptr: begin
					mem_address <= mem_dout + 2; 
					mem_re <= 1;
					state <= state_load_regs;
				end
				state_load_regs: begin
					slots[store_index] <= mem_dout;
					if(store_index == last_slot) begin
						state <= state_complete;
						initialized <= 1;
					end else begin
						mem_address <= mem_address + 1;
						store_index <= store_index + 1;
						mem_re <= 1;
					end
				end
				default: begin
				end
			endcase
		end else begin
			mem_we <= 0;
			mem_re <= 0;
		end
	end
end
endmodule