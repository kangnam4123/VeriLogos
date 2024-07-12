module cache_controller(clk, rst_n, i_addr, d_addr, wr_data, i_acc, d_acc, read, write, i_hit, d_hit, dirty, mem_rdy, d_tag, d_line, m_line, i_data, i_we, d_data, d_dirt_in, d_we, d_re, m_re, m_we, m_addr, m_data, rdy);
input clk, rst_n, i_hit, d_hit, dirty, mem_rdy, i_acc, d_acc, read, write;
input [7:0] d_tag;
input [15:0] i_addr, d_addr, wr_data;
input [63:0] d_line, m_line;
output reg i_we, d_we, d_re, m_we, m_re, d_dirt_in, rdy;
output reg [13:0] m_addr;
output reg [63:0] i_data, d_data, m_data;
reg [1:0] state, nextState;
reg [63:0] wiped;
localparam empty = 16'hFFFF; 
localparam START = 2'b00;
localparam EXTRA = 2'b01;
localparam SERVICE_MISS = 2'b10;
localparam WRITE_BACK = 2'b11;
always @(posedge clk, negedge rst_n)
	if(!rst_n) begin
		state <= START;
	end else
		state <= nextState;
always @(*) begin 
	i_we = 1'b0;
	d_we = 1'b0;
	m_we = 1'b0;
	d_re = 1'b0;
	m_re = 1'b0;
	m_addr = 14'd0;
	i_data = 64'd0;
	d_data = 64'd0;
	m_data = d_line;
	d_dirt_in = 1'b0;
	rdy = 1'b0;
	nextState = START;
	case(state)
		START: 
			begin
				if(d_acc & !d_hit) begin 
					if(dirty) begin
						m_addr = {d_tag, d_addr[7:2]};
						m_we = 1'b1;
						nextState = WRITE_BACK;
					end else begin 
						m_addr = d_addr[15:2];
						m_re = 1'b1;
						nextState = SERVICE_MISS;
					end
				end else if(i_acc & !i_hit) begin
					m_addr = i_addr[15:2];
					m_re = 1'b1;
					nextState = SERVICE_MISS;
				end else begin 
					if(write)
						begin 
							d_we = 1'b1;
							wiped = d_line & ~(empty << 16 * d_addr[1:0]); 
							d_data = wiped | (wr_data << 16 * d_addr[1:0]); 
							d_dirt_in = 1'b1; 
						end
					rdy = 1'b1;
				end
			end
		SERVICE_MISS: 
			begin
				if(mem_rdy) begin 
					if(d_acc & !d_hit) begin 
						if(write) begin 
							d_we = 1'b1;
							wiped = m_line & ~(empty << 16 * d_addr[1:0]); 
							d_data = wiped | (wr_data << 16 * d_addr[1:0]); 
							d_dirt_in = 1'b1;
						end else begin 
							d_we = 1'b1;
							d_data = m_line;
						end
					end else begin 
						i_we = 1'b1;
						i_data = m_line;
					end
					nextState = START; 
				end else if(d_acc & !d_hit) begin 
					m_addr = d_addr[15:2];
					m_re = 1'b1;
					nextState = SERVICE_MISS;
				end else if(i_acc & !i_hit) begin 
					m_addr = i_addr[15:2];
					m_re = 1'b1;
					nextState = SERVICE_MISS;
				end
			end
		WRITE_BACK: 
			begin 
				m_addr = {d_tag, d_addr[7:2]}; 
				m_we = 1'b1;
				if(mem_rdy) begin
					nextState = EXTRA;
				end else begin
					nextState = WRITE_BACK;
				end
			end
		EXTRA:
			begin
				m_re = 1'b1;
				m_addr = d_addr[15:2];
				nextState = SERVICE_MISS;
			end
		default: 
			begin 
			end
	endcase
end
endmodule