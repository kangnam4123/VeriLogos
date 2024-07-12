module memory_epp(
	input wire mclk,
	input wire epp_astb,
	input wire epp_dstb,
	input wire epp_wr,
	output reg epp_wait,
	inout wire[7:0] epp_data,
	input wire[7:6] status,
	input wire[31:0] address,
	output wire[31:0] dout,
	input wire[31:0] din,
	output reg complete,
	input wire complete_clr
);
wire[7:0] address_array[0:3];
assign address_array[0] = address[7:0];
assign address_array[1] = address[15:8];
assign address_array[2] = address[23:16];
assign address_array[3] = address[31:24];
wire[7:0] din_array[0:3];
assign din_array[0] = din[7:0];
assign din_array[1] = din[15:8];
assign din_array[2] = din[23:16];
assign din_array[3] = din[31:24];
reg[7:0] dout_array[0:3];
assign dout[31:0] = {dout_array[3], dout_array[2], dout_array[1], dout_array[0]};
reg[7:0] epp_data_reg;
assign epp_data = epp_data_reg;
parameter max_index = 3;
reg[2:0] index = 0;
parameter epp_reg_status = 8'd0;
parameter epp_reg_mem_addr = 8'd1;
parameter epp_reg_mem_data = 8'd2;
reg[7:0] epp_address = 0;
parameter epp_state_idle = 3'b000;
parameter epp_state_data_read = 3'b001;
parameter epp_state_data_write = 3'b010;
parameter epp_state_addr_read = 3'b011;
parameter epp_state_addr_write = 3'b100;
reg[2:0] epp_state = epp_state_idle;
always @ (posedge mclk) begin
	if(complete_clr == 1) begin
		complete <= 0;
	end else begin
		case(epp_state)
			epp_state_addr_read: begin
				epp_wait <= 1;
				epp_data_reg <= epp_address;
				if(epp_astb == 1) begin
					epp_state <= epp_state_idle;
				end
			end
			epp_state_addr_write: begin
				epp_wait <= 1;
				epp_address <= epp_data;
				index <= 0;
				if(epp_astb == 1) begin
					epp_state <= epp_state_idle;
				end
			end
			epp_state_data_read: begin
				epp_wait <= 1;
				case(epp_address)
					epp_reg_status:
						epp_data_reg <= {status, 6'b0};
					epp_reg_mem_addr:
						epp_data_reg <= address_array[index];
					epp_reg_mem_data:
						epp_data_reg <= din_array[index];
					default:
						epp_data_reg <= 0;
				endcase
				if(epp_dstb == 1) begin
					if(epp_address == epp_reg_mem_data && index == max_index) begin
						complete <= 1;
					end
					index <= index + 1;
					epp_state <= epp_state_idle;
				end
			end
			epp_state_data_write: begin
				epp_wait <= 1;
				if(epp_address == epp_reg_mem_data) begin
					dout_array[index] <= epp_data;
				end
				if(epp_dstb == 1) begin
					if(epp_address == epp_reg_mem_data && index == max_index) begin	
						complete <= 1;
					end
					index <= index + 1;
					epp_state <= epp_state_idle;
				end
			end
			default: begin
				if(epp_astb == 0) begin
					if(epp_wr == 0) begin
						epp_state <= epp_state_addr_write;
					end else begin
						epp_state <= epp_state_addr_read;
					end
				end else if(epp_dstb == 0) begin
					if(epp_wr == 0) begin
						epp_state <= epp_state_data_write;
					end else begin
						epp_state <= epp_state_data_read;
					end
				end
				epp_wait <= 0; 
				epp_data_reg <= 8'bZZZZZZZZ;
			end
		endcase
	end
end
endmodule