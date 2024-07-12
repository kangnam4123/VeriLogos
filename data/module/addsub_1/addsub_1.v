module addsub_1(
	data_c,overflow,
	data_a, data_b, sign, addsub
	);
	input  [31:0]    data_a;
	input  [31:0] 	 data_b;
	input 			 sign;
	input 			 addsub;
	output           overflow;
	reg    [32:0]    temp;
	output reg  [31:0] data_c;
	always @(addsub or data_a or data_b or sign) begin
		case ({addsub, sign})
			00:
				temp <= {data_a[31], data_a} + {data_b[31], data_b};
			01:
			    temp[31:0] <= data_a + data_b;
			10:
				temp <= {data_b[31], data_b} - {data_a[31], data_a};
			11:
				temp[31:0] <= data_b - data_a;
			default:
				data_c <= 32'h00000000;
		endcase 
		data_c <= temp[31:0];
	end
	assign overflow = temp[32] != temp[31];
endmodule