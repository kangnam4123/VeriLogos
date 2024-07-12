module deser400_ctrl
(
	input clk,
	input reset,
	input read,
	input write,
	input [3:0]address,
	input [31:0]writedata,
	output reg [31:0]readdata,
	output enable_I,
	output enable_II,
	output enable_III,
	output enable_IV,
	output phwrite_I,
	output phwrite_II,
	output phwrite_III,
	output phwrite_IV,
	output [3:0]phdata,
	output phenable_I,
	output phenable_II,
	output phenable_III,
	output phenable_IV,
	input [7:0]xorsum_I,
	input [7:0]xorsum_II,
	input [7:0]xorsum_III,
	input [7:0]xorsum_IV,
	input [3:0]phsel_I,
	input [3:0]phsel_II,
	input [3:0]phsel_III,
	input [3:0]phsel_IV,
	output reg [6:0]tp_sel_a,
	output reg [6:0]tp_sel_b,
	output reg pd_trig
);
	reg [1:0]pd_period;
	reg [3:0]deser_enable;  
	reg [3:0]phenable;  
	assign enable_I   = deser_enable[0];
	assign enable_II  = deser_enable[1];
	assign enable_III = deser_enable[2];
	assign enable_IV  = deser_enable[3];
	assign phenable_I   = phenable[0];
	assign phenable_II  = phenable[1];
	assign phenable_III = phenable[2];
	assign phenable_IV  = phenable[3];
	always @(posedge clk or posedge reset)
	begin
		if (reset)
		begin
			deser_enable <= 0;
			pd_period    <= 2'd1;
			phenable <= 0;
			tp_sel_a <= 0;
			tp_sel_b <= 0;
		end
		else if (write)
		begin
			case (address) 
			 4'd1: deser_enable <= writedata[3:0];
			 4'd2: pd_period    <= writedata[1:0];
			 4'd3: phenable     <= writedata[3:0];
			 4'd8: tp_sel_a     <= writedata[6:0];
			 4'd9: tp_sel_b     <= writedata[6:0];
			endcase
		end
	end
	reg [3:0]phwrite;
	always @(*)
	begin
		if (write && address == 4'd4)
			phwrite <= writedata[7:4];
		else
			phwrite <= 4'b0000;
	end
	assign phwrite_I   = phwrite[0];
	assign phwrite_II  = phwrite[1];
	assign phwrite_III = phwrite[2];
	assign phwrite_IV  = phwrite[3];
	assign phdata = writedata[3:0];
	always @(*)
	begin
		case (address)
			4'd5: readdata <= {xorsum_IV, xorsum_III, xorsum_II, xorsum_I};
			4'd6: readdata <= {16'd0, phsel_IV, phsel_III, phsel_II, phsel_I};
			default: readdata <= 32'd0;
		endcase
	end
	reg [6:0]cnt;
	reg carry;
	always @(*)
	begin
		case (pd_period)
			2'd0: carry <= cnt[3]; 
			2'd1: carry <= cnt[4]; 
			2'd2: carry <= cnt[5]; 
			2'd3: carry <= cnt[6]; 
		endcase
	end
	always @(posedge clk or posedge reset)
	begin
		if (reset)
		begin
			cnt   <= 0;
			pd_trig <= 0;
		end
		else
		begin
			cnt <= carry ? 5'd0 : cnt + 5'd1;
			pd_trig <= carry;
		end
	end
endmodule