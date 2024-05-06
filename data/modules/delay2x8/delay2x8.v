module delay2x8 (datain, dataout, clk);
    input[2 - 1:0] datain; 
    output[2 - 1:0] dataout; 
    wire[2 - 1:0] dataout;
    input clk; 
    reg[2 - 1:0] buff0; 
    reg[2 - 1:0] buff1; 
    reg[2 - 1:0] buff2; 
    reg[2 - 1:0] buff3; 
    reg[2 - 1:0] buff4; 
    reg[2 - 1:0] buff5; 
    reg[2 - 1:0] buff6; 
    reg[2 - 1:0] buff7; 
    assign dataout = buff7 ;
    always @(posedge clk)
    begin
       buff0 <= datain ; 
		buff1 <= buff0;
		buff2 <= buff1;
		buff3 <= buff2;
		buff4 <= buff3;
		buff5 <= buff4;
		buff6 <= buff5;
		buff7 <= buff6;
    end 
 endmodule