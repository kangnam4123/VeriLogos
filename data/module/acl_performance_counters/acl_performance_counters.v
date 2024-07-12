module acl_performance_counters(
	reset_n, clock, restart, valid_data,
	basic_block_state,
	log_start,
   trigger_log_on_FIFO_depth_activity,
   trigger_FIFO_number,
	is_valid_log,
   cycle_number,
	address, readdata, writedata, write);
   localparam NUMBER_FIFO_DEPTH_REGS = 64;
   localparam NUMBER_STALL_COUNTERS = 128;
	input reset_n, clock, restart, valid_data;
	input [2047:0] basic_block_state;
	input [4:0] address;
	input [31:0] log_start;
   input trigger_log_on_FIFO_depth_activity;
   input [31:0] trigger_FIFO_number;
	output reg [31:0] readdata;
	output [31:0] cycle_number;
	output is_valid_log;
	input [31:0] writedata;
	input write;
	reg [31:0] FIFO_depth_max_regs [NUMBER_FIFO_DEPTH_REGS];
	reg [31:0] stall_counters [NUMBER_STALL_COUNTERS];
	reg [31:0] cycle_counter;
	reg [31:0] num_shifts;
	wire [7:0] internal_depth_wires [NUMBER_FIFO_DEPTH_REGS];
	reg internal_stall_regs [NUMBER_STALL_COUNTERS];
	generate
		genvar index;
		for(index = 0; index < NUMBER_FIFO_DEPTH_REGS; index = index + 1)
		begin: fifo_depth_counter_logic
			assign internal_depth_wires[index] = basic_block_state[(index+1)*8 - 1: index*8];
			always@(posedge clock or negedge reset_n)
			begin
				if (~reset_n)
					FIFO_depth_max_regs[index] <= 32'd0;
				else 
				begin
					if (restart)
					begin
						FIFO_depth_max_regs[index] <= 32'd0;
					end
					else if (valid_data)
					begin
                  if (internal_depth_wires[index] > FIFO_depth_max_regs[index][7:0])
                     FIFO_depth_max_regs[index] <= {1'b0, internal_depth_wires[index]};
                  else
                     FIFO_depth_max_regs[index] <= FIFO_depth_max_regs[index];
					end
				end
			end
		end
	endgenerate
   generate
		genvar index_stalls;
		for(index_stalls = 0; index_stalls < NUMBER_STALL_COUNTERS; index_stalls = index_stalls + 1)
		begin: stall_counter_logic
         always@(posedge clock or negedge reset_n)
			begin
				if (~reset_n)
					internal_stall_regs[index_stalls] <= 1'b0;
				else 
				begin
					if (restart)
					begin
						internal_stall_regs[index_stalls] <= 1'b0;
					end
					else if (valid_data)
					begin
                     internal_stall_regs[index_stalls] <= basic_block_state[64*8 + index_stalls];
					end
				end
			end
			always@(posedge clock or negedge reset_n)
			begin
				if (~reset_n)
					stall_counters[index_stalls] <= 32'd0;
				else 
				begin
					if (restart)
					begin
						stall_counters[index_stalls] <= 32'd0;
					end
					else if (valid_data)
					begin
                  if (internal_stall_regs[index_stalls] == 1'b1 && ~(stall_counters[index_stalls][31]))
                     stall_counters[index_stalls] <= stall_counters[index_stalls] + 1'b1;
					end
				end
			end
		end
	endgenerate
   wire [NUMBER_FIFO_DEPTH_REGS-1:0] fifo_lsbits;
   generate
		genvar fifo_index;
		for(fifo_index = 0; fifo_index < NUMBER_FIFO_DEPTH_REGS; fifo_index = fifo_index + 1)
		begin: grab_FIFO_depth_lsbits
			assign fifo_lsbits[fifo_index] = internal_depth_wires[fifo_index][0]; 
		end
	endgenerate
	assign is_valid_log = ({1'b0, cycle_counter} >= {1'b0, log_start}) && ((internal_depth_wires[trigger_FIFO_number[$clog2(NUMBER_FIFO_DEPTH_REGS)-1:0]][2]) || ~trigger_log_on_FIFO_depth_activity);
   assign cycle_number = cycle_counter;
	always@(posedge clock or negedge reset_n)
	begin
		if (~reset_n)
		begin
			cycle_counter <= 32'd0;
			num_shifts <= 32'd0;
		end
		else 
		begin
			if (restart)
			begin
				cycle_counter <= 32'd0;
			end
			else if (valid_data)
			begin
				if (cycle_counter[31])
					cycle_counter <= {1'b0, cycle_counter[31:1]};
				else
					cycle_counter <= cycle_counter + 1'b1;
			end
			if (restart)
			begin
				num_shifts <= 32'd0;
			end
			else if (valid_data)
			begin
				if (cycle_counter[31])
					num_shifts <= num_shifts + 1'b1;
			end			
		end
	end
	always@(*)
	begin
		if ((write) && (address == 5'h02))
      begin
         if (writedata == 32'h100)
            readdata <= cycle_counter;
         else if (writedata == 32'h101)
            readdata <= num_shifts;
         else if (writedata[31:6] == 26'h0)
            readdata <= FIFO_depth_max_regs[writedata[5:0]];
         else if (writedata[31:7] == 25'h01)
            readdata <= stall_counters[writedata[6:0]];
         else
            readdata <= 32'hABCDEFF0;
      end
	end
endmodule