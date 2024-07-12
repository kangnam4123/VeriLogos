module spim(
    input clk,
    input rst,
    input[7:0] din,
    input wen,
    input wdiv,
    output rdy,
    output reg SCLK,
    output MOSI,
    output reg SSbar
    );
	wire tick;
	reg[7:0] clk_div_count;
	reg[1:0] state,n_state;
	reg shift;
	reg[7:0] div,data;
	reg nSSr,SCLKr;
	reg[3:0] bit_count;
	reg bit_count_rst,bit_count_en;
	always @(posedge clk or posedge rst) begin
		if(rst) clk_div_count <= 0;
		else
				if(tick) clk_div_count <= 0;
				else clk_div_count <= clk_div_count + 1;
	end
	assign tick = (clk_div_count == div);
	assign rdy = (state == 0);
	always @(posedge clk or posedge rst) begin
		if(rst) begin
			data <= 0;
			div <= 0;
		end
		else begin
			if(wen & rdy) data <= din;
			else if(shift & tick) data <= { data[6:0] , 1'b0 };
			if(wdiv) div <= din;
		end
	end
	assign MOSI = data[7];
	always @(posedge clk or posedge rst) begin
		if(rst) begin
			SSbar <= 1;
			SCLK <= 0;
		end
		else begin
			if(tick) begin
				SSbar <= nSSr;
				SCLK <= SCLKr;
			end
		end
	end
	always @(posedge clk or posedge rst) begin
		if(rst) bit_count <= 0;
		else
			if(bit_count_rst) bit_count <= 0;
			else if(tick & bit_count_en) bit_count <= bit_count + 1;
	end
	always @(posedge clk or posedge rst) begin
		if(rst) state <= 0;
		else state <= n_state;
	end
	always @(*) begin
		n_state <= state;
		nSSr <= 0;
		bit_count_rst <= 0;
		SCLKr <= 0;
		shift <= 0;
		bit_count_en <= 0;
		case(state)
			0: begin
					nSSr <= 1;
					if(wen) n_state <= 1;
				end
			1: begin
					bit_count_rst <= 1;
					if(tick) n_state <= 2;
				end
			2: begin
					SCLKr <= 1;
					if(tick) n_state <= 3;
				end
			3: begin
					shift <= 1;
					bit_count_en <= 1;
					if(tick)
						if(bit_count < 7) n_state <= 2;
						else n_state <= 0;
				end
		endcase
	end
endmodule