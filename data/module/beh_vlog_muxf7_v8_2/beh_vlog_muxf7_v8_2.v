module beh_vlog_muxf7_v8_2 (O, I0, I1, S);
    output O;
    reg    O;
    input  I0, I1, S;
	always @(I0 or I1 or S) 
	    if (S)
		O = I1;
	    else
		O = I0;
endmodule