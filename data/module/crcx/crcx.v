module crcx
	(
	input		pixclk,
	input		rstn,
	input		enable_crc,
	input		init_crc,
	input	[7:0]	red,
	input	[7:0]	grn,
	input	[7:0]	blu,
	output	[7:0]	misr_red,
	output	[7:0]	misr_grn,
	output	[7:0]	misr_blu
	);
reg[23:0] crc_out;
wire[23:0] crc_in ;
assign crc_in[23:16] = red[7:0] ;
assign crc_in[15: 8] = grn[7:0] ;
assign crc_in[ 7: 0] = blu[7:0] ;
     always @(posedge pixclk or negedge rstn)
        if (!rstn)
           begin     crc_out[23:0] <=  24'hFFFFFF; end
        else begin
         if (init_crc)
                 crc_out[23:0] <=  24'hFFFFFF;
         else if (enable_crc)
             begin
              crc_out[0]  <= crc_out[1]  ^ crc_in[1];
              crc_out[1]  <= crc_out[2]  ^ crc_in[2];
              crc_out[2]  <= crc_out[3]  ^ crc_in[3];
              crc_out[3]  <= crc_out[4]  ^ crc_in[4];
              crc_out[4]  <= crc_out[5]  ^ crc_in[5];
              crc_out[5]  <= crc_out[6]  ^ crc_in[6];
              crc_out[6]  <= crc_out[7]  ^ crc_in[7];
              crc_out[7]  <= crc_out[8]  ^ crc_in[8];
              crc_out[8]  <= crc_out[9]  ^ crc_in[9];
              crc_out[9]  <= crc_out[10] ^ crc_in[10];
              crc_out[10] <= crc_out[11] ^ crc_in[11];
              crc_out[11] <= crc_out[12] ^ crc_in[12];
              crc_out[12] <= crc_out[13] ^ crc_in[13];
              crc_out[13] <= crc_out[14] ^ crc_in[14];
              crc_out[14] <= crc_out[15] ^ crc_in[15];
              crc_out[15] <= crc_out[16] ^ crc_in[16];
              crc_out[16] <= crc_out[17] ^ crc_in[17] ^ crc_out[0] ^crc_in[0];
              crc_out[17] <= crc_out[18] ^ crc_in[18];
              crc_out[18] <= crc_out[19] ^ crc_in[19];
              crc_out[19] <= crc_out[20] ^ crc_in[20];
              crc_out[20] <= crc_out[21] ^ crc_in[21];
              crc_out[21] <= crc_out[22] ^ crc_in[22] ^ crc_out[0] ^ crc_in[0];
              crc_out[22] <= crc_out[23] ^ crc_in[23] ^ crc_out[0] ^ crc_in[0];
              crc_out[23] <= crc_out[0]  ^ crc_in[0];
             end
        end
assign  misr_red[7:0] = crc_out[23:16];
assign  misr_grn[7:0] = crc_out[15:8];
assign  misr_blu[7:0] = crc_out[7:0];
endmodule