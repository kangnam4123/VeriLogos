module magcompare2b (LT, GT, A, B);
   input [1:0] A;
   input [1:0] B;
   output      LT;
   output      GT;
   assign LT = ~A[1]&B[1] | ~A[1]&~A[0]&B[0] | ~A[0]&B[1]&B[0];
   assign GT = A[1]&~B[1] | A[1]&A[0]&~B[0] | A[0]&~B[1]&~B[0];
endmodule