module alu_62(clk, rst, en, opcode, a_in, b_in, o, z, n, cond, d_out);
	parameter width = 'd16; 
	input wire clk , rst , en ; 
	input wire [4:0] opcode ;
	input wire signed [width-1:0] a_in , b_in ;
	output reg o ;
	output wire z , n ;
	output reg cond ;
	output wire [width-1:0] d_out ;
	reg [1:0] chk_oflow ;
	reg signed [width+width:0] res_out ;
	assign z = ~|res_out; 
	assign n = res_out[width-1]; 
	assign d_out [width-1:0] = res_out [width-1:0];
	always@(chk_oflow, res_out) begin
		case(chk_oflow) 
			2'b00: o = 1'b0;
			2'b01: begin
				if(res_out [width:width-1] == (2'b01 || 2'b10)) o = 1'b1; 
				else o <= 1'b0;
			end
			2'b10: begin
				if((res_out[width+width]) && (~res_out [width+width-1:width-1] != 0)) o = 1'b1; 
				else if ((~res_out[width+width]) && (res_out [width+width-1:width-1] != 0)) o = 1'b1; 
				else o = 1'b0;
			end
			2'b11: o = 1'b0;
			default: o = 1'b0;
		endcase
	end
	always@(posedge clk) begin
		if(rst) begin
			cond <= 1'b0;
			chk_oflow <= 2'b0;
			res_out [width+width:0] <= {width+width{1'b0}};
		end else if(en) begin
			case(opcode) 
				5'b00000: res_out [width-1:0] <= 0; 
				5'b00001: res_out [width-1:0] <= a_in [width-1:0]; 
				5'b00010: res_out [width-1:0] <= b_in [width-1:0]; 
				5'b00011: begin
					chk_oflow <= 2'b01;
					res_out [width:0] <= a_in [width-1:0] + 1'b1; 
				end
				5'b00100: begin
					chk_oflow <= 2'b01;
					res_out [width:0] <= a_in [width-1:0] - 1'b1; 
				end
				5'b00101: begin
					chk_oflow <= 2'b01;
					res_out [width:0] <= {a_in[width-1], a_in [width-1:0]} + {b_in[width-1], b_in [width-1:0]}; 
				end
				5'b00110: begin
					chk_oflow <= 2'b01;
					res_out [width:0] <= {a_in[width-1], a_in [width-1:0]} - {b_in[width-1], b_in [width-1:0]}; 
				end
				5'b00111: begin
					chk_oflow <= 2'b10;
					res_out [width+width:0] <= a_in [width-1:0] * b_in [width-1:0]; 
				end
				5'b01000: begin
					if(a_in [width-1:0] == b_in [width-1:0]) cond <= 1'b1; 
					else cond <= 1'b0;
				end
				5'b01001: begin
					if(a_in [width-1:0] < b_in [width-1:0]) cond <= 1'b1; 
					else cond <= 1'b0;
				end
				5'b01010: begin
					if(a_in [width-1:0] > b_in [width-1:0]) cond <= 1'b1;
					else cond <= 1'b0;
				end
				5'b01011: res_out [width-1:0] <= ~a_in [width-1:0]; 
				5'b01100: res_out [width-1:0] <= ~a_in [width-1:0] + 1'b1; 
				5'b01101: res_out [width-1:0] <= a_in [width-1:0] & b_in [width-1:0]; 
				5'b01110: res_out [width-1:0] <= a_in [width-1:0] | b_in [width-1:0]; 
				5'b01111: res_out [width-1:0] <= a_in [width-1:0] ^ b_in [width-1:0]; 
				5'b10000: res_out [width-1:0] <= {a_in [width-2:0], 1'b0}; 
				5'b10001: res_out [width-1:0] <= {1'b0, a_in [width-1:1]}; 
				5'b10010: res_out [width-1:0] <= {a_in [width-1], a_in [width-1:1]}; 
				5'b10011: res_out [width-1:0] <= {a_in [width-2:0], a_in [width-1]}; 
				5'b10100: res_out [width-1:0] <= {a_in [0], a_in [width-1:1]}; 
				default: begin
					cond <= 1'b0;
					res_out [width-1:0] <= 0;
				end
			endcase
		end
	end
endmodule