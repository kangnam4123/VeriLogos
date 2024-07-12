module display_time_parameters(
    input bitA,
    input bitB,
    input bitC,
    input bitD,
    output seg_a,
    output seg_b,
    output seg_c,
    output seg_d,
    output seg_e,
    output seg_f,
    output seg_g,
	 output s_seg1,
	 output s_seg2,
	 output s_seg3,
	 output s_seg4
    );
	 assign s_seg1 = 0;
	 assign s_seg2 = 0;
	 assign s_seg3 = 1;
	 assign s_seg4 = 1;
	 assign seg_a = !((!bitB&!bitD)|(!bitA&bitC)|(!bitA&bitB&bitD)|(bitB&bitC)|(bitA&!bitD)|(bitA&!bitB&!bitC));
	 assign seg_b = !((bitA&!bitC&bitD)|(!bitB&!bitD)|(!bitA&!bitC&!bitD)|(!bitA&bitC&bitD)|(!bitA&!bitB));
	 assign seg_c = !((!bitC&bitD)|(!bitA&bitB)|(bitA&!bitB)|(!bitA&!bitC)|(!bitA&bitD));
	 assign seg_d = !((bitB&!bitC&bitD)|(!bitB&bitC&bitD)|(bitB&bitC&!bitD)|(bitA&!bitC)|(!bitA&!bitB&!bitD));
	 assign seg_e = !((!bitB&!bitD)|(bitC&!bitD)|(bitA&bitC)|(bitA&bitB));
	 assign seg_f = !((!bitC&!bitD)|(bitB&!bitD)|(!bitA&bitB&!bitC)|(bitA&!bitB)|(bitA&bitC));
	 assign seg_g = !((!bitB&bitC)|(bitA&!bitB)|(bitA&bitD)|(bitC&!bitD)|(!bitA&bitB&!bitC));
endmodule