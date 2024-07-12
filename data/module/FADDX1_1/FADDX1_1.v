module FADDX1_1 (A,B,CI,CO,S);
 input A;
 input B;
 input CI;
 output CO;
 output S;
 reg CO,S;
 always @ (A or B or CI)
 begin
 {CO,S} <= A + B + CI;
 end
endmodule