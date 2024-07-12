module vectdelay16x1 (xin, yin, zin, xout, yout, zout, clk);
    input[16 - 1:0] xin; 
    input[16 - 1:0] yin; 
    input[16 - 1:0] zin; 
    output[16 - 1:0] xout; 
    wire[16 - 1:0] xout;
    output[16 - 1:0] yout; 
    wire[16 - 1:0] yout;
    output[16 - 1:0] zout; 
    wire[16 - 1:0] zout;
    input clk; 
    reg[16 - 1:0] bufferx0; 
    reg[16 - 1:0] buffery0; 
    reg[16 - 1:0] bufferz0; 
    assign xout = bufferx0 ;
    assign yout = buffery0 ;
    assign zout = bufferz0 ;
    always @(posedge clk)
    begin
       bufferx0 <= xin ; 
       buffery0 <= yin ; 
       bufferz0 <= zin ; 
    end 
 endmodule