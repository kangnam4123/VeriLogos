module mc_mff_key
  #(parameter BYTES = 4)
  (
   input [(BYTES*8)-1:0]     	data_in,
   input [31:0]     		key_in,
   input [1:0]      		pix,
   input [2:0]      		kcnt,
   input [BYTES-1:0]         	mask_in,
   output reg [BYTES-1:0] 	key_mask
   );
   reg [BYTES-1:0]	key_mask_tmp1;
   reg [BYTES-1:0]	key_mask_tmp2;
  always @* begin
    casex(pix)
      2'b00: 
      begin
        key_mask_tmp1[0]   = (data_in[7:0]   == key_in[7:0]);
        key_mask_tmp1[1]   = (data_in[15:8]  == key_in[7:0]);
        key_mask_tmp1[2]   = (data_in[23:16] == key_in[7:0]);
        key_mask_tmp1[3]   = (data_in[31:24] == key_in[7:0]);
	if((BYTES == 16) || (BYTES == 8)) begin
        	key_mask_tmp1[4]   = (data_in[39:32] == key_in[7:0]);
        	key_mask_tmp1[5]   = (data_in[47:40] == key_in[7:0]);
        	key_mask_tmp1[6]   = (data_in[55:48] == key_in[7:0]);
        	key_mask_tmp1[7]   = (data_in[63:56] == key_in[7:0]);
	end
	if(BYTES == 16) begin
        	key_mask_tmp1[8]  = (data_in[71:64]   == key_in[7:0]);
        	key_mask_tmp1[9]  = (data_in[79:72]   == key_in[7:0]);
        	key_mask_tmp1[10] = (data_in[87:80]   == key_in[7:0]);
        	key_mask_tmp1[11] = (data_in[95:88]   == key_in[7:0]);
        	key_mask_tmp1[12] = (data_in[103:96]  == key_in[7:0]);
        	key_mask_tmp1[13] = (data_in[111:104] == key_in[7:0]);
        	key_mask_tmp1[14] = (data_in[119:112] == key_in[7:0]);
        	key_mask_tmp1[15] = (data_in[127:120] == key_in[7:0]);
	end
      end
      2'bx1: begin
        key_mask_tmp1[1:0] = (data_in[15:0]  == key_in[15:0]) ? 2'b11 : 2'b00;
        key_mask_tmp1[3:2] = (data_in[31:16] == key_in[15:0]) ? 2'b11 : 2'b00;
	if((BYTES == 16) || (BYTES == 8)) begin
        	key_mask_tmp1[5:4] = (data_in[47:32] == key_in[15:0]) ? 2'b11 : 2'b00;
        	key_mask_tmp1[7:6] = (data_in[63:48] == key_in[15:0]) ? 2'b11 : 2'b00;
	end
	if(BYTES == 16) begin
        	key_mask_tmp1[9:8]   = (data_in[79:64]   == key_in[15:0]) ? 2'b11 : 2'b00;
        	key_mask_tmp1[11:10] = (data_in[95:80]   == key_in[15:0]) ? 2'b11 : 2'b00;
        	key_mask_tmp1[13:12] = (data_in[111:96]  == key_in[15:0]) ? 2'b11 : 2'b00;
        	key_mask_tmp1[15:14] = (data_in[127:112] == key_in[15:0]) ? 2'b11 : 2'b00;
	end
      end
      2'b10: begin
        key_mask_tmp1[3:0] = (data_in[23:0]  == key_in[23:0]) ? 4'b1111 : 4'b0000;
	if((BYTES == 16) || (BYTES == 8)) begin
        	key_mask_tmp1[7:4] = (data_in[55:32]  == key_in[23:0]) ? 4'b1111 : 4'b0000;
	end
	if(BYTES == 16) begin
        	key_mask_tmp1[11:8] = (data_in[87:64]  == key_in[23:0]) ? 4'b1111 : 4'b0000;
        	key_mask_tmp1[15:12] = (data_in[119:96] == key_in[23:0]) ? 4'b1111 : 4'b0000;
	end
      end
      default: begin
        key_mask_tmp1[3:0] = 4'b0000;
	if((BYTES == 16) || (BYTES == 8)) key_mask_tmp1[7:4] = 4'b0000;
	if(BYTES == 16) key_mask_tmp1[15:8] = 8'b00000000;
      end
    endcase 
    key_mask_tmp2 = !kcnt[1] ? key_mask_tmp1 : ~key_mask_tmp1;
   key_mask[3:0]  = mask_in[3:0] | {4{(kcnt[2] & kcnt[0])}} & key_mask_tmp2[3:0];
   if((BYTES == 16) || (BYTES == 8)) key_mask[7:4] = mask_in[7:4] | {4{(kcnt[2] & kcnt[0])}} & key_mask_tmp2[7:4];
   if(BYTES == 16) key_mask[15:8] = mask_in[15:8] | {8{(kcnt[2] & kcnt[0])}} & key_mask_tmp2[15:8];
  end 
endmodule