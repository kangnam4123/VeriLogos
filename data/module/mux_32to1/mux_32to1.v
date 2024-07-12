module mux_32to1 (
  input  [4:0] s,
  input  i31, i30, i29, i28, i27, i26, i25, i24, i23,i22, i21, i20, i19, i18, i17, i16,
  input  i15, i14, i13, i12, i11, i10, i9, i8, i7,i6, i5, i4, i3, i2, i1, i0,
  output z);
wire int0 , int1 , int2 , int3 , int4 , int5 , int6 , int7; 
wire int8 , int9 , int10, int11, int12, int13, int14, int15;
not (s0_bar, s[0]);
not (s1_bar, s[1]);
not (s2_bar, s[2]);
not (s3_bar, s[3]);
not (s4_bar, s[4]);
and(int0 , i0 , s4_bar, s3_bar , s2_bar , s1_bar , s0_bar );
and(int1 , i1 , s4_bar, s3_bar , s2_bar , s1_bar , s[0]   );
and(int2 , i2 , s4_bar, s3_bar , s2_bar , s[1]   , s0_bar );
and(int3 , i3 , s4_bar, s3_bar , s2_bar , s[1]   , s[0]   );
and(int4 , i4 , s4_bar, s3_bar , s[2]   , s1_bar , s0_bar );
and(int5 , i5 , s4_bar, s3_bar , s[2]   , s1_bar , s[0]   );
and(int6 , i6 , s4_bar, s3_bar , s[2]   , s[1]   , s0_bar );
and(int7 , i7 , s4_bar, s3_bar , s[2]   , s[1]   , s[0]   );
and(int8 , i8 , s4_bar, s[3]   , s2_bar , s1_bar , s0_bar );
and(int9 , i9 , s4_bar, s[3]   , s2_bar , s1_bar , s[0]   );
and(int10, i10, s4_bar, s[3]   , s2_bar , s[1]   , s0_bar );
and(int11, i11, s4_bar, s[3]   , s2_bar , s[1]   , s[0]   );
and(int12, i12, s4_bar, s[3]   , s[2]   , s1_bar , s0_bar );
and(int13, i13, s4_bar, s[3]   , s[2]   , s1_bar , s[0]   );
and(int14, i14, s4_bar, s[3]   , s[2]   , s[1]   , s0_bar );
and(int15, i15, s4_bar, s[3]   , s[2]   , s[1]   , s[0]   );
and(int16, i16, s[4]  ,s3_bar , s2_bar , s1_bar , s0_bar );
and(int17, i17, s[4]  ,s3_bar , s2_bar , s1_bar , s[0]   );
and(int18, i18, s[4]  ,s3_bar , s2_bar , s[1]   , s0_bar );
and(int19, i19, s[4]  ,s3_bar , s2_bar , s[1]   , s[0]   );
and(int20, i20, s[4]  ,s3_bar , s[2]   , s1_bar , s0_bar );
and(int21, i21, s[4]  ,s3_bar , s[2]   , s1_bar , s[0]   );
and(int22, i22, s[4]  ,s3_bar , s[2]   , s[1]   , s0_bar );
and(int23, i23, s[4]  ,s3_bar , s[2]   , s[1]   , s[0]   );
and(int24, i24, s[4]  ,s[3]   , s2_bar , s1_bar , s0_bar );
and(int25, i25, s[4]  ,s[3]   , s2_bar , s1_bar , s[0]   );
and(int26, i26, s[4]  ,s[3]   , s2_bar , s[1]   , s0_bar );
and(int27, i27, s[4]  ,s[3]   , s2_bar , s[1]   , s[0]   );
and(int28, i28, s[4]  ,s[3]   , s[2]   , s1_bar , s0_bar );
and(int29, i29, s[4]  ,s[3]   , s[2]   , s1_bar , s[0]   );
and(int30, i30, s[4]  ,s[3]   , s[2]   , s[1]   , s0_bar );
and(int31, i31, s[4]  ,s[3]   , s[2]   , s[1]   , s[0]   );
or (z, int31, int30, int29, int28, int27, int26, int25,
    int24, int23,int22, int21, int20, int19, int18, int17,
    int16, int0, int1, int2, int3, int4, int5, int6, int7, 
    int8, int9, int10, int11, int12, int13, int14, int15);
endmodule