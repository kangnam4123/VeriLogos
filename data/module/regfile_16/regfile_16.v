module regfile_16 #(parameter WIDTH=32,REGBITS=5)
      (input clk,
      input reset,
      input regwrite,
      input [REGBITS-1:0] ra1,ra2,wa,
      input [WIDTH-1:0] wd,
      output [WIDTH-1:0] rd1,rd2,rd3,rd4,
            input [15:0]SW,
            input [4:0]btn);
    reg [WIDTH-1:0] RAM2 [(1<<REGBITS)-1:0];
    initial
    begin
	    RAM2[0] <= 32'b00000000000000000000000000000000;
        RAM2[15] <= 32'b00000000000000001010101010101010;    
        RAM2[16] <= 32'b00000000000000001000100010001000;    
    end
    always @(posedge clk)
        begin
            if(btn[1]==1) RAM2[8]=8;
            else if(btn[0]==1)  RAM2[8]=16;
            else if(btn[2]==1)  RAM2[8]=4;
            else if(btn[3]==1)  RAM2[8]=2;
            else if(btn[4]==1)  RAM2[8]=1;
            else    RAM2[8]=0;
            RAM2[14][15:0]=SW[15:0];
            if(regwrite)
                RAM2[wa]<=wd;
        end
    assign rd1 = ra1 ? RAM2[ra1]:0;     
    assign rd2 = ra2 ? RAM2[ra2]:0;
    assign rd3 = RAM2[16];      
    assign rd4 = RAM2[15];      
endmodule