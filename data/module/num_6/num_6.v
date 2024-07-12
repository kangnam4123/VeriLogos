module num_6(
    input [2:0] in_row,
    output reg [4:0] out_code
    );
parameter [4:0] d_0 = 5'b01110; 
parameter [4:0] d_1 = 5'b00001; 
parameter [4:0] d_2 = 5'b01111; 
parameter [4:0] d_3 = 5'b10001; 
always @ *
begin
	case (in_row)
		3'b000:
			out_code = d_0;
		3'b001:
			out_code = d_1;
		3'b010:
			out_code = d_2;
		3'b011:
			out_code = d_3;
		3'b100:
			out_code = d_3;
		3'b101:
			out_code = d_0;
		default:
			out_code = 5'b0;
	endcase
end
endmodule