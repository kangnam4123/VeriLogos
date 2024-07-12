module DIGITAL(Data, Seg);
input [3:0] Data;
output reg [7:0] Seg;
always @(*)
	begin
		case (Data)
				'd0: Seg[7:0] <= 8'b00000011;
				'd1: Seg[7:0] <= 8'b10011111;
				'd2: Seg[7:0] <= 8'b00100101;
				'd3: Seg[7:0] <= 8'b00001101;
				'd4: Seg[7:0] <= 8'b10011001;
				'd5: Seg[7:0] <= 8'b01001001;
				'd6: Seg[7:0] <= 8'b01000001;
				'd7: Seg[7:0] <= 8'b00011111;
				'd8: Seg[7:0] <= 8'b00000001;
				'd9: Seg[7:0] <= 8'b00001001;
				'd10: Seg[7:0] <= 8'b00010001;
				'd11: Seg[7:0] <= 8'b11000001;
				'd12: Seg[7:0] <= 8'b01100011;
				'd13: Seg[7:0] <= 8'b10000101;
				'd14: Seg[7:0] <= 8'b01100001;
				'd15: Seg[7:0] <= 8'b01110001;
				default: Seg[7:0] <= 8'b11111111;
		endcase
	end
endmodule