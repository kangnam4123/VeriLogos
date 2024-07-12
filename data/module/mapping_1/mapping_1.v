module mapping_1 #(
	parameter IN_WIDTH = 128,
	parameter OUT_WIDTH = 16
)(
	input wire clk,
	input wire reset,
	input wire trigger,
	input wire [IN_WIDTH-1:0] dataIn,
	output reg done,
	output reg [OUT_WIDTH-1:0] dataOut,
	output reg xorOut	
	);
	wire [15:0] response;
	reg startPUF;
	reg PUFreset;
	reg [4:0] countWait;
	integer ind;
	reg [15:0] sum;
	localparam IDLE = 0;
	localparam COMPUTE = 1;
	reg mp_state;
	reg [IN_WIDTH-1:0] buffer;
	always @ (posedge clk) begin
		if (reset) begin
			done <= 0;
			dataOut <= 0;
			mp_state <= IDLE;
			startPUF <= 0;
			countWait <= 0;
			PUFreset <=1;
		end
		else begin
			case(mp_state)
				IDLE: begin
					done <= 0;
					sum <= 0;
					PUFreset <= 0;
					countWait <=0;
					startPUF <=0;
					if(trigger == 1)
						mp_state <= COMPUTE;
						buffer <= dataIn;
				end
				COMPUTE: begin
					startPUF <=1;
					countWait <= countWait + 1;
					if (countWait == 15) begin 
						startPUF<=0;
						dataOut <= response;
						done <= 1;
						mp_state <= IDLE;
						PUFreset <=1;
					end
				end
			endcase
		end
	end
endmodule