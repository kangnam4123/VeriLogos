module top_1243 (
    input             clk,      
    input             btnC,     
    input             btnU,
    input             btnD,
    input             btnR,
    input             btnL,
    input      [15:0] sw,       
    output reg [15:0] led,      
    output reg  [6:0] seg,      
    output reg        dp,       
    output reg  [3:0] an        
);
    initial seg = 7'b1111111;   
    initial an = 4'b0000;       
    initial dp = 0;             
    always @(sw) begin          
        led <= sw;
    end
    always @(btnC or btnU or btnD or btnR or btnL) begin
        seg[0] <= ~btnU;
        seg[1] <= ~btnR;
        seg[2] <= ~btnR;
        seg[3] <= ~btnD;
        seg[4] <= ~btnL;
        seg[5] <= ~btnL;
        seg[6] <= ~btnC;
        dp <= btnU | btnL | btnC | btnR | btnD;
    end
endmodule