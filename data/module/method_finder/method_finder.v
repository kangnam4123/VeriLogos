module method_finder(
	input wire mclk,
	input wire stall,
	input wire reset,
	output reg[31:0] mem_address = 0,
	output reg[31:0] mem_din = 0,
	input wire[31:0] mem_dout,
	output reg mem_re = 0,
	output reg mem_we = 0,
	output reg[4:0] os_index = 0,
	input wire[31:0] os_value,
	output reg initialized = 0,
	output reg[31:0] selected_method = 0,
	output reg found = 0,
	output reg missing = 0
);
parameter class_Scheduler_index = 5'd26;
parameter selector_start_index = 5'd10;
parameter state_reset = 4'd0;
parameter state_load_first_behavior = 4'd1;
parameter state_load_first_selector = 4'd2;
parameter state_idle = 4'd3;
parameter state_lookup_start = 4'd4;
parameter state_lookup_table = 4'd5;
parameter state_lookup_table_length = 4'd6;
parameter state_lookup_table_scan_method = 4'd7;
parameter state_lookup_table_scan_selector = 4'd8;
parameter state_lookup_next_behavior = 4'd9;
parameter state_lookup_found = 4'd10;
reg[2:0] state = state_reset;
reg[31:0] lookup_class = 0;
reg[31:0] lookup_selector = 0;
reg[31:0] this_slot = 0;
reg[31:0] this_slot_index = 0;
reg[31:0] final_slot_index = 0;
wire has_control = !stall && !mem_re && !mem_we;
always @ (posedge mclk) begin
	if(reset) begin
		state <= state_reset;
	end else begin
		if(has_control) begin
			case(state)
				state_reset: begin
					initialized <= 0;
					os_index <= class_Scheduler_index;
					state <= state_load_first_behavior;
				end
				state_load_first_behavior: begin
					lookup_class <= os_value;
					os_index <= selector_start_index;
					state <= state_load_first_selector;
				end
				state_load_first_selector: begin
					lookup_selector <= os_value;
					state <= state_lookup_start;
					initialized <= 1;
				end
				state_lookup_start: begin
					mem_address <= lookup_class + 2; 
					mem_re <= 1;
					state <= state_lookup_table;
				end
				state_lookup_table: begin
					mem_address <= mem_dout + 1; 
					mem_re <= 1;
					state <= state_lookup_table_length;
				end
				state_lookup_table_length: begin
					if(mem_dout == 0) begin
						state <= state_lookup_next_behavior;
					end else begin
						final_slot_index <= mem_dout - 1;
						this_slot_index <= 0;
						this_slot <= mem_address + 1; 
						mem_address <= mem_address + 1;
						mem_re <= 1;
						state <= state_lookup_table_scan_method;
					end
				end
				state_lookup_table_scan_method: begin
					mem_address <= mem_dout + 5; 
					mem_re <= 1;
					state <= state_lookup_table_scan_selector;
				end
				state_lookup_table_scan_selector: begin
					if(mem_dout == lookup_selector) begin
						mem_address <= this_slot; 
						state <= state_lookup_found;
					end else begin
						if(this_slot_index == final_slot_index) begin
							state <= state_lookup_next_behavior;
						end else begin
							this_slot_index <= this_slot_index + 1;
							this_slot <= this_slot + 1; 
							mem_address <= this_slot + 1;
							state <= state_lookup_table_scan_method;
						end
					end
				end
				state_lookup_next_behavior: begin
					missing <= 1;
					state <= state_idle;
				end
				state_lookup_found: begin
					selected_method <= mem_dout;
					found <= 1;
					state <= state_idle;
				end
				default: begin
				end
			endcase
		end else begin
			mem_re <= 0;
			mem_we <= 0;
		end
	end
end
endmodule