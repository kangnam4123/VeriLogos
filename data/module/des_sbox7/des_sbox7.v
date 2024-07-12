module des_sbox7
	(
		input  wire [0:5] right_xor_key_segment_din,
		output reg  [0:3] sbox_dout
	);
	always @(*)
		case ({right_xor_key_segment_din[0], right_xor_key_segment_din[5]})
			2'b00:	
					case (right_xor_key_segment_din[1:4])
						4'd0:	sbox_dout = 4'd4;
						4'd1:	sbox_dout = 4'd11;
						4'd2:	sbox_dout = 4'd2;
						4'd3:	sbox_dout = 4'd14;
						4'd4:	sbox_dout = 4'd15;
						4'd5:	sbox_dout = 4'd0;
						4'd6:	sbox_dout = 4'd8;
						4'd7:	sbox_dout = 4'd13;
						4'd8:	sbox_dout = 4'd3;
						4'd9:	sbox_dout = 4'd12;
						4'd10:	sbox_dout = 4'd9;
						4'd11:	sbox_dout = 4'd7;
						4'd12:	sbox_dout = 4'd5;
						4'd13:	sbox_dout = 4'd10;
						4'd14:	sbox_dout = 4'd6;
						4'd15:	sbox_dout = 4'd1;
					endcase
			2'b01:
					case (right_xor_key_segment_din[1:4])
						4'd0:	sbox_dout = 4'd13;
						4'd1:	sbox_dout = 4'd0;
						4'd2:	sbox_dout = 4'd11;
						4'd3:	sbox_dout = 4'd7;
						4'd4:	sbox_dout = 4'd4;
						4'd5:	sbox_dout = 4'd9;
						4'd6:	sbox_dout = 4'd1;
						4'd7:	sbox_dout = 4'd10;
						4'd8:	sbox_dout = 4'd14;
						4'd9:	sbox_dout = 4'd3;
						4'd10:	sbox_dout = 4'd5;
						4'd11:	sbox_dout = 4'd12;
						4'd12:	sbox_dout = 4'd2;
						4'd13:	sbox_dout = 4'd15;
						4'd14:	sbox_dout = 4'd8;
						4'd15:	sbox_dout = 4'd6;
					endcase
			2'b10:
					case (right_xor_key_segment_din[1:4])
						4'd0:	sbox_dout = 4'd1;
						4'd1:	sbox_dout = 4'd4;
						4'd2:	sbox_dout = 4'd11;
						4'd3:	sbox_dout = 4'd13;
						4'd4:	sbox_dout = 4'd12;
						4'd5:	sbox_dout = 4'd3;
						4'd6:	sbox_dout = 4'd7;
						4'd7:	sbox_dout = 4'd14;
						4'd8:	sbox_dout = 4'd10;
						4'd9:	sbox_dout = 4'd15;
						4'd10:	sbox_dout = 4'd6;
						4'd11:	sbox_dout = 4'd8;
						4'd12:	sbox_dout = 4'd0;
						4'd13:	sbox_dout = 4'd5;
						4'd14:	sbox_dout = 4'd9;
						4'd15:	sbox_dout = 4'd2;
					endcase
			2'b11:
					case (right_xor_key_segment_din[1:4])
						4'd0:	sbox_dout = 4'd6;
						4'd1:	sbox_dout = 4'd11;
						4'd2:	sbox_dout = 4'd13;
						4'd3:	sbox_dout = 4'd8;
						4'd4:	sbox_dout = 4'd1;
						4'd5:	sbox_dout = 4'd4;
						4'd6:	sbox_dout = 4'd10;
						4'd7:	sbox_dout = 4'd7;
						4'd8:	sbox_dout = 4'd9;
						4'd9:	sbox_dout = 4'd5;
						4'd10:	sbox_dout = 4'd0;
						4'd11:	sbox_dout = 4'd15;
						4'd12:	sbox_dout = 4'd14;
						4'd13:	sbox_dout = 4'd2;
						4'd14:	sbox_dout = 4'd3;
						4'd15:	sbox_dout = 4'd12;
					endcase
		endcase 
endmodule