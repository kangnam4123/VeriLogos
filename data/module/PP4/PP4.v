module PP4(X0, X1, X2, X3, Y0, Y1, Y2, Y3, P0, P1, P2, 
        P3);
input   X0;
input   X1;
input   X2;
input   X3;
input   Y0;
input   Y1;
input   Y2;
input   Y3;
output  P0;
output  P1;
output  P2;
output  P3;
nor g0(P0, X0, Y3);
nor g1(P1, X1, Y2);
nor g2(P2, X2, Y1);
nor g3(P3, X3, Y0);
endmodule