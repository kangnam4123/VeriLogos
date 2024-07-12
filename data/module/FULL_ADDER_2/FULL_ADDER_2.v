module FULL_ADDER_2 ( DATA_A, DATA_B, DATA_C, SAVE, CARRY );
input  DATA_A;
input  DATA_B;
input  DATA_C;
output SAVE;
output CARRY;
   wire TMP;
   assign TMP = DATA_A ^ DATA_B;
   assign SAVE = TMP ^ DATA_C;
   assign CARRY =  ~ (( ~ (TMP & DATA_C)) & ( ~ (DATA_A & DATA_B)));
endmodule