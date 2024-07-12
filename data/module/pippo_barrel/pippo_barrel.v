module pippo_barrel (
	shift_in,
	shift_cnt,
    insert_in, 
	mask_begin,
	mask_end, 
	shift_left,
	shift_arith,
	rotate_en, 
	mask_op, 
    shrot_out,
    shrot_ca_new
	);
input [31:0] shift_in;		
input [31:0] insert_in;		
input [4:0] shift_cnt;		
input shift_left;		    
input shift_arith;		    
input rotate_en;            
input [4:0] mask_begin;		
input [4:0] mask_end;		
input mask_op;              
output [31:0] shrot_out;
output  shrot_ca_new;
reg     [95:0]      shifted;
wire    [31:0]      insert_in;
wire    [31:0]      shift_out;
wire    [31:0]      rotate_out;
wire    [31:0]      shrot_out;
wire    [95:0]      sht_operand;
wire                fill;
assign fill = shift_in[31] & shift_arith & (!rotate_en);
assign sht_operand = {({32{fill}}), shift_in, 32'b0};
always @ (sht_operand or shift_left or shift_cnt) begin
	if (shift_left)
		shifted = sht_operand << shift_cnt;
	else
		shifted = sht_operand >> shift_cnt;
end
assign shift_out = shifted[63:32];
wire [31:0] mask_first, mask_second, mask_last;
assign mask_first[31] = mask_begin <= 5'd0; 
assign mask_first[30] = mask_begin <= 5'd1; 
assign mask_first[29] = mask_begin <= 5'd2; 
assign mask_first[28] = mask_begin <= 5'd3; 
assign mask_first[27] = mask_begin <= 5'd4; 
assign mask_first[26] = mask_begin <= 5'd5; 
assign mask_first[25] = mask_begin <= 5'd6; 
assign mask_first[24] = mask_begin <= 5'd7; 
assign mask_first[23] = mask_begin <= 5'd8; 
assign mask_first[22] = mask_begin <= 5'd9; 
assign mask_first[21] = mask_begin <= 5'd10; 
assign mask_first[20] = mask_begin <= 5'd11; 
assign mask_first[19] = mask_begin <= 5'd12; 
assign mask_first[18] = mask_begin <= 5'd13; 
assign mask_first[17] = mask_begin <= 5'd14; 
assign mask_first[16] = mask_begin <= 5'd15; 
assign mask_first[15] = mask_begin <= 5'd16; 
assign mask_first[14] = mask_begin <= 5'd17; 
assign mask_first[13] = mask_begin <= 5'd18; 
assign mask_first[12] = mask_begin <= 5'd19; 
assign mask_first[11] = mask_begin <= 5'd20; 
assign mask_first[10] = mask_begin <= 5'd21; 
assign mask_first[9] = mask_begin <= 5'd22; 
assign mask_first[8] = mask_begin <= 5'd23; 
assign mask_first[7] = mask_begin <= 5'd24; 
assign mask_first[6] = mask_begin <= 5'd25; 
assign mask_first[5] = mask_begin <= 5'd26; 
assign mask_first[4] = mask_begin <= 5'd27; 
assign mask_first[3] = mask_begin <= 5'd28; 
assign mask_first[2] = mask_begin <= 5'd29; 
assign mask_first[1] = mask_begin <= 5'd30; 
assign mask_first[0] = mask_begin <= 5'd31; 
assign mask_second[31] = mask_end >= 5'd0; 
assign mask_second[30] = mask_end >= 5'd1; 
assign mask_second[29] = mask_end >= 5'd2; 
assign mask_second[28] = mask_end >= 5'd3; 
assign mask_second[27] = mask_end >= 5'd4; 
assign mask_second[26] = mask_end >= 5'd5; 
assign mask_second[25] = mask_end >= 5'd6; 
assign mask_second[24] = mask_end >= 5'd7; 
assign mask_second[23] = mask_end >= 5'd8; 
assign mask_second[22] = mask_end >= 5'd9; 
assign mask_second[21] = mask_end >= 5'd10; 
assign mask_second[20] = mask_end >= 5'd11; 
assign mask_second[19] = mask_end >= 5'd12; 
assign mask_second[18] = mask_end >= 5'd13; 
assign mask_second[17] = mask_end >= 5'd14; 
assign mask_second[16] = mask_end >= 5'd15; 
assign mask_second[15] = mask_end >= 5'd16; 
assign mask_second[14] = mask_end >= 5'd17; 
assign mask_second[13] = mask_end >= 5'd18; 
assign mask_second[12] = mask_end >= 5'd19; 
assign mask_second[11] = mask_end >= 5'd20; 
assign mask_second[10] = mask_end >= 5'd21; 
assign mask_second[9] = mask_end >= 5'd22; 
assign mask_second[8] = mask_end >= 5'd23; 
assign mask_second[7] = mask_end >= 5'd24; 
assign mask_second[6] = mask_end >= 5'd25; 
assign mask_second[5] = mask_end >= 5'd26; 
assign mask_second[4] = mask_end >= 5'd27; 
assign mask_second[3] = mask_end >= 5'd28; 
assign mask_second[2] = mask_end >= 5'd29; 
assign mask_second[1] = mask_end >= 5'd30; 
assign mask_second[0] = mask_end >= 5'd31; 
assign mask_select = (mask_begin < mask_end);
assign mask_last = mask_select ? (mask_first & mask_second) : (mask_first | mask_second); 
wire    [31:0]  mask_and_out;
wire    [31:0]  mask_insert_out;
assign mask_and_out = (shifted[63:32] | shifted[95:64]) & mask_last;
assign mask_insert_out = ((shifted[63:32] | shifted[95:64]) & mask_last) |
                     (insert_in & ~mask_last);
assign rotate_out = mask_op ? mask_and_out : mask_insert_out;
assign shrot_out = rotate_en ? rotate_out : shift_out;
assign shrot_ca_new = shift_in[31] & (|shifted[31:0]) & shift_arith; 
endmodule