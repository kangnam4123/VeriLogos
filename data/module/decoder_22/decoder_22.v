module decoder_22(
	input we,
	input rdt,
	input [3:0] addr,
	input [7:0] countl0,
	input [7:0] counthfrozen0,
	input [7:0] countl1,
	input [7:0] counthfrozen1,
	input [7:0] countl2,
	input [7:0] counthfrozen2,
	input [7:0] controlrdata,
	input [7:0] hwconfig,
	input [7:0] configrdreg0,
	input [7:0] configrdreg1,
	input [7:0] configrdreg2,
	output [7:0] rddata,
	output countlread0,
	output pwmld0,
	output cfgld0,
	output countlread1,
	output pwmld1,
	output cfgld1,
	output countlread2,
	output pwmld2,
	output cfgld2,
	output ctrlld,
	output wdogdivld,
	output wdreset);
	reg regdecr0;
	reg regdecw0;
	reg regdecw2;
	reg regdecr4;
	reg regdecw4;
	reg regdecw6;
	reg regdecr8;
	reg regdecw8;
	reg regdecwa;
	reg regdecwe;
	reg regdecwf;
	reg regdecrf;
	reg [7:0] rddatareg;
	initial regdecr0 = 0;
	initial regdecw0 = 0;
	initial regdecw2 = 0;
	initial regdecr4 = 0;
	initial regdecw4 = 0;
	initial regdecw6 = 0;
	initial regdecr8 = 0;
	initial regdecw8 = 0;
	initial regdecwa = 0;		
	initial regdecwe = 0;
	initial regdecwf = 0;
	initial regdecrf = 0;
	assign countlread0 = regdecr0;
	assign countlread1 = regdecr4;
	assign countlread2 = regdecr8;
	assign pwmld0 = regdecw0;
	assign pwmld1 = regdecw4;
	assign pwmld2 = regdecw8;
	assign cfgld0 = regdecw2;
	assign cfgld1 = regdecw6;
	assign cfgld2 = regdecwa;
	assign ctrlld = regdecwf;
	assign wdogdivld = regdecwe;
	assign wdreset = regdecrf;
	assign rddata = rddatareg;
	always @(*) begin
		rddatareg <= 8'h00;
		regdecr0 <= 0;
		regdecw0 <= 0;
		regdecw2 <= 0;
		regdecr4 <= 0;
		regdecw4 <= 0;
		regdecw6 <= 0;
		regdecr8 <= 0;
		regdecw8 <= 0;
		regdecwa <= 0;
		regdecwe <= 0;
		regdecwf <= 0;
		regdecrf <= 0;
		case(addr)
			4'h0: begin
				rddatareg <= countl0;
				regdecw0 <= we;
				regdecr0 <= rdt;
			end
			4'h1: begin
				rddatareg <= counthfrozen0;
			end
			4'h2: begin
				regdecw2 <= we;
				rddatareg <= configrdreg0;
			end
			4'h4: begin
				rddatareg <= countl1;
				regdecw4 <= we;
				regdecr4 <= rdt;
			end
			4'h5: begin
				rddatareg <= counthfrozen1;
			end
			4'h6: begin
				regdecw6 <= we;
				rddatareg <= configrdreg1;
			end
			4'h8: begin
				rddatareg <= countl2;
				regdecw8 <= we;
				regdecr8 <= rdt;
			end
			4'h9: begin
				rddatareg <= counthfrozen2;
			end
			4'ha: begin
				regdecwa <= we;   
				rddatareg <= configrdreg2;  
			end
			4'h3, 4'h7,
			4'hb, 4'hc: begin
				rddatareg <= 8'h00;
			end
			4'hd:
				rddatareg <= hwconfig;
			4'he:
				regdecwe <= we;
			4'hf:
				begin
					rddatareg <= controlrdata;
					regdecwf <= we;
					regdecrf <= rdt;
				end
			default: begin
				rddatareg <= 8'bxxxxxxxx;
				regdecr0 <= 1'bx;
				regdecr4 <= 1'bx;
				regdecr8 <= 1'bx;
				regdecw0 <= 1'bx;
				regdecw2 <= 1'bx;
				regdecwf <= 1'bx;
				regdecw4 <= 1'bx;
				regdecw6 <= 1'bx;
				regdecw8 <= 1'bx;
				regdecwa <= 1'bx;
			end
		endcase
	end
endmodule