module concat16_2 ( string16, string32 );
  input [15:0] string16;
  output [31:0] string32;
  wire   \string16[15] , \string16[14] , \string16[13] , \string16[12] ,
         \string16[11] , \string16[10] , \string16[9] , \string16[8] ,
         \string16[7] , \string16[6] , \string16[5] , \string16[4] ,
         \string16[3] , \string16[2] , \string16[1] , \string16[0] ;
  assign string32[0] = 1'b0;
  assign string32[1] = 1'b0;
  assign string32[2] = 1'b0;
  assign string32[3] = 1'b0;
  assign string32[4] = 1'b0;
  assign string32[5] = 1'b0;
  assign string32[6] = 1'b0;
  assign string32[7] = 1'b0;
  assign string32[8] = 1'b0;
  assign string32[9] = 1'b0;
  assign string32[10] = 1'b0;
  assign string32[11] = 1'b0;
  assign string32[12] = 1'b0;
  assign string32[13] = 1'b0;
  assign string32[14] = 1'b0;
  assign string32[15] = 1'b0;
  assign string32[31] = \string16[15] ;
  assign \string16[15]  = string16[15];
  assign string32[30] = \string16[14] ;
  assign \string16[14]  = string16[14];
  assign string32[29] = \string16[13] ;
  assign \string16[13]  = string16[13];
  assign string32[28] = \string16[12] ;
  assign \string16[12]  = string16[12];
  assign string32[27] = \string16[11] ;
  assign \string16[11]  = string16[11];
  assign string32[26] = \string16[10] ;
  assign \string16[10]  = string16[10];
  assign string32[25] = \string16[9] ;
  assign \string16[9]  = string16[9];
  assign string32[24] = \string16[8] ;
  assign \string16[8]  = string16[8];
  assign string32[23] = \string16[7] ;
  assign \string16[7]  = string16[7];
  assign string32[22] = \string16[6] ;
  assign \string16[6]  = string16[6];
  assign string32[21] = \string16[5] ;
  assign \string16[5]  = string16[5];
  assign string32[20] = \string16[4] ;
  assign \string16[4]  = string16[4];
  assign string32[19] = \string16[3] ;
  assign \string16[3]  = string16[3];
  assign string32[18] = \string16[2] ;
  assign \string16[2]  = string16[2];
  assign string32[17] = \string16[1] ;
  assign \string16[1]  = string16[1];
  assign string32[16] = \string16[0] ;
  assign \string16[0]  = string16[0];
endmodule