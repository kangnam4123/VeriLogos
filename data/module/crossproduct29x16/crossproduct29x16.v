module crossproduct29x16 (Ax, Ay, Az, Bx, By, Bz, Cx, Cy, Cz, clk);
    input[29 - 1:0] Ax; 
    input[29 - 1:0] Ay; 
    input[29 - 1:0] Az; 
    input[16 - 1:0] Bx; 
    input[16 - 1:0] By; 
    input[16 - 1:0] Bz; 
    output[29 + 16:0] Cx; 
    reg[29 + 16:0] Cx;
    output[29 + 16:0] Cy; 
    reg[29 + 16:0] Cy;
    output[29 + 16:0] Cz; 
    reg[29 + 16:0] Cz;
    input clk; 
    reg[29 + 16 - 1:0] AyBz; 
    reg[29 + 16 - 1:0] AzBy; 
    reg[29 + 16 - 1:0] AzBx; 
    reg[29 + 16 - 1:0] AxBz; 
    reg[29 + 16 - 1:0] AxBy; 
    reg[29 + 16 - 1:0] AyBx; 
    always @(posedge clk)
    begin
       AyBz <= Ay * Bz ; 
       AzBy <= Az * By ; 
       AzBx <= Az * Bx ; 
       AxBz <= Ax * Bz ; 
       AxBy <= Ax * By ; 
       AyBx <= Ay * Bx ; 
       Cx <= ({AyBz[29 + 16 - 1], AyBz}) - ({AzBy[29 + 16 - 1], AzBy}) ; 
       Cy <= ({AzBx[29 + 16 - 1], AzBx}) - ({AxBz[29 + 16 - 1], AxBz}) ; 
       Cz <= ({AxBy[29 + 16 - 1], AxBy}) - ({AyBx[29 + 16 - 1], AyBx}) ;  
    end 
 endmodule